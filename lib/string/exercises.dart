part of '../string.dart';

// q4 (doesn't actually work- how is the algorithm meant to work?)

class _ComputeMinimumSubstring {
  final Tree tree;

  int d = -1;
  int k = -1;

  _ComputeMinimumSubstring(this.tree);

  void compute([_TreeNode? node]) {
    node ??= tree.root;
    final depth = node.length;
    node.children.forEach((key, child) {
      if (child.isLeaf && child.length > 1) {
        if (d <= 0 || depth < d) {
          d = depth;
          k = child.suffixes.first;
        }
      } else if (!child.isLeaf) {
        compute(child);
      }
    });
  }
}

/// Given a [string], computes the shortest substring that is unique.
/// 
/// DOESN'T WORK!
String computeMinimumSubstring(String string) {
  final tree = Tree.suffixTree(string);
  final computer = _ComputeMinimumSubstring(tree);
  computer.compute();
  return string.substring(computer.k, computer.k + computer.d);
}

// q5

/// Given a string, reorders it so that the amongst all the reorderings of the string,
/// this is the one that is considered the smallest with respect to the lexical ordering (i.e. a < b < c < ..)
String reorderForShortest(String string) {
  final tree = Tree.suffixTree(string + string);
  var node = tree.root;
  
  final buffer = StringBuffer();
  var i = 0;

  while (i < string.length) {
    // go through the children of node and see which one has the smallest first lexical value
    _TreeNode? child;
    node.children.forEach((key, value) { 
      if (child == null || string.codeUnitAt(child!.leftIdx % string.length) > string.codeUnitAt(value.leftIdx % string.length)) {
        child = value;
      }
    });

    // add the new characters
    for (var j = child!.leftIdx; j < child!.rightIdx && i < string.length; j++) {
      buffer.write(string[j % string.length]);
      i++;
    }
    node = child!;
  }

  return buffer.toString();
}

// q11

class StringIndices {
  final List<int> s1Indices;
  final List<int> s2Indices;

  StringIndices(this.s1Indices, this.s2Indices);
}

StringIndices argTracebackLCSq(String s1, String s2) {
  print('Computing the LCSq of $s1 and $s2 using the classic DP table approach, with traceback');
  final table = _tableLCSq(s1, s2);
  
  final s1Pos = <int>[];
  final s2Pos = <int>[];

  var i = s1.length;
  var j = s2.length;
  while (i > 0 && j > 0) {
    print('The value i=$i and j=$j');
    if (s1[i-1] == s2[j-1]) {
      print('Match at position s1[${i-1}] and s2[${j-1}] with letter ${s1[i-1]}');
      s1Pos.add(i-1);
      s2Pos.add(j-1);
      i--;
      j--;
    } else if (table[i-1][j] == table[i][j]) {
      print('No match, value matches the upper value- decrementing i');
      i--;
    } else {
      print('No match, value matches the left value- decrementing j');
      j--;
    }
  }

  return StringIndices(s1Pos, s2Pos);
}

/// Given two strings [s1] and [s2], computes their shortest common supersequence.
/// 
/// Makes use of the longest common subsequence algorithm.
String shortestCommonSupersequence(String s1, String s2) {
  final indices = argTracebackLCSq(s1, s2);
  final buffer = StringBuffer();
  print('-----------------------------');
  print('Computing the shortest common supersequence now.');
  print('The reversed common indices in s1 are ${indices.s1Indices} and in s2 are ${indices.s2Indices}');

  // current idx in s1 and s2
  var i = 0;
  var j = 0;
  
  // idx of the next common character in s1 and s2 (in reverse)
  var commonI = indices.s1Indices.length-1;
  var commonJ = indices.s2Indices.length-1;

  // we need to add all characters from both s1 and s2
  while (i < s1.length || j < s2.length) {
    print('We are at s1 index $i, s2 index $j');
    print('The common character index for s1 is $commonI and for s2 is $commonJ');
    // s1 not completely added and we're not yet at the commonI character => add it
    if (i < s1.length && (commonI < 0 || i < indices.s1Indices[commonI])) {
      print('Adding a lone s1 character at index $i- ${s1[i]}');
      buffer.write(s1[i]);
      i++;
    }
    // same with s2
    else if (j < s2.length && (commonJ < 0 || j < indices.s2Indices[commonJ])) {
      print('Adding a lone s2 character at index $j- ${s2[j]}');
      buffer.write(s2[j]);
      j++;
    } 
    // otherwise we're at a common character in s1 and s2 => add it just once!
    else {
      print('Adding a common character at s1[$i] and s2[$j]- ${s1[i]}');
      buffer.write(s1[i]);
      i++;
      j++;
      commonI--;
      commonJ--;
    }
  }

  return buffer.toString();
}

// q12

/// Computes the n-th Fibonacci number using memoisation
int fibonacci(int n, [List<int>? values]) {
  values ??= List.filled(n, 1);
  if (n > 2) {
    values[n-1] = fibonacci(n-1, values) + fibonacci(n-2, values);
  }

  return values[n-1];
}

// q13

/// Computes the edit distance of the two strings [s1] and [s2] using the table DP method
int tableEditDistance(String s1, String s2) {
  final table = List.generate(s1.length+1, (i) => List.generate(s2.length+1, (j) => i+j));
  for (var i = 0; i < s1.length; i++) {
    for (var j = 0; j < s2.length; j++) {
      if (s1[i] == s2[j]) {
        table[i+1][j+1] = table[i][j];
      } else {
        table[i+1][j+1] = 1 + min(min(table[i][j], table[i][j+1]), table[i+1][j]);
      }
    }
  }

  return table[s1.length][s2.length];
}

/// Computes the edit distance of the two strings [s1] and [s2] using memoisation
int memoisedEditDistance(String s1, String s2, [List<List<int>>? table, int? m, int? n]) {
  m ??= s1.length;
  n ??= s2.length;
  table ??= List.generate(s1.length+1, (i) => List.filled(s2.length+1, -1));

  if (table[m][n] == -1) {
    if (m == 0 || n == 0) {
      table[m][n] = m + n;
    } else if (s1[m-1] == s2[n-1]) {
      table[m][n] = memoisedEditDistance(s1, s2, table, m-1, n-1);
    } else {
      table[m][n] = 1 + min(min(
        memoisedEditDistance(s1, s2, table, m-1, n-1),
        memoisedEditDistance(s1, s2, table, m-1, n)
      ), memoisedEditDistance(s1, s2, table, m, n-1));
    }
  }

  return table[m][n];
}

// q15

/// Given strings [s1] and [s2], returns a minimum similar string.
/// 
/// TODO: Implement maximum, and get all of them 
/// (keep track of maximum ones and see if they are minimal as well)
int getMinSimilarString(String s1, String s2) {
  final tableData = _tableSmithWaterman(s1, s2);
  final table = tableData.table;
  final maxTable = List.generate(s1.length+1, (i) => List.filled(s2.length+1, 0));
  
  var x1 = 0;
  var y1 = 0;
  var maxValue = -1;
  
  for (var i = 0; i < s1.length; i++) {
    for (var j = 0; j < s2.length; j++) {
      if (table[i+1][j+1] != 0) {
        if (s1[i] == s2[j]) {
          maxTable[i+1][j+1] = max(table[i][j], maxTable[i][j]);
        } else {
          final maxInTable = max(table[i][j], max(table[i+1][j], table[i][j+1]));
          final maxInMaxTable = max(maxTable[i][j], max(maxTable[i+1][j], maxTable[i][j+1]));
          maxTable[i+1][j+1] = max(maxInTable, maxInMaxTable);
        }
        if (table[i+1][j+1] > maxValue && maxTable[i+1][j+1] < table[i+1][j+1]) {
          x1 = i+1;
          y1 = j+1;
          maxValue = table[i+1][j+1];
        }
      }
    }
  }
  
  var x0 = x1;
  var y0 = y1;
  print('x0 = $x0 and y0 = $y0');

  while (table[x0][y0] > 0) {
    print(table[x0][y0]);
    if (s1[x0-1] == s2[y0-1] || table[x0][y0] == table[x0-1][y0-1] - 1) {
      x0--;
      y0--;
    } else if (table[x0][y0] == table[x0][y0-1] - 1) {
      y0--;
    } else {
      x0--;
    }
  }
  
  print('The extent is s1[$x0..$x1] and s2[$y0..$y1]');
  
  return tableData.maxLen;
}
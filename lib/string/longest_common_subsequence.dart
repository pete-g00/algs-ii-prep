part of '../string.dart';

List<List<int>> _tableLCSq(String s1, String s2) {
  final table = List.generate(s1.length+1, (index) => List.filled(s2.length+1, 0));

  for (var i=1; i < s1.length+1; i++) {
    print('Filling row $i');
    for (var j=1; j < s2.length+1; j++) {
      if (s1[i-1] == s2[j-1]) {
        table[i][j] = 1 + table[i-1][j-1];
      } else {
        table[i][j] = max(table[i-1][j], table[i][j-1]);
      }
    }
    print('The row is ${table[i]}');
  }
  print('The final table is: ');
  prettyPrint(table);
  print('So, the LCSq has length ${table[s1.length][s2.length]}');
  
  return table;
}

/// Computes the LCSq for a string with O(mn) space and time complexity
int tableLCSq(String s1, String s2) {
  print('Computing the LCSq of $s1 and $s2 using the classic DP table approach');
  final table = _tableLCSq(s1, s2);
  return table[s1.length][s2.length];
}

String tracebackLCSq(String s1, String s2) {
  print('Computing the LCSq of $s1 and $s2 using the classic DP table approach, with traceback');
  final table = _tableLCSq(s1, s2);
  
  final s1Pos = <int>[];
  var i = s1.length;
  var j = s2.length;
  while (i > 0 && j > 0) {
    print('The value i=$i and j=$j');
    if (s1[i-1] == s2[j-1]) {
      print('Match at position s1[${i-1}] and s2[${j-1}] with letter ${s1[i-1]}');
      s1Pos.add(i-1);
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

  final buffer = StringBuffer();
  for (var k=s1Pos.length-1; k >= 0; k--) {
    buffer.write(s1[s1Pos[k]]);
  }

  return buffer.toString();
}

/// Computes the LCSq for a string with O(n) space and O(mn) time complexity
int rowLCSq(String s1, String s2) {
  print('Computing the LCSq of $s1 and $s2 using the DP approach, but only keeping track of the last row and the previous diagonal value');
  final row = List.filled(s2.length+1, 0);
  var diagonalValue = 0;

  for (var i = 1; i < s1.length+1; i++) {
    print('Filling row $i');
    for (var j = 1; j < s2.length+1; j++) {
      final temp = row[j];
      if (s1[i-1] == s2[j-1]) {
        row[j] = 1 + diagonalValue;
      } else {
        row[j] = max(row[j], row[j-1]);
      }
      diagonalValue = temp;
    }
    diagonalValue = 0;
    print('The row is $row');
  }

  print('So, the LCSq is ${row[s2.length]}');

  return row[s2.length];
}

int _tableMemoisedLCSq(String s1, String s2, int i, int j, List<List<int>> values) {
  print('Computing the value of the table at index ($i, $j)');
  if (values[i][j] == -1) {
    if (i == 0 || j == 0) {
      values[i][j] = 0;
    } else if (s1[i-1] == s2[j-1]) {
      values[i][j] = 1 + _tableMemoisedLCSq(s1, s2, i-1, j-1, values);
    } else {
      values[i][j] = max(
        _tableMemoisedLCSq(s1, s2, i-1, j, values),
        _tableMemoisedLCSq(s1, s2, i, j-1, values)
      );
    }
  }

  return values[i][j];
}

/// Memoised LCSq with a table of values represented. All values are still initialised.
int tableMemoisedLCSq(String s1, String s2) {
  print('Computing the LCSq of $s1 and $s2, using a memoised approach (with initial value -1)');
  List<List<int>> values = List.generate(s1.length+1, (index) => List.filled(s2.length+1, -1));
  
  _tableMemoisedLCSq(s1, s2, s1.length, s2.length, values);
  print('Computed all the required values. The table is:');
  prettyPrint(values);
  print('So, the LCSq is ${values[s1.length][s2.length]}');

  return values[s1.length][s2.length];
}

int _getIndex(int i, int j, int row) => i*row + j;

int _spaceMemoisedLCSq(String s1, String s2, int i, int j, List<List<int?>> values, List<List<int>> pointers, List<int> placedValues) {
  final idx = _getIndex(i, j, s2.length+1);
  print('Computing the value of the table at index ($i, $j) = $idx');
  var isValPresent = false;
  
  if (pointers[i][j] >= 0 && pointers[i][j] <= placedValues.length) {
    final location = pointers[i][j];
    print('we have pointers[$i][$j] = $location and placedValues[$location] = ${placedValues[location]}');
    isValPresent = placedValues[location] == idx;
  }

  if (!isValPresent) {
    if (i == 0 || j == 0) {
      values[i][j] = 0;
    } else if (s1[i-1] == s2[j-1]) {
      values[i][j] = 1 + _spaceMemoisedLCSq(s1, s2, i-1, j-1, values, pointers, placedValues);
    } else {
      values[i][j] = max(
        _spaceMemoisedLCSq(s1, s2, i-1, j, values, pointers, placedValues),
        _spaceMemoisedLCSq(s1, s2, i, j-1, values, pointers, placedValues)
      );
    }

    pointers[i][j] = placedValues.length;
    placedValues.add(idx);
    print(placedValues);
  }

  return values[i][j]!;
}

/// Memoised LCSq with a table of values represented. All values initially initialised to null
int spaceMemoisedLCSq(String s1, String s2) {
  print('Computing the LCSq of $s1 and $s2, using a memoised approach (with initial value null)');
  final values = List.generate(s1.length+1, (index) => List<int?>.filled(s2.length+1, null));
  final pointers = List.generate(s1.length+1, (index) => List.filled(s2.length+1, -1));
  final placedValues = <int>[];

  _spaceMemoisedLCSq(s1, s2, s1.length, s2.length, values, pointers, placedValues);
  print('The final table of values is: ');
  prettyPrint(values);
  print('The final list of pointers (for the table) is: ');
  prettyPrint(pointers);
  print('The final list of pointers (of values wrt table) is:');
  print(placedValues);
  print('So, the LCSq is ${values[s1.length][s2.length]}');

  return values[s1.length][s2.length]!;
}

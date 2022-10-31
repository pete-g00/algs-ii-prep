part of '../string.dart';

// Computes the longest common substring in O(mn) time and space
String tableLCSt(String s1, String s2) {
  print('Computing the LCSt of $s1 and $s2 using the classic DP table approach');
  final values = List.generate(s1.length+1, (index) => List.filled(s2.length+1, 0));
  
  // main values + keep track of max length & pos at s1
  var s1Pos = 0;
  var s2Pos = 0;
  var maxLen = 0;
  for (var i = 1; i < s1.length+1; i++) {
    print('Computing the values at row $i');
    for (var j = 1; j < s2.length+1; j++) {
      if (s1[i-1] == s2[j-1]) {
        values[i][j] = 1 + values[i-1][j-1];
        
        // improve best value if possible
        if (values[i][j] > maxLen) {
          s1Pos = i-1;
          s2Pos = j-1;
          maxLen = values[i][j];
          print('Found a longer common substring- ${s1.substring(s1Pos-maxLen+1, s1Pos+1)}');
        }
      } else {
        values[i][j] = 0;
      }
    }
    print('The row is: ${values[i]}');
  }

  print('The longest common substring is- ${s1.substring(s1Pos-maxLen+1, s1Pos+1)} at position $s1Pos in s1 and position $s2Pos in s2 with length $maxLen');

  return s1.substring(s1Pos-maxLen+1, s1Pos+1);
}

String rowLCSt(String s1, String s2) {
  print('Computing the LCSt of $s1 and $s2 using the DP approach, but only keeping track of the last row and the previous diagonal value');
  final row = List.filled(s2.length+1, 0);
  var diagonal = 0;

  // main values + keep track of max length & pos at s1
  var s1Pos = 0;
  var maxLen = 0;
  for (var i = 1; i < s1.length+1; i++) {
    print('Computing row $i');
    for (var j = 1; j < s2.length+1; j++) {
      final temp = row[j];
      if (s1[i-1] == s2[j-1]) {
        row[j] = 1 + diagonal;
        
        // improve best value if possible
        if (row[j] > maxLen) {
          s1Pos = i-1;
          maxLen = row[j];
          print('Found a longer common substring- ${s1.substring(s1Pos-maxLen+1, s1Pos+1)}');
        }
      } else {
        row[j] = 0;
      }
      diagonal = temp;
    }
    print('The row is: $row');
    diagonal = 0;
  }
  
  print('The longest common substring is- ${s1.substring(s1Pos-maxLen+1, s1Pos+1)}');

  return s1.substring(s1Pos-maxLen+1, s1Pos+1);
}

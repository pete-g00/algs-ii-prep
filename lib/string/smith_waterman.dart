part of '../string.dart';

int tableSmithWaterman(String s1, String s2) {
  final table = List.generate(s1.length+1, (index) => List.filled(s2.length+1, 0));
  var maxLen = 0;
  var x1 = 0;
  var y1 = 0;
  
  for (var i = 1; i < s1.length+1; i++) {
    for (var j = 1; j < s2.length+1; j++) {
      if (s1[i-1] == s2[j-1]) {
        table[i][j] = 1 + table[i-1][j-1];
        if (table[i][j] > maxLen) {
          maxLen = table[i][j];
          x1 = i;
          y1 = j;
        }
      } else {
        table[i][j] = max(max(table[i-1][j-1], max(table[i][j-1], table[i-1][j])) - 1, 0);
      }
    }
  }
  
  _latexPrint(table);
  var x0 = x1;
  var y0 = y1;

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
  
  return maxLen;
}

int rowSmithWaterman(String s1, String s2) {
  final row = List.filled(s2.length+1, 0);
  final xs = List.filled(s2.length+1, 0);
  final ys = List.generate(s2.length+1, (j) => j);
  
  var diag = 0;
  var xDiag = 0;
  var yDiag = 0;

  var maxLen = 0;
  var x0 = 0;
  var y0 = 0;
  var x1 = 0;
  var y1 = 0;

  _latexPrint([row]);
  _latexPrintTuple([ys], [xs]);

  for (var i=1; i<s1.length+1; i++) {
    for (var j=1; j<s2.length+1; j++) {
      final temp = row[j];
      final xTemp = xs[j];
      final yTemp = ys[j];

      if (s1[i-1] == s2[j-1]) {
        row[j] = 1 + diag;
        xs[j] = xDiag;
        ys[j] = yDiag;

        if (row[j] > maxLen) {
          maxLen = row[j];
          x0 = xs[j];
          y0 = ys[j];
          x1 = i;
          y1 = j;
        }
      } else {
        final maxVal = max(diag, max(row[j-1], row[j]));
        if (maxVal <= 1) {
          row[j] = 0;
          xs[j] = i;
          ys[j] = j;
        } else {
          if (maxVal == row[j]) {
            xs[j] = xs[j];
            ys[j] = ys[j];
          } else if (maxVal == row[j-1]) {
            xs[j] = xs[j-1];
            ys[j] = ys[j-1];
          } else {
            xs[j] = xDiag;
            ys[j] = yDiag;
          }
          row[j] = maxVal - 1;
        }
      }

      diag = temp;
      xDiag = xTemp;
      yDiag = yTemp;
    }

    diag = 0;
    xDiag = i;
    yDiag = 0;
    xs[0] = i;

    _latexPrint([row]);
    _latexPrintTuple([ys], [xs]);
  }
  
  print('The extent is s1[$x0..$x1] and s2[$y0..$y1]');

  return maxLen;
}

// int tableSmithWatermanWithExtent(String s1, String s2) {
//   final table = List.generate(s1.length+1, (index) => List.filled(s2.length+1, 0));  
  
//   var maxLen = 0;
//   var x1 = 0;
//   var y1 = 0;

//   final xs = List.generate(s1.length+1, (i) => List.filled(s2.length+1, i));
//   final ys = List.generate(s1.length+1, (i) => List.generate(s2.length+1, (j) => j));
  
//   for (var i = 1; i < s1.length+1; i++) {
//     for (var j = 1; j < s2.length+1; j++) {
//       if (s1[i-1] == s2[j-1]) {
//         table[i][j] = 1 + table[i-1][j-1];
//         xs[i][j] = xs[i-1][j-1];
//         ys[i][j] = ys[i-1][j-1];

//         if (table[i][j] > maxLen) {
//           maxLen = table[i][j];
//           x1 = i;
//           y1 = j;
//         }
//       } else {
//         final maxVal = max(table[i-1][j-1], max(table[i][j-1], table[i-1][j]));
//         if (maxVal <= 1) {
//           // table[i][j] = 0;
//           xs[i][j] = i;
//           ys[i][j] = j;
//         } else {
//           table[i][j] = maxVal - 1;
//           if (maxVal == table[i-1][j]) {
//             xs[i][j] = xs[i-1][j];
//             ys[i][j] = ys[i-1][j];
//           } else if (maxVal == table[i][j-1]) {
//             xs[i][j] = xs[i][j-1];
//             ys[i][j] = ys[i][j-1];
//           } else {
//             xs[i][j] = xs[i-1][j-1];
//             ys[i][j] = ys[i-1][j-1];
//           }
//         }
//       }
//     }
//   }
  
//   _latexPrint(table);
  
//   print('The coordinates for origin is given below:');
//   _latexPrintTuple(ys, xs);

//   final x0 = xs[x1][y1];
//   final y0 = ys[x1][y1];
  
//   print('The extent is s1[$x0..$x1] and s2[$y0..$y1]');

//   return maxLen;
// }

// int rowSmithWaterman
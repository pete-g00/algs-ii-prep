import 'dart:collection';

import 'package:classes/common.dart';

int _memoisedBinomial(int i, int j, List<List<int>> values) {
  if (values[i][j] == -1) {
    if (j == 0 || i == j) {
      values[i][j] = 1;
    } else {
      values[i][j] = _memoisedBinomial(i-1, j, values) + _memoisedBinomial(i-1, j-1, values);
    }
  }

  return values[i][j];
}

int memoisedBinomial(int m, int n) {
  final values = List<List<int>>.generate(m+1, (i) => List<int>.filled(n+1, -1));
  final res = _memoisedBinomial(m, n, values);
  prettyPrint(values);

  return res;
}

class Values<A, B> {
  final A i;
  final B j;

  const Values(this.i, this.j);
}

List<List<int>> computedValues(int m, int n) {
  final values = List<List<int>>.generate(m+1, ((i) => List<int>.filled(n+1, 0)));
  final queue = Queue<Values<int, int>>();
  queue.add(Values(m, n));
  
  while (queue.isNotEmpty) {
    final value = queue.removeFirst();
    values[value.i][value.j] ++;
    if (value.i != value.j && value.j != 0) {
      queue.addFirst(Values(value.i-1, value.j));
      queue.addFirst(Values(value.i-1, value.j-1));
    }
  }

  return values;
}
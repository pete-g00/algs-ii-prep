part of '../hard.dart';

List<List<bool>> _subsetProblemTable(List<int> values, int target) {
  final matches = List.generate(values.length+1, (i) => List.filled(target+1, false));
  matches[0][0] = true;

  for (var i = 1; i <= values.length; i++) {
    for (var j = 0; j <= target; j++) {
      if (matches[i-1][j]) {
        matches[i][j] = true;
      } else if (values[i-1] <= j) {
        matches[i][j] = matches[i-1][j-values[i-1]];
      }
    }
  }

  return matches;
}

bool subsetProblemDP(List<int> values, int target) {
  final matches = _subsetProblemTable(values, target);
  prettyPrint(matches);

  return matches[values.length][target];
}

List<int>? subsetProblemDPWithTraceback(List<int> values, int target) {
  final matches = _subsetProblemTable(values, target);
  if (!matches[values.length][target]) {
    return null;
  }
  prettyPrint(matches);

  final subset = <int>[];
  // go to the top => where did this true come from (look at the line above)
  int i = values.length;
  int j = target;
  while (j > 0) {
    while (matches[i][j]) {
      print('Going up to row $i');
      i--;
    }
    subset.add(values[i]);
    j -= values[i];
    print('We don\'t have a match anymore- adding ${values[i]} to the subset and moving to column $j');
  }

  return subset;
}

// void main(List<String> args) {
//   print(
//     subsetProblemDPWithTraceback([1, 2, 4, 5], 8)
//   );
// }
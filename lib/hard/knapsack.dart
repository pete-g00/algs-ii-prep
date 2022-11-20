part of '../hard.dart';

List<List<int>> _knapsackTable(List<int> profits, List<int> weights, int capacity) {
  final table = List.generate(profits.length+1, (i) => List.filled(capacity+1, 0));

  for (var i = 1; i <= profits.length; i++) {
    for (var j = 0; j <= capacity; j++) {
      if (weights[i-1] > j) {
        table[i][j] = table[i-1][j];
      } else {
        table[i][j] = max(table[i-1][j], table[i-1][j-weights[i-1]] + profits[i-1]);
      }
    }
  }
  return table;
}

int knapsackDP(List<int> profits, List<int> weights, int capacity) {
  final table = _knapsackTable(profits, weights, capacity);
  _latexPrint(table);

  return table[profits.length][capacity];
}

List<int> knapsackWithTraceback(List<int> profits, List<int> weights, int capacity) {
  final table = _knapsackTable(profits, weights, capacity);
  _prettyPrint(table);
  
  final subset = <int>[];
  // go to the top => where did this true come from (look at the line above)
  int i = profits.length;
  int j = capacity;
  while (table[i][j] > 0) {
    while (table[i][j] == table[i-1][j]) {
      print('Going up to row $i');
      i--;
    }
    subset.add(profits[i-1]);
    j -= weights[i-1];
    print('We don\'t have a match anymore- adding the pair (${weights[i-1]}, ${profits[i-1]}) and moving to column $j');
  }

  return subset;
}

// void main(List<String> args) {
//   List<int> profits = [5, 9, 6, 7];
//   List<int> weights = [1, 3, 4, 1];
//   print(knapsackDP(profits, weights, 4));
// }
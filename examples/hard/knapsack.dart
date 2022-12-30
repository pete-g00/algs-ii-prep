import 'package:classes/hard.dart' show knapsackDP, knapsackWithTraceback;

void main(List<String> args) {
  List<int> profits = [33, 24, 11, 35, 11];
  List<int> weights = [23, 15, 15, 33, 32];
  // given profits, weights and capacity 65, compute the maximum profit
  print(knapsackDP(profits, weights, 65));
  // given profits, weights and capacity 65, compute the profits associated with each item that was taken
  print(knapsackWithTraceback(profits, weights, 65));
}
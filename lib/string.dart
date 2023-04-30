library string;

import 'dart:math' show max, min;
import 'dart:collection' show Queue;

import 'common.dart';

part 'string/longest_common_subsequence.dart';
part 'string/longest_common_substring.dart';
part 'string/ndfa.dart';
part 'string/regular_exp.dart';
part 'string/smith_waterman.dart';
part 'string/tree.dart';
part 'string/double_tree.dart';
part 'string/exercises.dart';

void main(List<String> args) {
  tableSmithWaterman("abca", "aba");
  getMinSimilarString("abca", "aba");
}

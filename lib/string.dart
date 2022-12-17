library string;

import 'dart:math' show max;
import 'dart:collection' show Queue;
// import 'package:binary_tree/binary_tree.dart';

import 'common.dart';

part 'string/longest_common_subsequence.dart';
part 'string/longest_common_substring.dart';
part 'string/ndfa.dart';
part 'string/regular_exp.dart';
// part 'string/trie_and_tree.dart';
part 'string/smith_waterman.dart';
part 'string/tree.dart';
part 'string/double_tree.dart';

void main(List<String> args) {
  final s1 = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam consectetur sapien nec viverra tincidunt. Sed gravida mauris nec porttitor porttitor. Donec sodales venenatis posuere. Nulla sed quam sit amet sem consequat dictum. Fusce commodo rutrum mi, ut vehicula diam interdum sit amet. Integer sagittis tempor metus, id tempor nunc placerat non. Etiam placerat lobortis nisl vel sollicitudin. Proin auctor, elit vel fringilla blandit, urna metus vulputate turpis, ut mollis tellus ante in turpis. Duis efficitur vel velit nec rhoncus. In ultricies lorem nunc, ut aliquam dolor dapibus eget. Integer dui nunc, dictum sed consectetur at, mattis nec dolor. Aliquam vestibulum id lacus ac fringilla. Etiam a tellus a metus eleifend semper lacinia ut dolor. Vestibulum in mollis lectus. Pellentesque quis libero mauris.';
  final s2 = 'Donec ligula ipsum, consectetur at lectus vitae, facilisis ultrices massa. Mauris nec ultrices ipsum. Etiam pellentesque magna vel sem hendrerit, dignissim iaculis augue gravida. Vestibulum ac maximus erat. Vestibulum imperdiet maximus semper. Cras condimentum ante mauris, eu viverra neque tempus vitae. Donec mattis erat id vulputate mollis. Quisque viverra sapien eget diam placerat, mollis congue nunc facilisis. Duis vel elementum odio. Morbi pellentesque eu justo vitae sollicitudin. Donec ut tellus neque. In at libero libero. Nunc eleifend molestie nibh ac luctus.';

  final tree = DoubleTree.suffixTree(s1, s2);
  print(tree.longestCommonSubstring);
}

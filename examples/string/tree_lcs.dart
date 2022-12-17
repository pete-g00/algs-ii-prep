import 'package:classes/string.dart' show DoubleTree;

void main(List<String> args) {
  final text1 = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam consectetur sapien nec viverra tincidunt. Sed gravida mauris nec porttitor porttitor. Donec sodales venenatis posuere. Nulla sed quam sit amet sem consequat dictum. Fusce commodo rutrum mi, ut vehicula diam interdum sit amet. Integer sagittis tempor metus, id tempor nunc placerat non. Etiam placerat lobortis nisl vel sollicitudin. Proin auctor, elit vel fringilla blandit, urna metus vulputate turpis, ut mollis tellus ante in turpis. Duis efficitur vel velit nec rhoncus. In ultricies lorem nunc, ut aliquam dolor dapibus eget. Integer dui nunc, dictum sed consectetur at, mattis nec dolor. Aliquam vestibulum id lacus ac fringilla. Etiam a tellus a metus eleifend semper lacinia ut dolor. Vestibulum in mollis lectus. Pellentesque quis libero mauris.';
  final text2 = 'Donec ligula ipsum, consectetur at lectus vitae, facilisis ultrices massa. Mauris nec ultrices ipsum. Etiam pellentesque magna vel sem hendrerit, dignissim iaculis augue gravida. Vestibulum ac maximus erat. Vestibulum imperdiet maximus semper. Cras condimentum ante mauris, eu viverra neque tempus vitae. Donec mattis erat id vulputate mollis. Quisque viverra sapien eget diam placerat, mollis congue nunc facilisis. Duis vel elementum odio. Morbi pellentesque eu justo vitae sollicitudin. Donec ut tellus neque. In at libero libero. Nunc eleifend molestie nibh ac luctus.';
  final tree = DoubleTree.suffixTree(text1, text2);
  // find the length of the longest common substring between two texts
  print(tree.longestCommonSubstring);
}

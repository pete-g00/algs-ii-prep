import 'package:classes/string.dart' show Tree;

void main(List<String> args) {
  final text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam consectetur sapien nec viverra tincidunt. Sed gravida mauris nec porttitor porttitor. Donec sodales venenatis posuere. Nulla sed quam sit amet sem consequat dictum. Fusce commodo rutrum mi, ut vehicula diam interdum sit amet. Integer sagittis tempor metus, id tempor nunc placerat non. Etiam placerat lobortis nisl vel sollicitudin. Proin auctor, elit vel fringilla blandit, urna metus vulputate turpis, ut mollis tellus ante in turpis. Duis efficitur vel velit nec rhoncus. In ultricies lorem nunc, ut aliquam dolor dapibus eget. Integer dui nunc, dictum sed consectetur at, mattis nec dolor. Aliquam vestibulum id lacus ac fringilla. Etiam a tellus a metus eleifend semper lacinia ut dolor. Vestibulum in mollis lectus. Pellentesque quis libero mauris.';
  final tree = Tree.suffixTree(text);
  // find the length of the longest common substring
  print(tree.longestRepeatedSubstring);
}
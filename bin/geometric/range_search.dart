import 'package:binary_tree/binary_tree.dart';

/// Counts the number of elements in the tree that lie between start and end
int _rangeSearch<E extends Comparable<E>>(TreeNode<E>? node, E start, E end) {
  if (node == null) {
    return 0;
  }
  
  // smaller than the start => only look at the right node (exclude the node)
  if (node.data.compareTo(start) < 0) {
    print('+1');
    return _rangeSearch(node.right, start, end);
  }
  
  // bigger than the end => only look at the left node (exclude the node)
  if (node.data.compareTo(end) > 0) {
    print('1+');
    return _rangeSearch(node.left, start, end);
  }
  print('Value ${node.data} lies in the range!');
  
  // otherwise => got to look at both the children and add 1
  return 1 + _rangeSearch(node.left, start, end) + _rangeSearch(node.right, start, end);
}

int rangeSearch<E extends Comparable<E>>(BinaryTree<E> bst, E start, E end) => _rangeSearch(bst.root, start, end);

void main(List<String> args) {
  final bst = BinaryTree<int>([1, 5, 2, 3, 8, 10, 11]);
  print(rangeSearch<num>(bst, 3, 10));
}
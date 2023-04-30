part of '../string.dart';

class _TreeNode {
  /// The children nodes (as a map corresponding to the first letter for node)
  final Map<int, _TreeNode> children;
  /// The suffixes for this node
  final List<int> suffixes;
  /// The left index for this node (inclusive)
  final int leftIdx;
  /// The right index for this node (exclusive)
  int rightIdx;

  /// Constructs the tree node
  _TreeNode(this.leftIdx, this.rightIdx, int suffix):children={}, suffixes=[suffix];
  /// Constructs the root node
  _TreeNode.root(this.children):leftIdx=-1, rightIdx=-1, suffixes=[];

  int get maxStringDepth {
    if (children.isEmpty) {
      return 0;
    }

    var commonDepth = children.entries.fold<int>(0, (val, element) => max(val, element.value.maxStringDepth));

    return length + commonDepth;
  }

  int get length => rightIdx - leftIdx;

  void _addChild(_TreeNode node, String s){
    final val = s.codeUnitAt(node.leftIdx);
    children[val] = node;
  }

  /// Adds a child to this node, given the next left index [nextLeftIdx], the string [s] and the [suffix]
  void addChild(int suffix, int nextLeftIdx, String s) {
    // print('Adding suffix $suffix at node $this from index $nextLeftIdx');
    suffixes.add(suffix);
    for (var j = 0; j < rightIdx - leftIdx; j++) {
      // print('Matching s[${leftIdx + j}] with s[${nextLeftIdx + j}]');
      // mismatch => we break this node to 2 and add the next child
      if (s[leftIdx + j] != s[nextLeftIdx + j]) {
        // child1 is from leftIdx + j to leftIdx 
        final child1 = _TreeNode(leftIdx + j, rightIdx, suffix);
        for (var i = 0; i < suffixes.length-1; i++) {
          child1.suffixes.add(suffixes[i]);
        }
        _addChild(child1, s);
        
        // the rightIdx for this node is leftIdx + j
        rightIdx = leftIdx + j;
        
        // child2 is from nextLeftIdx + j to s.length-1
        final child2 = _TreeNode(nextLeftIdx + j, s.length, suffix);
        child2.suffixes.add(suffix);
        _addChild(child2, s);
        
        // print('Mismatch, so breaking this node to $child1 and $child2. This node is now $this');
        return;
      }
    }
    // print('We match this node completely, so trying a child for value s[${nextLeftIdx + length}]="${s[nextLeftIdx + length]}"');
    
    // total match here => try matching a child
    var child = children[s.codeUnitAt(nextLeftIdx + length)];
    if (child != null) {
      // print('Moving to the child node $child');
      child.addChild(suffix, nextLeftIdx + length, s);  
      return;
    }

    // cannot find a child for this node => create it
    child = _TreeNode(nextLeftIdx + length, s.length, suffix);
    _addChild(child, s);
    
    // print('No matches. Adding a new node to this node- $child');
  }

  @override
  String toString() {
    return '($leftIdx, $rightIdx)';
  }

  bool get isLeaf => children.isEmpty;
}

class Tree {
  final _TreeNode root;
  final String s;

  Tree._(this.root, this.s);

  factory Tree.suffixTree(String s) {
    final text = s + '\$';
    final nodes = <int, _TreeNode>{};
    
    for (var i = 0; i < text.length; i++) {
      if (i != text.length-1 && text[i] == "\$") {
        throw StateError("Cannot have the dollar symbol in the string");
      }
      
      // print('Adding suffix $i');
      final node = nodes[text.codeUnitAt(i)];
      if (node != null) {
        // print('Adding it as a child of $node');
        node.addChild(i, i, text);
      } else {
        final child = _TreeNode(i, text.length, i);
        // print('No match with present nodes- creating the node $child');
        nodes[text.codeUnitAt(i)] = child;
      }
      // print('');
    }
    
    return Tree._(_TreeNode.root(nodes), s);
  }

  int get longestRepeatedSubstring {
    var lrs = 0;
    // late _TreeNode maxNode;
    
    for (var entry in root.children.entries) {
      final depth = entry.value.maxStringDepth;
      if (depth > lrs) {
        lrs = depth;
        // maxNode = entry.value;
      }
    }

    return lrs;
  }

  bool isPresent(String t) {
    // if (t.isEmpty) {
    //   return true;
    // }

    _TreeNode? node = root;
    int i = 0;
    
    while (i < t.length) {
      node = node!.children[t.codeUnitAt(i)];
      if (node == null) {
        return false;
      }
      i += node.length;
    }

    return true;
  }
}

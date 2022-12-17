part of '../string.dart';

class _DoubleTreeNode {
  /// The children nodes (as a map corresponding to the first letter for node)
  final Map<int, _DoubleTreeNode> children;
  /// The suffixes for this node
  final List<int> s1Suffixes;
  final List<int> s2Suffixes;
  /// The left index for this node (inclusive)
  final int leftIdx;
  /// The right index for this node (exclusive)
  int rightIdx;

  /// Constructs the tree node 
  _DoubleTreeNode(this.leftIdx, this.rightIdx, int suffix, int s1Length):
    children={}, 
    s1Suffixes=suffix <= s1Length ? [suffix] : [], 
    s2Suffixes=suffix <= s1Length ? [] : [suffix];
  /// Constructs the root node
  _DoubleTreeNode.root(this.children):leftIdx=-1, rightIdx=-1, s1Suffixes=[], s2Suffixes=[];

  int get maxStringDepth {
    if (children.isEmpty || s1Suffixes.isEmpty || s2Suffixes.isEmpty) {
      return 0;
    }

    var commonDepth = children.entries.fold<int>(0, (val, element) => max(val, element.value.maxStringDepth));

    return length + commonDepth;
  }

  int get length => rightIdx - leftIdx;

  void _addChild(_DoubleTreeNode node, String s){
    final val = s.codeUnitAt(node.leftIdx);
    children[val] = node;
  }

  List<int> getSuffixIndices(int suffix, int s1Length) {
     if (suffix <= s1Length) {
      return s1Suffixes;
    } else {
      return s2Suffixes;
    }
  }

  /// Adds a child to this node, given the next left index [nextLeftIdx], the string [s] and the [suffix]
  void addChild(int suffix, int nextLeftIdx, String s, int s1Length) {
    print('Adding suffix $suffix at node $this from index $nextLeftIdx');
    getSuffixIndices(s.length, suffix).add(suffix);
    
    for (var j = 0; j < rightIdx - leftIdx; j++) {
      print('Matching s[${leftIdx + j}] with s[${nextLeftIdx + j}]');
      // mismatch => we break this node to 2 and add the next child
      if (s[leftIdx + j] != s[nextLeftIdx + j]) {
        // child1 is from leftIdx + j to leftIdx 
        final child1 = _DoubleTreeNode(leftIdx + j, rightIdx, suffix, s1Length);
        // for (var i = 0; i < getSuffixIndices(s.length, suffix).length-1; i++) {
        //   child1.getSuffixIndices(s.length, suffix).add(suffixes[i]);
        // }
        _addChild(child1, s);
        
        // the rightIdx for this node is leftIdx + j
        rightIdx = leftIdx + j;
        
        // child2 is from nextLeftIdx + j to s.length-1
        final child2 = _DoubleTreeNode(nextLeftIdx + j, s.length, suffix, s1Length);
        child2.getSuffixIndices(suffix, s1Length).add(suffix);
        _addChild(child2, s);
        
        print('Mismatch, so breaking this node to $child1 and $child2. This node is now $this');
        return;
      }
    }
    print('We match this node completely, so trying a child for value s[${nextLeftIdx + length}]="${s[nextLeftIdx + length]}"');
    
    // total match here => try matching a child
    var child = children[s.codeUnitAt(nextLeftIdx + length)];
    if (child != null) {
      print('Moving to the child node $child');
      child.addChild(suffix, nextLeftIdx + length, s, s1Length);  
      return;
    }

    // cannot find a child for this node => create it
    child = _DoubleTreeNode(nextLeftIdx + length, s.length, suffix, s1Length);
    _addChild(child, s);
    
    print('No matches. Adding a new node to this node- $child');
  }

  @override
  String toString() {
    return '($leftIdx, $rightIdx)';
  }
}

class DoubleTree {
  final _DoubleTreeNode root;

  DoubleTree._(this.root);

  factory DoubleTree.suffixTree(String s1, String s2) {
    final text = s1 + '#' + s2 + '\$';
    final nodes = <int, _DoubleTreeNode>{};
    
    for (var i = 0; i < text.length; i++) {
      if (i != text.length-1 && text[i] == "\$") {
        throw StateError("Cannot have the dollar symbol in the string");
      }
      
      print('Adding suffix $i');
      final node = nodes[text.codeUnitAt(i)];
      if (node != null) {
        print('Adding it as a child of $node');
        node.addChild(i, i, text, s1.length);
      } else {
        final child = _DoubleTreeNode(i, text.length, i, s1.length);
        print('No match with present nodes- creating the node $child');
        nodes[text.codeUnitAt(i)] = child;
      }
      print('');
    }

    for (var entry in nodes.entries) {
      print(entry.value.s1Suffixes);
      print(entry.value.s2Suffixes);
    }
    
    return DoubleTree._(_DoubleTreeNode.root(nodes));
  }

  /// Computes the length of the longest common substring
  int get longestCommonSubstring {
    var lrs = 0;
    // late _DoubleTreeNode maxNode;
    
    for (var entry in root.children.entries) {
      final depth = entry.value.maxStringDepth;
      if (depth > lrs) {
        lrs = depth;
        // maxNode = entry.value;
      }
    }

    return lrs;
  }
}

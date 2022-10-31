class TreeNode {
  /// the children of the node
  final List<TreeNode> _children;

  /// the starting index of the string (inclusive)
  final int leftIdx;

  int _rightIdx;

  /// the ending index of the string (exclusive)
  int get rightIdx => _rightIdx;

  /// the suffix indices for the string
  final List<int> _suffixIndices;

  bool get isLeaf => _children.isEmpty;

  bool get isBranch => !isLeaf;

  /// Creates a suffix tree node given the [leftIdx] and [rightIdx]
  TreeNode(this.leftIdx, this._rightIdx, int suffix):_children=[], _suffixIndices=[suffix];
  TreeNode._(this.leftIdx, this._rightIdx):_children=[], _suffixIndices=[];
  TreeNode._root():leftIdx=0, _rightIdx=0, _children=[], _suffixIndices=[];
  
  /// Adds a value corresponding to [suffix], matching on the [value] from index [j]
  void addValue(String value, int suffix, int j) {
    // print("Adding value $value, suffix $suffix from index $j");
    for (var i=0; i < value.length-j; i++) {
      // print('i = $i, depth = $depth');
      // if i has become greater than the depth, move to the child (if any)
      if (i >= depth) {
        final child = findChild(i+j, value);
        if (child == null) {
          // print('Branching from this node');
          addChild(i+j, value.length, suffix);
        } else {
          // print('Going to child');
          child.addValue(value, suffix, i+j);
        }
        return;
      }
      // if mismatch, break this node into 2 and add the child 
      if (value[i+leftIdx] != value[i+j]) {
        // print('We have a mismatch!');
        final child = TreeNode._(i+leftIdx, _rightIdx);
        
        // move children & suffixes to the child
        child._suffixIndices.addAll(_suffixIndices);
        child._children.addAll(_children);

        _children.clear();
        _children.add(child);
        _suffixIndices.add(suffix);

        addChild(i+j, value.length, suffix);
        
        _rightIdx = i + leftIdx;

        return;
      }
    }

    _suffixIndices.add(suffix);

    // total match, then find child matching the first character
    final child = findChild(suffix + depth, value) ?? addChild(j, j+value.length, suffix);
    child.addValue(value, suffix, j + depth);
  }

  /// Adds a child to this node given the [leftIdx], [rightIdx] and the [suffix].
  TreeNode addChild(int leftIdx, int rightIdx, int suffix) {
    TreeNode child = TreeNode(leftIdx, rightIdx, suffix);
    _children.add(child);
    return child;
  }

  /// The children of the node
  List<TreeNode> get children => _children;

  /// The suffixes corresponding to the node
  List<int> get suffixes => _suffixIndices;

  /// Gets the depth of the node
  int get depth => rightIdx - leftIdx;


  /// Finds the child at index [j] given the actual [value] that the tree holds
  TreeNode? findChild(int j, String value) {
    for (var i = 0; i < _children.length; i++) {
      if (value[_children[i].leftIdx] == value[j]) {
        return _children[i];
      }
    }

    return null;
  }

  int get maxStringDepth {
    if (suffixes.length < 2) {
      return 0;
    } 
    
    var maxStringDepth = 0;
    for (var i = 0; i < _children.length; i++) {
      final depth = _children[i].maxStringDepth;
      if (depth > maxStringDepth) {
        maxStringDepth = depth;
      }
    }

    return depth + maxStringDepth;
  }

  @override
  String toString() {
    return 'A tree node with label ($leftIdx, $_rightIdx) and suffixes $_suffixIndices.';
  }
}

class Tree {
  final TreeNode root;
  final String string;
  Tree._(this.root, this.string);
  
  factory Tree(String string) {
    TreeNode root = TreeNode._root();
    final str = string + '\$';

    for (var i = 0; i < str.length; i++) {
      root.addValue(str, i, i);
    }

    return Tree._(root, string);
  }

  List<int> findValue(String value) {
    var node = root.findChild(0, value);
    if (node == null) {
      return [];
    }

    var j = 0;
    var i = 0;
    while (i < value.length) {
      // mismatch i.e. no match
      if (string[node!.leftIdx+j] != value[i]) {
        return [];
      }
      
      i++;

      // end of match with node => go to child (if possible)
      if (i == value.length-1 && node.leftIdx + j < node.depth) {
        final temp = node.findChild(j+1, value);
        if (temp == null) {
          return [];
        }
        node = temp;
        j = 0;
        i++;
      } else {
        j++;
      }
    }

    return node!.suffixes;
  }

  int longestCommonSubstring() {
    int length = 0;
    
    for (var i = 0; i < root.children.length; i++) {
      final depth = root.children[i].maxStringDepth;
      if (depth > length) {
        length = depth;
      }
    }

    return length;
  }
}

void main(List<String> args) {
  final tree = Tree('queue');
  print(tree.root._children[2]._children);
  // print(tree.longestCommonSubstring());
}

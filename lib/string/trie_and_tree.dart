part of '../string.dart';

abstract class _Node {
  /// The children of the node  
  List<_Node> get children;
  
  /// The suffixes branching from the node
  List<int> get suffixes;
  
  /// The depth of this node.
  /// 
  /// The root has depth 0; a [TrieNode] always has depth 1; there is no fixed depth of a [TreeNode].
  int get depth;

  /// Tries to find a child with first character corresponding to the given character. If not possible, returns `null`.
  _Node? findChild(int character);

  /// The maximum string depth of the node.
  /// 
  /// A leaf node has string depth 0; other branch nodes have string depth 1 more than the maximum string depth of its children.
  int get maxStringDepth {
    if (suffixes.length < 2) {
      return 0;
    } 
    
    var maxStringDepth = 0;
    for (var i = 0; i < children.length; i++) {
      final depth = children[i].maxStringDepth;
      if (depth > maxStringDepth) {
        maxStringDepth = depth;
      }
    }

    return depth + maxStringDepth;
  }
  
  /// Whether this node is a leaf node
  bool get isLeaf => children.isEmpty;

  /// Whether this node is a branch node
  bool get isBranch => !isLeaf;

  /// Given the length [s1Length], checks whether the node has a suffix that starts within string 1.
  bool hasString1(int s1Length) {
    return suffixes.any((suffix) => suffix < s1Length);
  }
  
  /// Given the length [s1Length], checks whether the node has a suffix that starts within string 2
  bool hasString2(int s1Length) {
    return suffixes.any((suffix) => suffix > s1Length);
  }

  /// Given the length [s1Length], returns a suffix that starts within string 1, if any.
  /// 
  /// Otherwise, returns -1.
  int getS1Suffix(int s1Length) {
    for (var i=0; i<suffixes.length; i++) {
      if (suffixes[i] < s1Length) {
        return suffixes[i];
      }
    }

    return -1;
  }
  
  /// Given the length [s1Length], returns a suffix that starts within string 2, if any.
  /// 
  /// Otherwise, returns -1.
  int getS2Suffix(int s1Length) {
    for (var i=0; i<suffixes.length; i++) {
      if (suffixes[i] > s1Length) {
        return suffixes[i];
      }
    }

    return -1;
  }

  /// The maximum common string depth of this node.
  /// 
  /// A leaf node or a node which just has suffixes of one string has string depth 0; other branch nodes have string depth 1 more than the maximum string depth of its children.
  int maxCommonStringDepth(int s1Length) {
    if (suffixes.length < 2 || !(hasString1(s1Length) && hasString2(s1Length))) {
      return 0;
    } 
    
    var maxStringDepth = 0;
    for (var i = 0; i < children.length; i++) {
      final depth = children[i].maxCommonStringDepth(s1Length);
      if (depth > maxStringDepth) {
        maxStringDepth = depth;
      }
    }

    return depth + maxStringDepth;
  }
}

class TrieNode extends _Node {
  @override
  final List<TrieNode> children;
  @override
  final List<int> suffixes;
  @override
  final int depth;
  
  /// the character associated with the node
  final int character;

  /// Creates a TrieNode given the [character] and the [suffix].
  TrieNode(this.character, int suffix):children=[], suffixes=[suffix], depth=1;

  /// Creates the root TrieNode.
  TrieNode.root():character=0, children=[], suffixes=[], depth=0;

  /// Adds the [value] (from index [j]) corresponding to the [suffix] 
  void addValue(String value, int suffix, int j) {
    if (j < value.length) {
      suffixes.add(suffix);
      final child = findChild(value.codeUnitAt(j)) ?? addChild(value.codeUnitAt(j), suffix);
      child.addValue(value, suffix, j+1);
    }
  }

  /// Adds a child of the node corresponding to the [character] and the [suffix]. 
  /// 
  /// Returns the added child.
  TrieNode addChild(int character, int suffix) {
    TrieNode child = TrieNode(character, suffix);
    children.add(child);
    return child;
  }

  @override
  TrieNode? findChild(int character) {
    // try to find a child matching the given character
    for (var i = 0; i < children.length; i++) {
      if (children[i].character == character) {
        return children[i];
      }
    }

    return null;
  }

  @override
  String toString() {
    return 'A trie node with corresponding to ${String.fromCharCode(character)} and suffixes $suffixes.';
  }
}

class TreeNode extends _Node {
  @override
  final List<TreeNode> children;

  /// the starting index of the string (inclusive)
  final int leftIdx;

  /// the corresponding value added to the node
  final String value;

  int _rightIdx;

  /// the ending index of the string (exclusive)
  int get rightIdx => _rightIdx;

  @override
  final List<int> suffixes;

  /// Creates a suffix tree node given the [leftIdx] and [rightIdx]
  TreeNode(this.value, this.leftIdx, this._rightIdx, int suffix):children=[], suffixes=[suffix];
  TreeNode._(this.value, this.leftIdx, this._rightIdx):children=[], suffixes=[];
  TreeNode.root(this.value):leftIdx=0, _rightIdx=0, children=[], suffixes=[];
  
  /// Adds a value corresponding to [suffix], matching on the [value] from index [j]
  void addValue(String value, int suffix, int j) {
    // print("Adding value $value, suffix $suffix from index $j");
    for (var i=0; i < value.length-j; i++) {
      // print('i = $i, depth = $depth');
      // if i has become greater than the depth, move to the child (if any)
      if (i >= depth) {
        final child = findChild(i+j);
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
        final child = TreeNode._(value, i+leftIdx, _rightIdx);
        
        // move children & suffixes to the child
        child.suffixes.addAll(suffixes);
        child.children.addAll(children);

        children.clear();
        children.add(child);
        suffixes.add(suffix);

        addChild(i+j, value.length, suffix);
        
        _rightIdx = i + leftIdx;

        return;
      }
    }

    suffixes.add(suffix);

    // total match, then find child matching the first character
    final child = findChild(value.codeUnitAt(suffix + depth)) ?? addChild(j, j+value.length, suffix);
    child.addValue(value, suffix, j + depth);
  }

  /// Adds a child to this node given the [leftIdx], [rightIdx] and the [suffix].
  TreeNode addChild(int leftIdx, int rightIdx, int suffix) {
    TreeNode child = TreeNode(value, leftIdx, rightIdx, suffix);
    children.add(child);
    return child;
  }

  @override
  int get depth => rightIdx - leftIdx;

  @override
  TreeNode? findChild(int character) {
    for (var i = 0; i < children.length; i++) {
      if (value.codeUnitAt(children[i].leftIdx) == character) {
        return children[i];
      }
    }

    return null;
  }

  @override
  String toString() {
    return 'A tree node with label ($leftIdx, $_rightIdx) and suffixes $suffixes.';
  }
}

class Trie {
  /// The root of the suffix tree
  final TrieNode root;
  Trie._(this.root);

  /// Creates a suffix tree for the given string [s].
  factory Trie.suffixTrie(String s) {
    TrieNode root = TrieNode.root();
    final str = s + '\$';

    for (var i = 0; i < str.length; i++) {
      root.addValue(str, i, i);
    }

    return Trie._(root);
  }

  /// Finds all the indices of [value] in the string on the trie.
  List<int> findValue(String value) {
    var node = root;
    for (var i = 0; i < value.length; i++) {
      final child = node.findChild(value.codeUnitAt(i));
      if (child == null) {
        return [];
      } 
      node = child;
    }

    return node.suffixes;
  }

  /// Finds the length of the longest common substring of the trie
  int longestCommonSubstringLength() {
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

class DoubleTrie extends Trie {
  final int _s1Length;
  DoubleTrie._(TrieNode root, this._s1Length):super._(root);

  /// Creates a suffix trie for the given strings [s1] and [s2].
  factory DoubleTrie.suffixTrie(String s1, String s2) {
    TrieNode root = TrieNode.root();
    final str = s1 + '#' + s2 + '\$';

    for (var i = 0; i < str.length; i++) {
      root.addValue(str, i, i);
    }

    return DoubleTrie._(root, s1.length);
  }

  /// Finds the longest common substring of the trie
  @override
  int longestCommonSubstringLength() {
    int length = 0;
    
    for (var i = 0; i < root.children.length; i++) {
      final depth = root.children[i].maxCommonStringDepth(_s1Length);
      final hasBothStrings = root.children[i].hasString1(_s1Length) && root.children[i].hasString2(_s1Length);
      if (depth > length && hasBothStrings) {
        length = depth;
      }
    }

    return length;
  }
}

class Tree {
  final TreeNode root;
  final String string;
  Tree._(this.root, this.string);
  
  factory Tree(String string) {
    TreeNode root = TreeNode.root(string);
    final str = string + '\$';

    for (var i = 0; i < str.length; i++) {
      root.addValue(str, i, i);
    }

    return Tree._(root, string);
  }

  List<int> findValue(String value) {
    var node = root.findChild(0);
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
        final temp = node.findChild(j+1);
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

  /// Finds the longest common substring of the trie
  int longestCommonSubstringLength() {
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

class DoubleTree extends Tree {
  final int _s1Length;
  DoubleTree._(TreeNode root, this._s1Length, String value):super._(root, value);

  /// Creates a suffix tree for the given strings [s1] and [s2].
  factory DoubleTree.suffixTrie(String s1, String s2) {
    final str = s1 + '#' + s2 + '\$';
    print(str.length);
    TreeNode root = TreeNode.root(str);
    
    for (var i = 0; i < str.length; i++) {
      if (i % 1000 == 0) {
        print(i);
      }
      root.addValue(str, i, i);
    }

    return DoubleTree._(root, s1.length, str);
  }

  @override
  int longestCommonSubstringLength() {
    int length = 0;
    
    for (var i = 0; i < root.children.length; i++) {
      final depth = root.children[i].maxCommonStringDepth(_s1Length);
      final hasBothStrings = root.children[i].hasString1(_s1Length) && root.children[i].hasString2(_s1Length);
      if (depth > length && hasBothStrings) {
        length = depth;
      }
    }

    return length;
  }
}

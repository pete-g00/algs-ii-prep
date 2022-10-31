class TrieNode {
  /// the children of the node
  final List<TrieNode> _children;
  
  /// the character associated with the node
  final int character;

  /// the suffix indices that correspond to this node
  final List<int> _suffixIndices;

  TrieNode(this.character, int suffix):_children=[], _suffixIndices=[suffix];
  TrieNode._root():character=0, _children=[], _suffixIndices=[];

  /// Adds the [value] (from index [j]) corresponding to the [suffix] 
  void addValue(String value, int suffix, int j) {
    if (j < value.length) {
      _suffixIndices.add(suffix);
      final child = findChild(value.codeUnitAt(j)) ?? addChild(value.codeUnitAt(j), suffix);
      child.addValue(value, suffix, j+1);
    }
  }

  /// Adds a child of the node corresponding to the [character] and the [suffix]
  TrieNode addChild(int character, int suffix) {
    TrieNode child = TrieNode(character, suffix);
    _children.add(child);
    return child;
  }

  /// The children of the node
  List<TrieNode> get children => _children;

  /// The suffixes corresponding to the node
  List<int> get suffixes => _suffixIndices;

  /// Tries to find a child corresponding to the given character. If not possible, returns `null`.
  TrieNode? findChild(int character) {
    // try to find a child matching the given character
    for (var i = 0; i < _children.length; i++) {
      if (_children[i].character == character) {
        return _children[i];
      }
    }

    return null;
  }

  /// The maximum string depth of the node.
  /// 
  /// A leaf node has string depth 0; other branch nodes have string depth 1 more than the maximum string depth of its children
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

    return 1 + maxStringDepth;
  }

  bool hasString1(int s1Length) {
    return _suffixIndices.any((suffix) => suffix < s1Length);
  }
  
  bool hasString2(int s1Length) {
    return _suffixIndices.any((suffix) => suffix > s1Length);
  }

  int getS1Suffix(int s1Length) {
    return _suffixIndices.fold(-1, (prev, suffix) => prev == -1 && suffix < s1Length ? suffix : prev);
  }
  
  int getS2Suffix(int s1Length) {
    return _suffixIndices.fold(-1, (prev, suffix) => prev == -1 && suffix > s1Length ? suffix : prev);
  }
}

class Trie {
  /// The root of the suffix tree
  final TrieNode root;
  Trie._(this.root);

  /// Creates a suffix tree for the given string [s].
  factory Trie.suffixTrie(String s) {
    TrieNode root = TrieNode._root();
    final str = s + '\$';

    for (var i = 0; i < str.length; i++) {
      root.addValue(str, i, i);
    }

    return Trie._(root);
  }

  /// Finds all the indices of [value] in the trie.
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

  /// Finds the longest common substring of the trie
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

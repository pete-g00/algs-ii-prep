part of '../hard.dart';

/// A coloured graph represents a directed graph which has a colour (an integer index).
class ColouredGraph {
  /// The adjacency matrix for the directed graph
  final List<List<bool>> adjacencyMatrix;

  /// The colours of the graph
  final List<int> colours;

  /// Whether the graph has been fully coloured
  bool _coloured;

  /// Constructs a coloured graph given the [adjacencyMatrix].
  ColouredGraph(this.adjacencyMatrix):colours=List.filled(adjacencyMatrix.length, -1), _coloured=false;

  /// Colour the vertex i using a colour between 1 and k
  void _colour(int i, int k) {
    print('Colouring vertex $i');
    var colour = 0;
    // only try i colours if i smaller than k (all vertices being a distinct colour always works)
    while (!_coloured && colour <= min(k-1, i)) {
      print('Setting colour $colour to vertex $i');
      colours[i] = colour;
      if (_isValidChoice(i)) {
        if (i == adjacencyMatrix.length-1) {
          print('We have coloured all the vertices with $k colours!');
          _coloured = true;
        } else {
          _colour(i+1, k);
        }
      }
      colour++;
    }
    if (!_coloured) {
      print('Failed colouring vertex $i with the previous colour choices!');
    }
  }

  /// Given 2 vertex indices [i] and [j], determines whether there exists an edge between them.
  bool hasEdge(int i, int j) => adjacencyMatrix[i][j];

  /// Is it a valid choice to colour this vertex the given colour
  bool _isValidChoice(int i) {
    for (var j = 0; j < i; j++) {
      if (hasEdge(i, j) && colours[i] == colours[j]) {
        return false;
      }
    }

    return true;
  }

  /// Tries to colour the graph using [k] vertices.
  /// 
  /// Returns `true` if possible, `false` otherwise.
  bool colour(int k) {
    _colour(0, k);
    return _coloured;
  }
}

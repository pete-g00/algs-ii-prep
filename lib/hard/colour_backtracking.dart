part of '../hard.dart';

class ColouredGraph {
  final List<List<bool>> adjacencyMatrix;
  final List<int> colours;
  bool _coloured;

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

  bool hasEdge(int i, int j) => adjacencyMatrix[i][j];

  bool _isValidChoice(int i) {
    for (var j = 0; j < i; j++) {
      if (hasEdge(i, j) && colours[i] == colours[j]) {
        return false;
      }
    }

    return true;
  }

  bool colour(int k) {
    _colour(0, k);
    return _coloured;
  }
}

// void main(List<String> args) {
//   final adjacencyMatrix = [
//     [false, false, true, true, false],
//     [false, false, true, false, true],
//     [true, true, false, true, true],
//     [true, false, true, false, false],
//     [false, true, true, false, false]
//   ];
//   final colouredGraph = ColouredGraph(adjacencyMatrix);
//   print(colouredGraph.colour(3));
// }
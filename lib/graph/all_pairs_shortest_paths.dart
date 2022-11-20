part of '../graph.dart';

class WeightedGraph {
  final List<List<int?>> weightMatrix;
  final List<List<int?>> _shortestPaths;
  List<List<int?>> _prevShortestPaths;

  WeightedGraph(this.weightMatrix):
  _prevShortestPaths = List.generate(
    weightMatrix.length, (i) => List.generate(weightMatrix.length, (j) => i == j ? 0 : weightMatrix[i][j])
  ),
  _shortestPaths = List.generate(weightMatrix.length, (i) => List.filled(weightMatrix.length, -1));

  bool hasEdge(int i, int j) => weightMatrix[i][j] != null;

  void floydWarshall() {
    for (var k = 0; k < weightMatrix.length; k++) {
      for (var i = 0; i < weightMatrix.length; i++) {
        for (var j = 0; j < weightMatrix.length; j++) {
          if (_prevShortestPaths[i][k] == null || _prevShortestPaths[k][j] == null) {
            _shortestPaths[i][j] = _prevShortestPaths[i][j];
          } else if (_prevShortestPaths[i][j] == null && (_prevShortestPaths[i][k] != null && _prevShortestPaths[k][j] != null)) {
            _shortestPaths[i][j] = _prevShortestPaths[i][k]! + _prevShortestPaths[k][j]!;
          } else {
            _shortestPaths[i][j] = min(_prevShortestPaths[i][j]!, _prevShortestPaths[i][k]! + _prevShortestPaths[k][j]!);
          }
        }
      }
      print(_prevShortestPaths);
      _prevShortestPaths = _shortestPaths;
    }
  }
}


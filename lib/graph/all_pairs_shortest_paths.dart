part of '../graph.dart';

/// Represents a weighted graph.
class WeightedGraph {
  /// The weight matrix for the weighted graph
  final List<List<int?>> weightMatrix;

  /// The length of the shortest paths between any two vertices (a matrix)
  final List<List<int?>> shortestPaths;

  /// The previous shortest paths (used when finding the shortest paths)
  List<List<int?>> _prevShortestPaths;

  /// The predecessor vertex between a path between any two vertices (a matrix)
  final List<List<int>> predecessors;
  
  /// The previous predecessors (used when finding the shortest paths)
  List<List<int>> _prevPredecessors;

  /// Constructs a weighted graph given the [weightMatrix].
  WeightedGraph(this.weightMatrix):
  _prevShortestPaths = List.generate(
    weightMatrix.length, (i) => List.generate(weightMatrix.length, (j) => i == j ? 0 : weightMatrix[i][j])
  ),
  _prevPredecessors = List.generate(
    weightMatrix.length, (i) => List.generate(weightMatrix.length, (j) => i == j ? -1 : weightMatrix[i][j] == null ? -1 : i)
  ),
  shortestPaths = List.generate(weightMatrix.length, (i) => List.filled(weightMatrix.length, -1)),
  predecessors = List.generate(weightMatrix.length, (i) => List.filled(weightMatrix.length, -1));

  /// Whether there exists an edge from vertex [i] to vertex [j]
  bool hasEdge(int i, int j) => weightMatrix[i][j] != null;

  /// Computes all pairs shortest paths using the Floyd-Warshall algorithm.
  void floydWarshall() {
    print('shortest path: $_prevShortestPaths');
    print('predecessors: $_prevPredecessors');
    for (var k = 0; k < weightMatrix.length; k++) {
      for (var i = 0; i < weightMatrix.length; i++) {
        for (var j = 0; j < weightMatrix.length; j++) {
          if (_prevShortestPaths[i][k] == null || _prevShortestPaths[k][j] == null) {
            print('Keeping predecessor at ($i, $j) ${_prevPredecessors[i][j]} since path from/to $k doesn\'t exist');
            shortestPaths[i][j] = _prevShortestPaths[i][j];
            predecessors[i][j] = _prevPredecessors[i][j];
          } else if (_prevShortestPaths[i][j] == null && (_prevShortestPaths[i][k] != null && _prevShortestPaths[k][j] != null)) {
            print('Changing predecessor at ($i, $j) from ${_prevPredecessors[i][j]} to ${_prevPredecessors[k][j]} since there is no current path from $i to $j');
            shortestPaths[i][j] = _prevShortestPaths[i][k]! + _prevShortestPaths[k][j]!;
            predecessors[i][j] = _prevPredecessors[k][j];
          } else {
            final prev = _prevShortestPaths[i][j]!;
            final newVal = _prevShortestPaths[i][k]! + _prevShortestPaths[k][j]!;
            if (prev <= newVal) {
              print('Keeping predecessor at ($i, $j) ${_prevPredecessors[i][j]} since the previous weight is smaller than the new weight');
              shortestPaths[i][j] = prev;
              predecessors[i][j] = _prevPredecessors[i][j];
            } else {
              print('Changing predecessor at ($i, $j) from ${_prevPredecessors[i][j]} to ${_prevPredecessors[k][j]} since the new weight is bigger than the previous weight');
              shortestPaths[i][j] = newVal;
              predecessors[i][j] = _prevPredecessors[k][j];
            }
          }
        }
      }
      print('shortest path: $shortestPaths');
      print('predecessors: $predecessors');
      _prevShortestPaths = shortestPaths;
      _prevPredecessors = predecessors;
    }
  }
}


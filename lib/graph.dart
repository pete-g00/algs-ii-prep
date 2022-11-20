library graph;

import 'dart:collection';
import 'package:quiver/core.dart';
import 'dart:math' show min;

part 'graph/bipartile_graph.dart';
part 'graph/network_flow.dart';
part 'graph/gale_shapley.dart';
part 'graph/all_pairs_shortest_paths.dart';

void main(List<String> args) {
  // final v0 = NetworkVertex();
  // final v1 = NetworkVertex();
  // final v2 = NetworkVertex();
  // final v3 = NetworkVertex();

  // v0.addEdge(v1, 2);
  // v0.addEdge(v2, 3);
  // v1.addEdge(v2, 1);
  // v1.addEdge(v3, 3);
  // v2.addEdge(v3, 2);

  // final graph = NetworkGraph(v0);
  // graph.maxFlow();

  // final v0 = NetworkVertex();
  // final v1 = NetworkVertex();
  // final v2 = NetworkVertex();
  // final v3 = NetworkVertex();
  // final v4 = NetworkVertex();
  // final v5 = NetworkVertex(true);

  // v0.addEdge(v1, 2);
  // v0.addEdge(v2, 4);
  // v1.addEdge(v3, 1);
  // v1.addEdge(v4, 3);
  // v2.addEdge(v3, 3);
  // v2.addEdge(v4, 1);
  // v3.addEdge(v5, 2);
  // v4.addEdge(v2, 1);
  // v4.addEdge(v5, 4);

  // final graph = NetworkGraph(v0);
  // graph.maxFlow();

  // final v0 = NetworkVertex();
  // final v1 = NetworkVertex();
  // final v2 = NetworkVertex();
  // final v3 = NetworkVertex();
  // final v4 = NetworkVertex();
  // final v5 = NetworkVertex();
  // final v6 = NetworkVertex();
  // final v7 = NetworkVertex(true);

  // v0.addEdge(v1, 4);
  // v0.addEdge(v3, 2);
  // v0.addEdge(v5, 2);
  // v1.addEdge(v2, 3);
  // v1.addEdge(v4, 4);
  // v2.addEdge(v7, 1);
  // v3.addEdge(v2, 3);
  // v3.addEdge(v4, 2);
  // v4.addEdge(v6, 3);
  // v4.addEdge(v7, 5);
  // v5.addEdge(v3, 3);
  // v6.addEdge(v5, 1);
  // v6.addEdge(v7, 2);

  // final graph = NetworkGraph(v0);
  // graph.maxFlow();

  // final s1 = A('s1');
  // final s2 = A('s2');
  // final s3 = A('s3');
  // final s4 = A('s4');

  // final l1 = B('l1');
  // final l2 = B('l2');
  // final l3 = B('l3');
  // final l4 = B('l4');
  
  // s1.preferences = [1, 3, 0, 2];
  // s2.preferences = [2, 0, 3, 1];
  // s3.preferences = [1, 2, 0, 3];
  // s4.preferences = [3, 0, 2, 1];

  // l1.preferences = [1, 0, 3, 2];
  // l2.preferences = [3, 2, 0, 1];
  // l3.preferences = [0, 3, 2, 1];
  // l4.preferences = [1, 0, 3, 2];

  // final aValues = [s1, s2, s3, s4];
  // final bValues = [l1, l2, l3, l4];

  // galeShapley(aValues, bValues);

  // for (var i = 0; i < aValues.length; i++) {
  //   final a = aValues[i];
  //   final b = bValues[a.preferences[a.matchIdx]];
  //   print('$a is matched with $b');
  // }
  // for (var i = 0; i < bValues.length; i++) {
  //   final b = bValues[i];
  //   final a = aValues[b.preferences[b.matchIdx]];
  //   print('$b is matched with $a');
  // }

  final weightMatrix = [
    [null, -5, null, null],
    [null, null, 2, null],
    [null, null, null, null],
    [3, -1, 3, null]
  ];
  final graph = WeightedGraph(weightMatrix);
  graph.floydWarshall();
}

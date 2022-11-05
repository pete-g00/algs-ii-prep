part of '../graph.dart';

class Vertex {
  static int _value = 0;
  final int _id;
  final List<Edge> edges;
  Edge? mateEdge;

  Vertex():_id=_value++, edges=[];

  void addDirectedEdge(Vertex v) {
    edges.add(Edge(this, v));
  }

  void addUndirectedEdge(Vertex v) {
    addDirectedEdge(v);
    v.addDirectedEdge(this);
  }

  bool get isExposed => mateEdge != null;

  bool get isUnexposed => !isExposed;

  @override
  int get hashCode => _id.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is Vertex) {
      return other._id == _id;
    }
    return false;
  }

  @override
  String toString() {
    return 'Vertex $_id';
  }
}

class Edge {
  final Vertex source;
  final Vertex range;

  Edge(this.source, this.range);

  @override
  int get hashCode => hash2(source, range);

  @override
  bool operator ==(Object other) {
    if (other is Edge) {
      return source == other.source && range == other.range;
    }

    return false;
  }

  @override
  String toString() {
    return 'Edge from $source to $range';
  }
}

class BipartileGraph {
  /// The indices of the left vertices in the list [vertices]
  final List<Vertex> leftVertices;

  /// The number of exposed left vertices
  int _exposedCount;

  BipartileGraph(this.leftVertices):_exposedCount=leftVertices.length;

  bool get isPerfectMatch => _exposedCount == 0;

  void _recoverEdges(Map<Vertex, Edge> rightPredecessors, Vertex startVertex, Vertex endVertex, Set<Edge> matches) {
    print(rightPredecessors);
    print('Constructing the list of matching edges');
    Vertex? rightVertex = endVertex;
    Vertex? leftVertex;
    
    do {
      final edge = rightPredecessors[rightVertex]!;
      leftVertex = edge.source;
      print('The right vertex is $rightVertex');
      final mateEdge = edge.source.mateEdge;
      if (mateEdge == null) {
        print('Adding the final edge the $edge');
      } else {
        print('Replacing the $mateEdge with the $edge');
      }

      matches.add(edge);
      matches.remove(mateEdge);
      
      edge.source.mateEdge = edge;
      edge.range.mateEdge = edge;

      rightVertex = mateEdge?.range;
    } while (leftVertex != startVertex);
    
    _exposedCount--;
    print('The matching is now: $matches');
  }

  bool _augmentingPath(Set<Edge> matches) {
    print('Finding an augmenting path');
    if (isPerfectMatch) {
      print('We already have a perfect match!');
      return true;
    }

    for (var i = 0; i < leftVertices.length; i++) {
      var startVertex = leftVertices[i];
      if (startVertex.isUnexposed) {
        print('The starting vertex is $startVertex');
        // the vertices (on the right) that are visited
        final rightVisitedVertices = <Vertex>{};
        // the predecessor edge for vertices (on the right)
        final rightPredecessors = <Vertex, Edge>{};

        final queue = Queue<Vertex>();
        print('Adding $startVertex to the queue');
        queue.add(startVertex);

        while (queue.isNotEmpty) {
          final leftVertex = queue.removeFirst();
          final edges = leftVertex.edges;

          for (var k = 0; k < edges.length; k++) {
            final rightVertex = edges[k].range;
            print('The $leftVertex has an edge to $rightVertex');
            if (rightVisitedVertices.add(rightVertex)) {
              rightPredecessors[rightVertex] = edges[k];
              if (rightVertex.isUnexposed) {
                print('The vertex $rightVertex isn\'t exposed, so we construct the list of matching edges');
                _recoverEdges(rightPredecessors, startVertex, rightVertex, matches);
                return false;
              } else {
                final nextLeftVertex = rightVertex.mateEdge!.source;
                print('The vertex $rightVertex is exposed, so we add its mate $nextLeftVertex to the queue');
                queue.add(nextLeftVertex);
              }
            } else {
              print('The vertex $rightVertex has already been visited');
            }
          }
        }
      }
    }

    print('Unable to find any augmented path');
    return true;
  }

  /// Fills out the mates
  Set<Edge> match() {
    final matches = <Edge>{};
    var matched = false;
    do {
      // change the state of mates
      matched = _augmentingPath(matches);
      print('');
    } while (!matched);

    return matches;
  }
}


// void main(List<String> args) {
//   final v0 = Vertex();
//   final v1 = Vertex();
//   final v2 = Vertex();
//   final v3 = Vertex();
//   final v4 = Vertex();
  
//   final v5 = Vertex();
//   final v6 = Vertex();
//   final v7 = Vertex();
//   final v8 = Vertex();
//   final v9 = Vertex();

//   v0.addUndirectedEdge(v5);
//   v0.addUndirectedEdge(v6);
//   v1.addUndirectedEdge(v5);
//   v1.addUndirectedEdge(v7);
//   v2.addUndirectedEdge(v5);
//   v2.addUndirectedEdge(v7);
//   v2.addUndirectedEdge(v8);
//   v3.addUndirectedEdge(v6);
//   v3.addUndirectedEdge(v7);
//   v3.addUndirectedEdge(v9);
//   v4.addUndirectedEdge(v8);
  
//   final leftVertices = [v0, v1, v2, v3, v4];
//   final bipartileGraph = BipartileGraph(leftVertices);
//   print(bipartileGraph.match());
// }

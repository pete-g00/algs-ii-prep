part of '../graph.dart';

class Vertex<A, B> {
  static int _value = 0;
  final int _id;
  final List<Edge<A, B>> edges;
  Edge<A, B>? mateEdge;

  Vertex():_id=_value++, edges=[];

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

class LeftVertex<A, B> extends Vertex<A, B> {
  final A entry;

  void addDirectedEdge(RightVertex<A, B> v) {
    edges.add(Edge(this, v));
  }

  void addUndirectedEdge(RightVertex<A, B> v) {
    addDirectedEdge(v);
    v.addDirectedEdge(this);
  }

  LeftVertex(this.entry);
}

class RightVertex<A, B> extends Vertex<A, B> {
  final B entry;

  void addDirectedEdge(LeftVertex<A, B> v) {
    edges.add(Edge(v, this));
  }

  void addUndirectedEdge(LeftVertex<A, B> v) {
    addDirectedEdge(v);
    v.addDirectedEdge(this);
  }

  RightVertex(this.entry);
}

class Edge<A, B> {
  final LeftVertex<A, B> source;
  final RightVertex<A, B> range;

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

class BipartileGraph<A, B> {
  /// The indices of the left vertices in the list [vertices]
  final List<LeftVertex<A, B>> leftVertices;

  /// The number of exposed left vertices
  int _exposedCount;

  BipartileGraph(this.leftVertices):_exposedCount=leftVertices.length;

  bool get isPerfectMatch => _exposedCount == 0;

  void _recoverEdges(
    Map<RightVertex<A, B>, Edge<A, B>> rightPredecessors, 
    LeftVertex<A, B> startVertex, 
    RightVertex<A, B> endVertex, 
    Set<Edge<A, B>> matches
  ) {
    print(rightPredecessors);
    print('Constructing the list of matching edges');
    RightVertex<A, B>? rightVertex = endVertex;
    LeftVertex<A, B>? leftVertex;
    
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

  bool _augmentingPath(Set<Edge<A, B>> matches) {
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
        final rightVisitedVertices = <RightVertex<A, B>>{};
        // the predecessor edge for vertices (on the right)
        final rightPredecessors = <RightVertex<A, B>, Edge<A, B>>{};

        final queue = Queue<LeftVertex<A, B>>();
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
  Set<Edge<A, B>> match() {
    final matches = <Edge<A, B>>{};
    var matched = false;
    do {
      // change the state of mates
      matched = _augmentingPath(matches);
      print('');
    } while (!matched);

    return matches;
  }
}

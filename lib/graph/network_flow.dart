part of '../graph.dart';

/// A vertex in the network
class NetworkVertex {
  static int _value = 0;

  final int _id;
  
  /// The edges involving this vertex
  final List<NetworkEdge> edges;

  /// Whether the vertex is a sink
  final bool isSink;

  /// Constructs a network vertex.
  /// 
  /// The value [isSink] is by default `false`.
  NetworkVertex([this.isSink=false]):edges=[], _id=_value++;

  /// Adds an edge from this vertex to another with the given capacity
  void addEdge(NetworkVertex v, int capacity) {
    final edge = NetworkEdge(this, v, capacity);
    edges.add(edge);
    v.edges.add(edge);
  }

  @override
  int get hashCode => _id.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is NetworkVertex) {
      return other._id == _id;
    }
    return false;
  }

  @override
  String toString() {
    return 'Vertex $_id';
  }
}

class NetworkEdge {  
  final int capacity;
  int flow;
  final NetworkVertex source;
  final NetworkVertex range;

  NetworkEdge(this.source, this.range, this.capacity):flow=0;

  int get backwardsWeight => flow;
  int get forwardsWeight => capacity - flow;

  @override
  String toString() {
    return 'Edge from $source to $range with flow $flow and capacity $capacity';
  }
}

/// A network graph
class NetworkGraph {
  /// The source vertex
  final NetworkVertex source;

  /// The predecessor map (used in the max flow process)
  final _predecessorMap = <NetworkVertex, NetworkEdge>{};

  /// Constructs a network graph given the source vertex
  NetworkGraph(this.source);

  /// Computes the maximum flow for the network.
  /// 
  /// The edges will also have their capacity value updated as a result.
  int maxFlow() {
    var flow = 0;

    // get an augmented path
    NetworkVertex vertex = _augmentedPath;
    // loop until vertex isn't a sink
    while (vertex.isSink) {
      print('');
      // improve the flow
      flow += _improveFlow(vertex);
      print('');
      vertex = _augmentedPath;
    }
    
    print('The maximum flow is $flow');

    return flow;
  }

  /// Computes an augmenting path with respect to the current capacity values
  NetworkVertex get _augmentedPath {
    print('Finding an augmented path in the graph');

    _predecessorMap.clear();
    NetworkVertex vertex = source;
    
    final queue = Queue<NetworkVertex>();
    final visitedVertices = <NetworkVertex>{};
    queue.add(source);
    print('Adding the source vertex $source to the queue');

    // do bfs (weight must be > 0 for an edge to "exist")
    while (queue.isNotEmpty) {
      vertex = queue.removeFirst();
      if (visitedVertices.add(vertex)) {
        print('Removing $vertex from the queue');

        for (var i=0; i<vertex.edges.length; i++) {
          final edge = vertex.edges[i];
          // take forwards edge if edge starts at this vertex (and range is unvisited)
          if (edge.source == vertex && edge.forwardsWeight > 0 && !visitedVertices.contains(edge.range)) {
            print('Found a forwards edge from $vertex to ${edge.range} of weight ${edge.forwardsWeight}');
            _predecessorMap.putIfAbsent(edge.range, () => edge);
            print('Adding the edge ${edge.range} to the queue');
            queue.add(edge.range);
          } 
          // otherwise, take the backwards edge
          else if (edge.backwardsWeight > 0 && !visitedVertices.contains(edge.source)) {
            print('Found a backwards edge from ${edge.source} to $vertex of weight ${edge.backwardsWeight}');
            _predecessorMap.putIfAbsent(edge.source, () => edge);
            print('Adding the edge ${edge.source} to the queue');
            queue.add(edge.source);
          }
        }
      }
    }

    print('The queue was emptied with the final vertex $vertex');

    // return the final vertex (which might not be the sink)
    return vertex;
  }

  /// Improve the flow given a sink (backwards update of capacity)
  int _improveFlow(NetworkVertex sink) {
    print('Improving the flow of the network');

    var forwardsEdges = <NetworkEdge>[];
    var backwardsEdges = <NetworkEdge>[];
    var m = 0;

    // go from the sink to the source (via the _predecessorMap) => collect to forwards or backwards edge + keep track of the minimum weight
    var vertex = sink;
    while (vertex != source) {
      final edge = _predecessorMap[vertex]!;
      print('The predecessor of the vertex $vertex is the $edge');
      late int val;
      // forwards edge
      if (edge.range == vertex) {
        print('This is a forwards edge from ${edge.source}');
        forwardsEdges.add(edge);
        val = edge.forwardsWeight;
        vertex = edge.source;
      } 
      // backwards edge
      else {
        print('This is a backwards edge from ${edge.range}');
        backwardsEdges.add(edge);
        val = edge.backwardsWeight;
        vertex = edge.range;
      }
      
      // update the value m
      if (m == 0) {
        m = val;
      } else {
        m = min(m, val);
      }
    }

    print('The value m=$m');

    // update the flow
    for (var i=0; i<forwardsEdges.length; i++) {
      forwardsEdges[i].flow += m;
    }
    for (var i=0; i<backwardsEdges.length; i++) {
      backwardsEdges[i].flow -= m;
    }

    return m;
  }
}

part of '../string.dart';

class NDFAState {
  NDFAEdge? _edge1;
  NDFAEdge? _edge2;
  final int id;

  NDFAState(): id = _val++;

  static int _val = 0;

  void addEdge(NDFAEdge edge) {
    if (_edge1 == null) {
      _edge1 = edge;
    } else if (_edge2 == null) {
      _edge2 = edge;
    } else {
      throw StateError('A state can have at most two edges!');
    }
  }

  @override
  String toString() {
    if (_edge1 == null) {
      return 'State $id; no edges';
    } else if (_edge2 == null) {
      return 'State $id; has a single edge: $_edge1';
    } else {
      return 'State $id; has two edges: $_edge1, $_edge2';
    }
  }

  NDFAEdge getEdge(int i) {
    if (i == 0 && _edge1 != null) {
      return _edge1!;
    } else if (i == 1 && _edge2 != null) {
      return _edge2!;
    } else {
      throw RangeError('Invalid index- $i');
    }
  }

  int get edgeLength {
    if (_edge1 == null) {
      return 0;
    } else if (_edge2 == null) {
      return 1;
    } else {
      return 2;
    }
  }
}

class NDFAEdge {
  final NDFAState toNode;
  final int character;
  final bool isEpsilon;

  NDFAEdge.normal(this.toNode, this.character):isEpsilon=false;
  NDFAEdge.epsilon(this.toNode):isEpsilon = true, character=0;

  @override
  String toString() {
    if (isEpsilon) {
      return 'an epsilon edge to ${toNode.id}';
    } else {
      return 'an edge with value ${String.fromCharCode(character)} to ${toNode.id}';
    }
  }
}

class NDFA {
  final NDFAState initialState;
  final NDFAState finalState;

  NDFA(this.initialState, this.finalState);

  bool _shouldAddToQueue(NDFAState state, List<NDFAState> states) => state != initialState && 
                                                                  (states.length <= state.id || states[state.id] == initialState);

  List<NDFAState> get states {
    final states = <NDFAState>[];
    final queue = Queue<NDFAState>();
    queue.add(initialState);

    while (queue.isNotEmpty) {
      final state = queue.removeLast();
      for (var i = states.length; i <= state.id; i++) {
        states.add(initialState);
      }
      states[state.id] = state;
      
      // only add if edge.toNode isn't initialState, its id contains initialState (or isn't valid)
      for (var i = 0; i < state.edgeLength; i++) {
        final edge = state.getEdge(i);
        if (_shouldAddToQueue(edge.toNode, states)) {
          queue.addFirst(edge.toNode);
        }
      }
    }

    return states;
  }

  List<bool> _extendByEpsilon(NDFAState state, List<bool> extension) {
    final queue = Queue<NDFAState>();
    queue.add(state);

    while (queue.isNotEmpty) {
      final _state = queue.removeLast();
      extension[_state.id] = true;

      // only add if edge.toNode isn't already true AND can extend by epsilon
      for (var i = 0; i < _state.edgeLength; i++) {
        final edge = _state.getEdge(i);
        if (!extension[edge.toNode.id] && edge.isEpsilon) {
          queue.addFirst(edge.toNode);
        }
      }
    }
    

    return extension;
  }

  List<bool> _extendByChar(NDFAState state, List<bool> extension, int char) {
    // only add a state if it isn't epsilon and matches character value
    for (var i = 0; i < state.edgeLength; i++) {
      final edge = state.getEdge(i);
      if (!edge.isEpsilon && edge.character == char) {
        extension[edge.toNode.id] = true;
      }
    }

    return extension;
  }

  List<bool> extendByEpsilon(List<bool> positions, List<NDFAState> states) {
    var extension = List.filled(states.length, false);
    for (var i = 0; i < positions.length; i++) {
      if (positions[i]) {
        extension = _extendByEpsilon(states[i], extension);
      }
    }

    return extension;
  }

  List<bool> extendByChar(List<bool> positions, int char, List<NDFAState> states) {
    var extension = List.filled(states.length, false);
    for (var i = 0; i < positions.length; i++) {
      if (positions[i]) {
        extension = _extendByChar(states[i], extension, char);
      }
    }

    return extension;
  }

  bool matches(String string) {
    print('Finding the string $string in the NDFA');
    
    final states = this.states;
    print('The states are: $states');
    
    List<bool> positions;
    var extendedPositions = List.filled(states.length, false);
    extendedPositions = _extendByEpsilon(initialState, extendedPositions);
    print('After the initial extension by epsilon, we have: $extendedPositions');
    
    if (extendedPositions[finalState.id]) {
      print('The NDFA accepts the empty string, so the string matches the NDFA');
      return true;
    }

    for (var i = 0; i < string.length; i++) {
      print('Iteration $i- Extending the positions by the character \'${string[i]}\'');
      
      positions = extendByChar(extendedPositions, string.codeUnitAt(i), states);
      positions[initialState.id] = true;
      print('The current positions are: $positions');

      extendedPositions = extendByEpsilon(positions, states);
      print('The extended positions are: $extendedPositions');

      if (extendedPositions[finalState.id]) {
        print('We have reached the final position, so the string matches the NDFA');
        return true;
      }
    }

    print('We have reached the end of string but not the final position in the NDFA- there is no match!');
    
    return false;
  }
}

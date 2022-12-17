part of '../string.dart';

abstract class RegularExp {
  const RegularExp();

  // TODO: Add parseString

  /// Constructs a regular expression that matches the given string
  const factory RegularExp.fromString(String string) = _ConcreteRegularExp;
  /// Concatenates two regular expressions that concatenates two regular expressions
  const factory RegularExp.concatenate(RegularExp exp1, RegularExp exp2) = _ConcatenatedRegularExp;
  /// Given two regular expressions, constructs the regular expression that chooses between them
  const factory RegularExp.choice(RegularExp exp1, RegularExp exp2) = _ChoiceRegularExp;
  /// Constructs the closure of the regular expression given
  const factory RegularExp.closure(RegularExp exp) = _ClosureRegularExp;
  // const factory RegularExp.bracket(RegularExp exp) = _BracketRegularExp;

  NDFA toNDFA();

  /// Returns true if this regular expression occurs in the given [text].
  bool searchIn(String text) {
    final ndfa = toNDFA();
    return ndfa.matches(text);
  }
}

class _ConcreteRegularExp extends RegularExp {
  final String string;

  const _ConcreteRegularExp(this.string);

  @override
  NDFA toNDFA() {
    final initialState = NDFAState();
    final finalState = NDFAState();

    if (string.isEmpty) {
      final edge = NDFAEdge.epsilon(finalState);
      initialState.addEdge(edge);
    } else if (string.length == 1) {
      final edge = NDFAEdge.normal(finalState, string.codeUnitAt(0));
      initialState.addEdge(edge);
    } else {
      var prevState = initialState;
      for (var i = 0; i < string.length; i++) {
        final nextState = i == string.length-1 ? finalState : NDFAState();
        final edge = NDFAEdge.normal(nextState, string.codeUnitAt(i));
        prevState.addEdge(edge);
        prevState = nextState;
      }
    }
    
    return NDFA(initialState, finalState);
  }

  @override
  String toString() => string;
}

class _ConcatenatedRegularExp extends RegularExp {
  final RegularExp exp1;
  final RegularExp exp2;

  const _ConcatenatedRegularExp(this.exp1, this.exp2);

  @override
  NDFA toNDFA() {
    final ndfa1 = exp1.toNDFA();
    final ndfa2 = exp2.toNDFA();
    
    final initialState = ndfa1.initialState;
    final finalState = ndfa2.finalState;
    
    for (var i = 0; i < ndfa2.initialState.edgeLength; i++) {
      ndfa1.finalState.addEdge(ndfa2.initialState.getEdge(i));
    }

    return NDFA(initialState, finalState);
  }

}

class _ChoiceRegularExp extends RegularExp {
  final RegularExp exp1;
  final RegularExp exp2;

  const _ChoiceRegularExp(this.exp1, this.exp2);

  @override
  NDFA toNDFA() {
    final ndfa1 = exp1.toNDFA();
    final ndfa2 = exp2.toNDFA();
    
    final initialState = NDFAState();
    final finalState = NDFAState();

    initialState.addEdge(NDFAEdge.epsilon(ndfa1.initialState));
    initialState.addEdge(NDFAEdge.epsilon(ndfa2.initialState));

    ndfa1.finalState.addEdge(NDFAEdge.epsilon(finalState));
    ndfa2.finalState.addEdge(NDFAEdge.epsilon(finalState));

    return NDFA(initialState, finalState);
  }
}

class _ClosureRegularExp extends RegularExp {
  final RegularExp exp;

  const _ClosureRegularExp(this.exp);

  @override
  NDFA toNDFA() {
    final ndfa = exp.toNDFA();
    
    final initialState = NDFAState();
    final finalState = NDFAState();

    initialState.addEdge(NDFAEdge.epsilon(ndfa.initialState));
    initialState.addEdge(NDFAEdge.epsilon(finalState));

    ndfa.finalState.addEdge(NDFAEdge.epsilon(finalState));
    ndfa.finalState.addEdge(NDFAEdge.epsilon(ndfa.initialState));
    
    return NDFA(initialState, finalState);
  }
}

// class _BracketRegularExp extends RegularExp {
//   final RegularExp exp;

//   const _BracketRegularExp(this.exp);

//   @override
//   NDFA toNDFA() => exp.toNDFA();
// }

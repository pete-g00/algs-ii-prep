part of '../graph.dart';

/// Values of type `A`, along with their preferences (indices in the `B` list)
class A {
  /// The label for the value `A`
  final String label;
  
  /// The match index in the `B` list
  int matchIdx;
  
  /// The list of preferences with indices in the B list
  late List<int> preferences;

  /// Constructs a value of type `A`
  A(this.label):matchIdx=0;

  @override
  String toString() {
    return label;
  }
}

/// Values of type `B`, along with their preferences (indices in the `A` list)
class B {
    /// The label for the value `B`
  final String label;
  
  /// The match index in the `A` list
  int matchIdx;
  
  /// The list of preferences with indices in the `A` list
  late List<int> preferences;

  /// Constructs a value of type `A`
  B(this.label):matchIdx=0;
  
  @override
  String toString() {
    return label;
  }
}

/// Given a list of [aValues] and [bValues], uses the Gale-Shapley algorithm to match 
void galeShapley(List<A> aValues, List<B> bValues) {
  Queue<int> unmatched = Queue<int>();
  for (var i = 0; i < aValues.length; i++) {
    unmatched.add(i);
  }  
  List<bool> bMatched = List.filled(bValues.length, false);

  while (unmatched.isNotEmpty) {
    final i = unmatched.removeFirst();
    final a = aValues[i];
    final bI = a.preferences[a.matchIdx];
    final b = bValues[bI];
    print('Trying to match $a. Will try $b');
    final aI = b.preferences.indexOf(i);
    if (!bMatched[bI]) {
      print('$b is unmatched, so adding the match');
      b.matchIdx = aI;
      bMatched[bI] = true;
    } else if (b.matchIdx > aI) {
      print('$b is matched, but prefers $a to its current match ${aValues[b.preferences[b.matchIdx]]}');
      final prevAI = b.preferences[b.matchIdx];
      aValues[prevAI].matchIdx ++;
      unmatched.addFirst(prevAI);
      b.matchIdx = aI;
    } else {
      print('$b is matched and does not prefer $a over its current match');
      a.matchIdx ++;
      unmatched.addFirst(i);
    }
  }
}

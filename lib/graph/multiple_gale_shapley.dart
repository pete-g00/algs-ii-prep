part of '../graph.dart';

class MultiB extends B {
  /// the number of matches we can have
  final int capacity;
  
  /// all the matched indices
  final List<int> matchIndices;

  MultiB(String label, this.capacity):matchIndices=[], super(label);

  /// whether it is possible to add an entry to 
  bool get isUnderSubscribed => matchIndices.length < capacity;

  void addMatch(int i) {
    matchIndices.add(i);
    // match index keeps track of the worst preference
    if (i > matchIdx) {
      matchIdx = i;
    }
  }
}

/// Given a list of [aValues] and [bValues], uses the multiple variant of the Gale-Shapley algorithm to match 
void multipleGaleShapley(List<A> aValues, List<MultiB> bValues) {
  Queue<int> unmatched = Queue<int>();
  for (var i = 0; i < aValues.length; i++) {
    unmatched.add(i);
  }

  while (unmatched.isNotEmpty) {
    final i = unmatched.removeFirst();
    final a = aValues[i];
    // only continue if we're at a valid matchIdx (only guaranteed if the sum of bValue capacities equals the length of aValues)
    if (a.matchIdx < a.preferences.length) {
      final bI = a.preferences[a.matchIdx];
      final b = bValues[bI];
      print('Trying to match $a. Will try $b');
      final aI = b.preferences.indexOf(i);
      if (b.isUnderSubscribed) {
        print('$b is undersubscribed, so adding the match');
        b.addMatch(aI);
      } else if (b.matchIdx > aI) {
        print('$b is at capacity, but prefers $a to its worst match ${aValues[b.preferences[b.matchIdx]]}');
        final prevAI = b.preferences[b.matchIdx];
        aValues[prevAI].matchIdx ++;
        unmatched.addFirst(prevAI);
        b.matchIdx = aI;
      } else {
        print('$b is at capacity and does not prefer $a over its worst match');
        a.matchIdx ++;
        unmatched.addFirst(i);
      }
    }
  }
}

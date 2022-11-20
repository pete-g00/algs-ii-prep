part of '../graph.dart';

class A {
  final String label;
  int matchIdx;
  late List<int> preferences;

  A(this.label):matchIdx=0;

  @override
  String toString() {
    return label;
  }
}

class B {
  final String label;
  int matchIdx;
  late List<int> preferences;

  B(this.label):matchIdx=0;
  
  @override
  String toString() {
    return label;
  }
}

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

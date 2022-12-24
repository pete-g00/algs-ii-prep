import 'package:classes/graph.dart' show A, B, galeShapley;

void main(List<String> args) {
  // construct `A` values
  final s0 = A('s0');
  final s1 = A('s1');
  final s2 = A('s2');
  final s3 = A('s3');

  // construct `B values
  final l0 = B('l0');
  final l1 = B('l1');
  final l2 = B('l2');
  final l3 = B('l3');
  
  // preferences for A values (these are indices in the B list)
  s0.preferences = [1, 3, 0, 2]; // [l1, l3, l0, l2]
  s1.preferences = [2, 0, 3, 1];
  s2.preferences = [1, 2, 0, 3];
  s3.preferences = [3, 0, 2, 1];

  l0.preferences = [1, 0, 3, 2];
  l1.preferences = [3, 2, 0, 1];
  l2.preferences = [0, 3, 2, 1];
  l3.preferences = [1, 0, 3, 2];

  final aValues = [s0, s1, s2, s3];
  final bValues = [l0, l1, l2, l3];

  // match a values and b values
  galeShapley(aValues, bValues);

  // Show the matches
  for (var i = 0; i < aValues.length; i++) {
    final a = aValues[i];
    final b = bValues[a.preferences[a.matchIdx]];
    print('$a is matched with $b');
  }
  for (var i = 0; i < bValues.length; i++) {
    final b = bValues[i];
    final a = aValues[b.preferences[b.matchIdx]];
    print('$b is matched with $a');
  }
}

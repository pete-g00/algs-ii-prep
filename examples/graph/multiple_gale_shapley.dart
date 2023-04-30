import 'package:classes/graph.dart' show A, MultiB, multipleGaleShapley;

void main(List<String> args) {
  // construct `A` values
  final s0 = A('s1');
  final s1 = A('s2');
  final s2 = A('s3');
  final s3 = A('s4');
  final s4 = A('s5');
  final s5 = A('s6');

  // construct `B values
  final u0 = MultiB('u1', 2);
  final u1 = MultiB('u2', 2);
  final u2 = MultiB('u3', 2);
  
  // preferences for A values (these are indices in the B list)
  s0.preferences = [0, 2, 1]; // [u1, u3, u2]
  s1.preferences = [1, 0, 2];
  s2.preferences = [1, 0, 2];
  s3.preferences = [1, 0, 2];
  s4.preferences = [0, 1, 2];
  s5.preferences = [1, 2, 0];

  u0.preferences = [1, 2, 0, 4, 3, 5]; // [s2, s3, s1, s5, s4, s6]
  u1.preferences = [0, 3, 1, 2, 4, 5];
  u2.preferences = [2, 1, 0, 4, 5, 3];

  final aValues = [s0, s1, s2, s3, s4, s5];
  final bValues = [u0, u1, u2];

  // match a values and b values
  multipleGaleShapley(aValues, bValues);

  // Show the matches
  for (var i = 0; i < aValues.length; i++) {
    final a = aValues[i];
    if (a.matchIdx < a.preferences.length) {
      final b = bValues[a.preferences[a.matchIdx]];
      print('$a is matched with $b');
    } else {
      print('$a is unmatched');
    }
  }
}

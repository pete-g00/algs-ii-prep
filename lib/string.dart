library string;

import 'dart:math' show max;
import 'dart:collection' show Queue;
import 'common.dart';

part 'string/longest_common_subsequence.dart';
part 'string/longest_common_substring.dart';
part 'string/ndfa.dart';
part 'string/regular_exp.dart';
part 'string/trie_and_tree.dart';
part 'string/smith_waterman.dart';

// void main(List<String> args) {
//   String s1 = 'dbacacbabcdac';
//   String s2 = 'dbcbdaadcabdc';
//   print(tableLCSq(s1, s2));
//   // tableMemoisedLCSq(s1, s2);
// }

// void main(List<String> args) {
//   const exp1 = RegularExp.fromString('a');
//   const exp2 = RegularExp.fromString('b');
//   const exp3 = RegularExp.fromString('ac');
//   const exp4 = RegularExp.fromString('d');

//   const exp5 = RegularExp.closure(exp1); // a*
//   const exp6 = RegularExp.concatenate(exp5, exp2); // a*b
//   const exp7 = RegularExp.choice(exp6, exp3); // a*b|ac

//   const exp = RegularExp.concatenate(exp7, exp4); // (a*b|ac)d


//   // const exp1 = RegularExp.fromString('a');
//   // const exp2 = RegularExp.fromString('b');
//   // const exp3 = RegularExp.fromString('c');
//   // const exp4 = RegularExp.fromString('d');
//   // const exp5 = RegularExp.fromString('e');
  
//   // const exp6 = RegularExp.choice(exp2, exp3); // b|c
//   // const exp7 = RegularExp.closure(exp6); // (b|c)*
//   // const exp8 = RegularExp.concatenate(exp1, exp7); // a(b|c)*
//   // const exp9 = RegularExp.choice(exp4, exp5); // d|e
  
//   // const exp = RegularExp.concatenate(exp8, exp9); // a(b|c)*(d|e)

//   final ndfa = exp.toNDFA();
//   print(ndfa.initialState);
//   print(ndfa.matches('caabcacaba'));
// }

// void main(List<String> args) {
//   final s1 = 'ababb';
//   final s2 = 'baab';
//   print(tracebackLCSq(s1, s2));
// }

void main(List<String> args) {
  print(tableSmithWaterman('abacbadecadbe', 'dcadcabdcbeba'));
}

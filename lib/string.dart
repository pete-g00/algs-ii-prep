import 'dart:math' show max;
import 'dart:io' show stdout, File;
import 'dart:collection' show Queue;

part 'string/longest_common_subsequence.dart';
part 'string/longest_common_substring.dart';
part 'string/ndfa.dart';
part 'string/regular_exp.dart';
part 'string/trie_and_tree.dart';
part 'string/smith_waterman.dart';

void _prettyPrint<E>(List<List<E>> list) {
  stdout.write('[');
  for (var i = 0; i < list.length-1; i++) {
    print(list[i]);
    stdout.write(' ');
  }
  stdout.write(list[list.length-1]);
  print(']');
}

void _latexPrint<E>(List<List<E>> list) {
  for (var i=0; i < list.length-1; i++) {
    stdout.write(list[i].join(" & "));
    stdout.writeln(' \\\\');
  }
  stdout.write(list[list.length-1].join(" & "));
  stdout.writeln();
}

void _latexPrintTuple<E>(List<List<E>> l1, List<List<E>> l2) {
  for (var i=0; i<l1.length; i++) {
    for (var j=0; j<l1[0].length; j++) {
      stdout.write('(${l1[i][j]}, ${l2[i][j]})');
      if (j != l1[0].length-1) {
        stdout.write(' & ');
      }
    }
    if (i != l1.length-1) {
      stdout.write(' //');
    }
    stdout.writeln();
  }
}

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
  print(rowSmithWaterman('DGACTA', 'ADGGAGTAC'));
}

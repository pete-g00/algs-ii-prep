library hard;

import 'dart:math' show min, max;
import 'dart:io' show stdout;

part 'hard/colour_backtracking.dart';
part 'hard/knapsack.dart';
part 'hard/subset_problem.dart';

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

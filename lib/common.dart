library _common;

import 'dart:io' show stdout;

void prettyPrint<E>(List<List<E>> list) {
  stdout.write('[');
  for (var i = 0; i < list.length-1; i++) {
    print(list[i]);
    stdout.write(' ');
  }
  stdout.write(list[list.length-1]);
  print(']');
}

void latexPrint<E>(List<List<E>> list) {
  stdout.writeln("\\begin{tabular}{${List.filled(list[0].length, "c").join("|")}}");
  for (var i=0; i < list.length-1; i++) {
    stdout.write("\t");
    stdout.write(list[i].join(" & "));
    stdout.writeln(' \\\\');
    stdout.writeln('\t\\hline');
  }
  stdout.write("\t");
  stdout.writeln(list[list.length-1].join(" & "));
  stdout.writeln("\\end{tabular}");
}

void main(List<String> args) {
  final table = [
    [1, 2, 0],
    [3, 4, 5]
  ];
  latexPrint(table);
}

void latexPrintTuple<E>(List<List<E>> l1, List<List<E>> l2) {
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

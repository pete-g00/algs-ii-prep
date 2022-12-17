import 'package:classes/string.dart' show RegularExp;

void main(List<String> args) {
  // construct the regexp l*is
  final r0 = RegularExp.fromString('is'); // is
  final r1 = RegularExp.fromString('l'); // l
  final r2 = RegularExp.closure(r1); // l*
  final regexp = RegularExp.concatenate(r2, r0); // l*is
  final text = 'Aenean iaculis convallis pharetra. Integer venenatis imperdiet faucibus. Phasellus vitae hendrerit ligula. Vestibulum nec aliquam ligula, at varius elit. Vivamus vestibulum leo enim, non tincidunt mauris volutpat nec. Suspendisse maximus turpis ex, sit amet ornare libero pharetra quis. Praesent euismod risus a tortor efficitur mollis. Fusce leo ante, rhoncus a sollicitudin quis, sollicitudin eu turpis.';
  // search whether the text matches regexp
  print(regexp.searchIn(text));
}
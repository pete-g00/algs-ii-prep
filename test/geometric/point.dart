import 'package:test/test.dart';
import 'package:classes/geometric.dart' show Point;

void main() {
  group('Point', () {
    test('.toString() prints correctly', () {
      final point = Point(1, 5);
      expect(point.toString(), '(1.0, 5.0)');
    });
    
    test('.distance2(p1, p2) returns the correct distance', () {
      final p1 = Point(0, 1);
      final p2 = Point(3, 3);
      final d = Point.distance2(p1, p2);
      expect(d, 13);
    });

    test('.distance(p1, p2) returns the correct distance', () {
      final p1 = Point(0, 0);
      final p2 = Point(3, 4);
      final d = Point.distance(p1, p2);
      expect(d, 5);
    });

    test('.== works for valid points', () {
      final p1 = Point(0, 0);
      final p2 = Point(0, 0);
      expect(p1 == p2, true);
    });

    test('.== doesn\'t works for invalid points', () {
      final p1 = Point(0, 0);
      final p2 = Point(0, 2);
      expect(p1 == p2, false);
    });
  });
}

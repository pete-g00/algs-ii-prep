import 'package:test/test.dart';
import 'package:classes/geometric.dart' show Point, Line;

void main() {
  group('Line', () {
    final point1 = Point(0, 0);
    final point2 = Point(2, 1);
    final line = Line(point1, point2);

    test('.toString() works as expected', () {
      expect(line.toString(), 'Line from (0.0, 0.0) to (2.0, 1.0)');
    });

    test('.onOppositeSides(p1, p2) works with opposite side points', () {
      final p1 = Point(1, 1);
      final p2 = Point(1, 0);

      expect(line.onOppositeSides(p1, p2), true);
    });
    
    test('.onOppositeSides(p1, p2) doesn\'t work with points on the same side', () {
      final p1 = Point(2, 0);
      final p2 = Point(1, 0);

      expect(line.onOppositeSides(p1, p2), false);
    });

    test('.intersect(other) works with different gradients', () {
      final p1 = Point(1, 1);
      final p2 = Point(1, 0);
      final other = Line(p1, p2);

      expect(line.intersect(other), true);
    });
    
    test('.intersect(other) doesn\'t work with parallel lines', () {
      final p1 = Point(1, 0);
      final p2 = Point(3, 1);
      final other = Line(p1, p2);

      expect(line.intersect(other), false);
    });

    test('.intersect(other) works with same lines', () {
      final p1 = Point(2, 1);
      final p2 = Point(0, 0);
      final other = Line(p1, p2);

      expect(line.intersect(other), true);
    });
  });
}

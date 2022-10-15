import 'package:test/test.dart';
import 'package:classes/geometric.dart' show Point, LineSegment;

void main() {
  group('Line', () {
    final point1 = Point(0, 0);
    final point2 = Point(2, 1);
    final line = LineSegment.from(point1, point2);

    test('.toString() works as expected', () {
      expect(line.toString(), 'Line segment from (0.0, 0.0) to (2.0, 1.0)');
    });

    test('.intersect(other) works with two opposite sides and intersecting bounding box', () {
      final p1 = Point(1, 1);
      final p2 = Point(1, 0);
      final other = LineSegment.from(p1, p2);

      expect(line.intersect(other), true);
    });
    
    test('.intersect(other) doesn\'t work with points on the same side', () {
      final p1 = Point(2, 0);
      final p2 = Point(1, 0);
      final other = LineSegment.from(p1, p2);

      expect(line.intersect(other), false);
    });

    test('.intersect(other) doesn\'t work with non-intersecting bounding boxes', () {
      final p1 = Point(-1, 1);
      final p2 = Point(0, -1);
      final other = LineSegment.from(p1, p2);

      expect(line.intersect(other), false);
    });
  });
}

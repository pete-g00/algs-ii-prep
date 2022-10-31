import 'package:test/test.dart';
import 'package:classes/geometric.dart' show Point, Rectangle;

void main() {
  group('Rectangle', () {
    final point1 = Point(0, 1);
    final point2 = Point(2, 0);
    final rectangle = Rectangle(point1, point2);

    test('getters work as expected', () {
      expect(rectangle.bottomLeft, Point(0, 0));
      expect(rectangle.bottomRight, Point(2, 0));
      expect(rectangle.topLeft, Point(0, 1));
      expect(rectangle.topRight, Point(2, 1));
    });

    test('.toString() works as expected', () {
      expect(rectangle.toString(), 'Rectangle with corners (0.0, 1.0) and (2.0, 0.0)');
    });

    test('.intersect(other) works when there is an intersection', () {
      final p1 = Point(1, 0.5);
      final p2 = Point(3, 1.5);
      final other = Rectangle(p1, p2);

      expect(rectangle.intersect(other), true);
    });
    
    test('.intersect(other) doesn\'t work when the x-coordinates intersect but not y', () {
      final p1 = Point(1, -0.5);
      final p2 = Point(3, -1.5);
      final other = Rectangle(p1, p2);

      expect(rectangle.intersect(other), false);
    });
    
    test('.intersect(other) doesn\'t work when the y-coordinates intersect but not x', () {
      final p1 = Point(-1, 0.5);
      final p2 = Point(-3, 1.5);
      final other = Rectangle(p1, p2);

      expect(rectangle.intersect(other), false);
    });
  });
}

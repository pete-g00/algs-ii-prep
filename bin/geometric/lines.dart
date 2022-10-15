import 'dart:math';

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);

  static double distance2(Point p1, Point p2) {
    return pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2) as double;
  }

  static double distance(Point p1, Point p2) => sqrt(distance2(p1, p2));

  @override
  String toString() => '($x, $y)';
}

abstract class Line {
  Point get p1;
  Point get p2;

  Point? intersect(Line l2);
}

abstract class LineSegment {
  Point get p1;
  Point get p2;

  Point? intersect(LineSegment l2);
}

// class HorizontalLineSegment
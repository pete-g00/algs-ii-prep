part of '../geometric.dart';

/// Represents a (2D) point, with x-coordinate [x] and y-coordinate [y].
class Point {
  /// The x-coordinate of the point
  final double x;  
  /// The y-coordinate of the point
  final double y;

  /// Constructs a point given the [x]-coordinate and the [y]-coordinate.
  const Point(this.x, this.y);

  /// Computes the square distance between two points
  static double distance2(Point p1, Point p2) {
    return pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2) as double;
  }

  /// Computes the distance between two points
  static double distance(Point p1, Point p2) => sqrt(distance2(p1, p2));

  @override
  String toString() => '($x, $y)';

  @override
  int get hashCode => hash2(x, y);

  @override
  bool operator ==(Object other) {
    if (other is Point) {
      return x == other.x && y == other.y;
    }
    return false;
  }
}

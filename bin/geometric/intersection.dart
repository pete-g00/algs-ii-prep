import 'dart:math' show min, max;
import 'package:quiver/core.dart' show hash2;

// TODO: Setup github repo
// TODO: Add simple polygon and convex hull

/// Represents a (2D) point, with x-coordinate [x] and y-coordinate [y].
class Point {
  /// The x-coordinate of the point
  final double x;
  /// The y-coordinate of the point
  final double y;

  /// Constructs a point given the [x]-coordinate and the [y]-coordinate.
  const Point(this.x, this.y);

  @override
  String toString() => '($x, $y)';

  @override
  int get hashCode => hash2(x, y);

  @override
  bool operator ==(Object point) {
    if (point is Point) {
      return x == point.x && y == point.y;
    }
    return false;
  }
}

/// Represents a (2D) straight line going from [p1] to [p2]
class Line {
  /// The first point on the line
  final Point p1;
  /// The second point on the line
  final Point p2;

  /// Constructs a line given two points on it- [p1] and [p2]
  const Line(this.p1, this.p2);

  /// Checks whether the two lines [l1] and [l2] intersect.
  /// 
  /// Two lines intersect if and only if either their gradients do not match or both their gradient and the y-offset match.
  static bool intersect(Line l1, Line l2) {
    final dx1 = l1.p1.x - l1.p2.x;
    final dy1 = l1.p1.y - l1.p2.y;
    final dx2 = l2.p1.x - l2.p2.x;
    final dy2 = l2.p1.y - l2.p2.y;
    
    if (dy1 * dx2 != dy2 * dx1) {
      print('> The gradients do not match, so they do not intersect');
      return true;
    }
    final c1 = dx1*l1.p1.y - dy1*l1.p1.x;
    final c2 = dx2*l2.p1.y - dy2*l2.p1.x;

    if (dx2*c1 == dx1*c2) {
      print('> The gradients match and the y-offsets match, so the lines are the same (and hence intersect)');
      return true;
    } else {
      print('> The gradients match but the y-offsets don\'t match, so the lines are parallel and never intersect');
      return false;
    }
  }

  /// Checks whether the two points [p1] and [p2] lie on opposite sides of the line
  bool onOppositeSides(Point p1, Point p2) {
    final o1 = (this.p2.x - this.p1.x) * (p1.y - this.p1.y)  - (this.p2.y - this.p1.y) * (p1.x - this.p1.x);
    final o2 = (this.p2.x - this.p1.x) * (p2.y - this.p1.y)  - (this.p2.y - this.p1.y) * (p2.x - this.p1.x);

    if ((o1 < 0 && o2 < 0) || (o1 > 0 && o2 > 0)) {
      print('> The signs match for both the points, so they are on the same side');
      return false;
    } else {
      print('> The signs do not match for the two points, so they are on different sides');
      return true;
    }
  }

  @override
  String toString() => 'Line from $p1 to $p2';
}

/// Represents a rectangle with opposite corners at [p1] and [p2]
class Rectangle {
  /// The point at one of the corner in the rectangle, opposite to [p2]
  final Point p1;
  /// The point at one of the corner in the rectangle, opposite to [p1]
  final Point p2;

  /// Constructs a rectangle given two opposite corners [p1] and [p2]
  const Rectangle(this.p1, this.p2);

  /// The coordinate of the bottom left corner of the rectangle
  Point get bottomLeft {
    final x = min(p1.x, p2.x);
    final y = min(p1.y, p2.y);
    return Point(x, y);
  }

  /// The coordinate of the bottom right corner of the rectangle
  Point get bottomRight {
    final x = max(p1.x, p2.x);
    final y = min(p1.y, p2.y);
    return Point(x, y);
  }

  /// The coordinate of the top left corner of the rectangle
  Point get topLeft {
    final x = min(p1.x, p2.x);
    final y = max(p1.y, p2.y);
    return Point(x, y);
  }

  /// The coordinate of the top right corner of the rectangle
  Point get topRight {
    final x = max(p1.x, p2.x);
    final y = max(p1.y, p2.y);
    return Point(x, y);
  }

  /// Given two rectangles [r1] and [r2], returns whether they intersect or not.
  /// 
  /// This corresponds to checking whether the top right and the bottom left coordinates are intertwined.
  static bool intersect(Rectangle r1, Rectangle r2) {
    if (r2.bottomLeft.x > r1.topRight.x) {
      print('>> The bottom left x-coordinate of r2 is further from the top right x-coordinate of r1- they cannot intersect');
      return false;
    } else if (r1.bottomLeft.x > r2.topRight.x) {
      print('>> The bottom left x-coordinate of r1 is further from the top right x-coordinate of r2- they cannot intersect');
      return false;
    } else if (r2.bottomLeft.y > r1.topRight.y) {
      print('>> The bottom left y-coordinate of r2 is further from the top right y-coordinate of r1- they cannot intersect');
      return false;
    } else if (r1.bottomLeft.y > r2.topRight.y) {
      print('>> The bottom left y-coordinate of r1 is further from the top right y-coordinate of r2- they cannot intersect');
      return false;
    }
    print('>> The rectangles intersect as their top right and bottom left coordinates are intertwined');
    return true;
  }

  @override
  String toString() => 'Rectangle with corners $p1 and $p2';
}

/// Represents a line segment starting at [p1] and ending at [p2]
class LineSegment {
  /// The first point on the line segment
  final Point p1;
  /// The second point on the line segment
  final Point p2;

  /// Constructs a line segment given two points [p1] and [p2]
  const LineSegment(this.p1, this.p2);

  /// Checks whether two line segments [l1] and [l2] intersect.
  /// 
  /// Two line segments intersect if and only if:
  /// * the bounding box for the corresponding rectangles intersect,
  /// * the points on [l1] lie on opposite sides of [l2], and
  /// * the points on [l2] lie on opposite sides of [l1].
  static bool intersect(LineSegment l1, LineSegment l2) {
    if (!l2.toLine().onOppositeSides(l1.p1, l1.p2)) {
      print('> The points on l1 do not lie on opposite sides of l1');
      return false;
    } else if (!l1.toLine().onOppositeSides(l2.p1, l2.p2)) {
      print('> The points on l2 do not lie on opposite sides of l2');
      return false;
    } else if (!Rectangle.intersect(l1.toRectangle(), l2.toRectangle())) {
      print('> The bounding boxes for the corresponding rectangles for the line segments do not intersect');
      return false;
    }
    print('> So, the line segments intersect');
    return true;
  }

  /// Converts a line segment to a rectangle
  Rectangle toRectangle() {
    return Rectangle(p1, p2);
  }

  /// Converts a line segment to a line
  Line toLine() {
    return Line(p1, p2);
  }

  @override
  String toString() => 'Line segment from $p1 to $p2';
}

void main(List<String> args) {
  const p1 = Point(0, 0);
  const p2 = Point(1, 0);
  const l1 = Line(p1, p2);
  
  const p3 = Point(2, 0);
  const p4 = Point(3, 0);
  const l2 = Line(p3, p4);

  print(Line.intersect(l1, l2));
}

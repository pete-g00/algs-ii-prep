part of '../geometric.dart';

abstract class LineSegment {
  /// The first point on the line segment
  Point get p1;
  /// The second point on the line segment
  Point get p2;

  const LineSegment();

  /// Constructs a line segment given two points [p1] and [p2]
  const factory LineSegment.from(Point p1, Point p2) = _LineSegment;

  /// Constructs a horizontal line segment from ([x1], [y]) to ([x2], [y])
  const factory LineSegment.horizontal(double x1, double x2, double y) = HorizontalLineSegment;
  
  /// Constructs a vertical line segment from ([x], [y1]) to ([x], [y2])
  const factory LineSegment.vertical(double x, double y1, double y2) = VerticalLineSegment;

  /// Checks whether two line segments this line intersects the [other] line segment.
  /// 
  /// Two line segments intersect if and only if:
  /// * the bounding box for the corresponding rectangles intersect,
  /// * the points on this line lie on opposite sides of [other], and
  /// * the points on [other] lie on opposite sides of this line.
  bool intersect(LineSegment other) {
    print('Checking whether two generic line segments intersect');
    if (!other.toLine().onOppositeSides(p1, p2)) {
      print('> The points on this line do not lie on opposite sides of the other line');
      return false;
    } else if (!toLine().onOppositeSides(other.p1, other.p2)) {
      print('> The points on the other line do not lie on opposite sides of this line');
      return false;
    } else if (!toRectangle().intersect(toRectangle())) {
      print('> The bounding boxes for the corresponding rectangles of the line segments do not intersect');
      return false;
    }
    print('> The line segments intersect');
    return true;
  }

  /// Converts a line segment to a rectangle
  Rectangle toRectangle() => Rectangle(p1, p2);

  /// Converts a line segment to a line
  Line toLine() => Line(p1, p2);

  @override
  String toString() => 'Line segment from $p1 to $p2';
}

class _LineSegment extends LineSegment {
  @override
  final Point p1;
  @override
  final Point p2;

  const _LineSegment(this.p1, this.p2);
}

abstract class _StraightLineSegment extends LineSegment {
  double get start;
  double get end;
  double get constant;

  const _StraightLineSegment();
}

class HorizontalLineSegment extends _StraightLineSegment {
  @override
  final double start;
  @override
  final double end;
  @override
  final double constant;

  const HorizontalLineSegment(this.start, this.end, this.constant);

  @override
  Point get p1 => Point(start, constant);
  @override
  Point get p2 => Point(end, constant);
}

class VerticalLineSegment extends _StraightLineSegment {
  @override
  final double start;
  @override
  final double end;
  @override
  final double constant;

  const VerticalLineSegment(this.constant, this.start, this.end);

  @override
  Point get p1 => Point(constant, start);
  @override
  Point get p2 => Point(constant, end);
}

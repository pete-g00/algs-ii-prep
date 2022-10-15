part of '../geometric.dart';

/// Represents a (2D) straight line going from [p1] to [p2]
class Line {
  /// The first point on the line
  final Point p1;  
  /// The second point on the line
  final Point p2;

  /// Constructs a line given two points on it- [p1] and [p2]
  const Line(this.p1, this.p2);

  double get _dx => p1.x - p2.y;
  double get _dy => p1.y - p2.y;

  /// Checks whether ths line intersects the line [other].
  /// 
  /// Two lines intersect if and only if either their gradients do not match or both their gradient and the y-offset match.
  bool intersect(Line other) {
    // check gradients don't match
    final dx1 = _dx;
    final dy1 = _dy;
    final dx2 = other._dx;
    final dy2 = other._dy;
    
    if (dy1 * dx2 != dy2 * dx1) {
      print('> The gradients do not match, so they do intersect');
      return true;
    }

    // if gradients match, check y-offset also matches

    final c1 = dx1*p1.y - dy1*p1.x;
    final c2 = dx2*other.p1.y - dy2*other.p1.x;

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
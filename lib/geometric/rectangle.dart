part of '../geometric.dart';

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
  
  /// Checks whether this rectangle intersects the rectangle [other].
  /// 
  /// This corresponds to checking whether the top right and the bottom left coordinates are intertwined.
  bool intersect(Rectangle other) {
    if (other.bottomLeft.x > topRight.x) {
      print('>> The bottom left x-coordinate of the other rectangle is further from the top right x-coordinate of this rectangle- they cannot intersect');
      return false;
    } else if (bottomLeft.x > other.topRight.x) {
      print('>> The bottom left x-coordinate of this rectangle is further from the top right x-coordinate of the other rectangle- they cannot intersect');
      return false;
    } else if (other.bottomLeft.y > topRight.y) {
      print('>> The bottom left y-coordinate of the other rectangle is further from the top right y-coordinate of this rectangle- they cannot intersect');
      return false;
    } else if (bottomLeft.y > other.topRight.y) {
      print('>> The bottom left y-coordinate of this rectangle is further from the top right y-coordinate of the other rectangle- they cannot intersect');
      return false;
    }
    print('>> The rectangles intersect as their top right and bottom left coordinates are intertwined');
    return true;
  }

  /// Computes the intersection between the two "normal" rectangles
  Rectangle intersection(Rectangle other) {
    final newBottomLeft = Point(
      max(bottomLeft.x, other.bottomLeft.x),
      max(bottomLeft.y, other.bottomLeft.y)
    );
    final newTopRight = Point(
      min(topRight.x, other.topRight.x),
      min(topRight.y, other.topRight.y)
    );

    return Rectangle(newBottomLeft, newTopRight);
  }

  @override
  String toString() => 'Rectangle with corners $p1 and $p2';
}

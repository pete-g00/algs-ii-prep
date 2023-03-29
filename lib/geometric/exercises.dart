part of '../geometric.dart';

// q4

/// Horizontal line segments that lie at the origin
class XHorizontalLineSegment extends HorizontalLineSegment {
  const XHorizontalLineSegment(double start, double end):super(start, end, 0);
}

/// Given a list of horizontal line segments on the x-axis that lie at the origin,
/// returns `true` if any of the lines intersect; `false` otherwise.
/// 
/// The algorithm first sorts the segments wrt their starting coordinate. 
/// Then, it checks whether the next starting coordinate is smaller than the current ending coordinate.
bool originHorizontalLinesIntersect(List<XHorizontalLineSegment> lineSegments) {
  // sort wrt the starting coordinate
  lineSegments.sort((l1, l2) => l1.start.compareTo(l2.start));

  // check whether any two line segments are intertwined (next one starts before the current one ends)
  for (var i = 0; i < lineSegments.length-1; i++) {
    if (lineSegments[i].end >= lineSegments[i+1].start) {
      return true;
    }
  }

  return false;
}

// q5

/// Given a list of "normal" rectangles, computes their intersection
Rectangle rectanglesIntersection(List<Rectangle> rectangles) {
  if (rectangles.isEmpty) {
    return Rectangle(Point(0, 0), Point(0, 0));
  }
  
  var intersection = rectangles[0];
  for (var i = 1; i < rectangles.length; i++) {
    intersection = intersection.intersection(rectangles[i]);
  }
  return intersection;
}


// q11

/// Checks whether [p1] domaintes [p2], i.e. both x and y-coordinates are higher
bool dominate(Point p1, Point p2) {
  return p1.x >= p2.x && p2.x >= p1.x;
}

/// Given a list of [points] and an index [i], 
/// checks whether `points[i]` is maximal in the list.
bool isMaximal(List<Point> points, int i) {
  for (var j = 0; j < points.length && j != i; j++) {
    if (dominate(points[j], points[i])) {
      return false;
    }
  }

  return true;
}

List<Point> getMaximalPoints(List<Point> points) {
  // sort the points wrt x coordinate
  points.sort((p1, p2) => p1.x.compareTo(p2.x));

  final maximalPoints = <Point>[points[points.length-1]];
  
  // add a point as long as it has a higher y-coordinate (cannot be dominated by any of the values we've seen before)
  var maxY = points[points.length-1].y;
  for (var i = points.length-2; i >= 0; i--) {
    if (points[i].y > maxY) {
      maximalPoints.add(points[i]);
      maxY = points[i].y;
    }
  }

  return maximalPoints;
}

// q12

/// Given a list of [points] sorted with respect to the x-coordinate,
/// uses a binary search to find a point with the given [x] value (within indices [p] and [r]).
/// 
/// There is no guarantee which element will be returned if there are many points with x-coordinate [x].
Point? binarySearchX(List<Point> points, double x, [int p=0, int? r]) {
  r ??= points.length-1;

  if (p < r) {
    final q = (p + r) ~/ 2;
    if (points[q].x == x) {
      return points[q];
    } else if (points[q].x < x) {
      return binarySearchX(points, x, p, q-1);
    } else {
      return binarySearchX(points, x, q+1, r);
    }
  }

  return null;
}

/// Given a list of [points], checks whether there exists a triple P, Q, R 
/// such that the midpoint of P and Q is R.
/// 
/// Assumes that each point has a distinct x and y coordinate.
bool existsMidpoint(List<Point> points) {
  // sort the points w.r.t. x-coordinate
  points.sort((p1, p2) => p1.x.compareTo(p2.x));

  for (var i = 0; i < points.length; i++) {
    for (var j = 0; j < points.length && j != i; j++) {
      final midX = (points[i].x + points[j].x)/2;
      final midY = (points[i].y + points[j].y)/2;
      final point = binarySearchX(points, midX);
      if (point != null && point.y == midY) {
        return true;
      }
    }
  }

  return false;
}

// q13

/// Given a list of [points], checks whether there exist 4 points 
/// that form the corners of a rectangle. 
/// 
/// Assumes that each point has a distinct x and y coordinate.
bool existsRectangle(List<Point> points) {
  // sort the points w.r.t. x-coordinate
  points.sort((p1, p2) => p1.x.compareTo(p2.x));

  for (var i = 0; i < points.length; i++) {
    for (var j = 0; j < points.length && j != i; j++) {
      final rect = Rectangle(points[i], points[j]);

      // find the other two corners of the rectangle
      Point? p1;
      Point? p2;

      void setPoint(Point point) {
        if (p1 == null) {
          p1 = point;
        } else {
          p2 = point;
        }
      }
      
      if (rect.bottomLeft != points[i] && rect.bottomLeft != points[j]) {
        setPoint(rect.bottomLeft);
      } 
      if (rect.bottomRight != points[i] && rect.bottomRight != points[j]) {
        setPoint(rect.bottomRight);
      }
      if (rect.topLeft != points[i] && rect.topLeft != points[j]) {
        setPoint(rect.topLeft);
      } 
      if (rect.topRight != points[i] && rect.topRight != points[j]) {
        setPoint(rect.topRight);
      }

      // try to find the other two points- if they exist and y-coordinates match, return true
      final point1 = binarySearchX(points, p1!.x);
      final point2 = binarySearchX(points, p1!.y);
      if (point1 != null && p1!.y == point1.y && point2 != null && p2!.y == point2.y) {
        return true;
      }
    }
  }

  return false;
}

class DiagonalLineSegment extends LineSegment {
  final double startX;
  final double endX;
  final double yOffset;

  const DiagonalLineSegment(this.startX, this.endX, this.yOffset);

  @override
  Point get p1 => Point(startX, startX + yOffset);

  @override
  Point get p2 => Point(endX, endX + yOffset);
}

int intersectionsBetweenDiagonalAndVertical(List<DiagonalLineSegment> diagonals, List<VerticalLineSegment> verticals) {
  print('Computing the number of intersections between the given list of diagonal and vertical line segments');

  print('Sorting the vertical line segments with respect to their y-coordinate');
  verticals.sort((a, b) => a.constant.compareTo(b.constant));
  print('The sorted list is: $verticals');
  
  print('Sorting the diagonal line segments with respect to the x-coordinate (both at start and end)');
  final diagonalTuples = <_LineTuple<DiagonalLineSegment>>[];
  for (var i = 0; i < diagonals.length; i++) {
    diagonalTuples.add(_LineTuple(diagonals[i], true));
    diagonalTuples.add(_LineTuple(diagonals[i], false));
  }
  diagonalTuples.sort();
  print('The sorted list is: $diagonalTuples');
  
  var i = 0;
  var j = 0;
  final candidates = <double>{};
  var count = 0;

  // while we have both a horizontal segment and a vertical segment left to consider,
  while (i < verticals.length && j < diagonalTuples.length) {
    print('Trying to check for intersection with the vertical line ${verticals[i]}');
    
    print('Adding/removing horizontal lines with x-coordinate < ${verticals[i].constant}');
    while (j < diagonalTuples.length && diagonalTuples[j].x < verticals[i].constant) {
      if (diagonalTuples[j].isStart) {
      print('Inserting the ${diagonalTuples[j]}, i.e. value ${diagonalTuples[j].line.yOffset}');
        candidates.add(diagonalTuples[j].line.yOffset);
      } else {
        print('Removing the ${diagonalTuples[j]}, i.e. value ${diagonalTuples[j].line.yOffset}');
        candidates.remove(diagonalTuples[j].line.yOffset);
      }
      j++;
    }

    print('Adding vertical lines with x-coordinate = ${verticals[i].constant}');
    while (j < diagonalTuples.length && diagonalTuples[j].x == verticals[i].constant && diagonalTuples[j].isStart) {
      print('Inserting the ${diagonalTuples[j]}, i.e. value ${diagonalTuples[j].line.yOffset}');
      candidates.add(diagonalTuples[j].line.yOffset);
      j++;
    }

    print('Computing any intersections');
    if (candidates.isNotEmpty) {
      final newMatches = _search(candidates, verticals[i].constant - verticals[i].end, verticals[i].constant - verticals[i].start);
      print('Found $newMatches intersections!');
      count += newMatches;
    }
    
    print('Removing horizontal lines with x-coordinate = ${verticals[i].constant}');
    while (j < diagonalTuples.length && diagonalTuples[j].x == verticals[i].constant) {
      print('Removing the ${diagonalTuples[j]}, i.e. value ${diagonalTuples[j].line.yOffset}');
      candidates.remove(diagonalTuples[j].line.yOffset);
      j++;
    }

    i++;
  }
  print('In total, there are $count intersections');

  return count;
}


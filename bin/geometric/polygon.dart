import './intersection.dart';
import 'dart:math' show atan2, pow;

/// Given a list of points, this algorithm reorders them so that the points can be connected to form a simple polygon going through the points.
/// 
/// Must have at least 3 points for the algorithm to work.
/// 
/// If all the points are collinear, then it throws an error.
void simplePolygon(List<Point> points) {
  if (points.length < 3) {
    throw StateError('Cannot construct a simple polygon if there are less than 3 points');
  }

  // find the point and index with the largest x-coordinate (and smallest y-coordinate)
  var i  = 0;
  var pivot = points[0];
  for (var j = 1; j < points.length; j++) {
    // Change the pivot if:
    // * if this point has x-coordinate bigger than the current pivot; or
    // * if this point has the same x-coordinate as the current pivot, and y coordinate smaller than the current pivot.
    if (pivot.x < points[j].x || (pivot.x == points[j].x && pivot.y < points[j].y)) {
      pivot = points[j];
      i = j;
    }
  }

  // move the pivot to the start
  points[i] = points[0];
  points[0] = pivot;
  print('> The pivot is $pivot');

  final angles = <Point, double>{};
  final distances = <Point, double>{};

  // sort the points wrt angle it makes with the pivot
  points.sort((p1, p2) {
    final angle1 = angles[p1] ?? atan2(pivot.x - p1.x, pivot.y - p1.y);
    angles[p1] = angle1;

    final angle2 = angles[p2] ?? atan2(pivot.x - p2.x, pivot.y - p2.y);
    angles[p2] = angle2;

    print('> $p1 makes angle $angle1, while $p2 makes angle $angle2 to the pivot');

    final comp = angle1.compareTo(angle2);
    
    // if the angles don't match => use the compareTo result
    if (comp != 0) {
      print('> Angles do not match!');
      return comp;
    }
    
    // otherwise, compare the distance between pivot and the points => the smaller one comes first
    else {
      print('> Angles match!');
      final d12 = distances[p1] ?? pow(pivot.x - p1.x, 2) + pow(pivot.y - p1.y, 2) as double;
      distances[p1] = d12;

      final d22 = distances[p2] ?? pow(pivot.x - p2.x, 2) + pow(pivot.y - p2.y, 2) as double;
      distances[p2] = d22;

      print('> The distance between the pivot and $p1 is $d12, and the distance between the pivot and $p2 is $d22');
      
      return d12.compareTo(d22);
    }
  });
  print('> Without considering final collinearity, the sorted order is: $points');

  // flip the collinear ones at the end
  final lastAngle = angles[points[points.length-1]];
  var j = points.length-1;
  double curAngle;
  
  do {
    j--;
    curAngle = angles[points[j]]!;
  } while (curAngle == lastAngle && j >= 1);

  if (j == 0) {
    throw StateError('All the points are collinear.');
  }

  j++;
  var k = points.length-1;
  print('> Reversing between points[$j] to points[$k]');

  while (j <= k-1) {
    var temp = points[j];
    points[j] = points[k];
    points[k] = temp;

    j++;
    k--;
  }
}

double orientation(Point p, Point q, Point r) => (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y);

List<Point> grahamScan(List<Point> points) {
  simplePolygon(points);
  print('> After sorting the points, the order is $points');
  final convexHull = [points[0], points[1], points[2]];
  print('> Initialising the convexHull with $convexHull');
  
  // add all the other points to the list => remove if the last 3 form a left angle UNTIL it doesn't
  for (var i = 3; i < points.length; i++) {
    print('> Adding points[$i] = ${points[i]} to the convex hull');
    // negative => angle is greater than pi
    while (orientation(convexHull[convexHull.length-2], convexHull[convexHull.length-1], points[i]) < 0) {
      print('> Going from the line ${convexHull[convexHull.length-2]} to ${convexHull[convexHull.length-1]} to the line ${convexHull[convexHull.length-1]} to ${points[i]}, we make a left turn- we remove ${convexHull[convexHull.length-1]}');
      convexHull.removeAt(convexHull.length-1);
    }
    convexHull.add(points[i]);
  }

  return convexHull;
}

void main(List<String> args) {
  final points = [
    Point(0, 0), Point(4, 0), Point(1, 3), Point(2, 2), Point(3, 1), Point(2, 1)
  ];
  print(grahamScan(points));
}

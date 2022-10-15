part of '../geometric.dart';

double closestPair(List<Point> points) {
  print('> Determining the closest pair of points in the list $points');
  if (points.length < 2) {
    throw StateError('Too few points to get a closest pair');
  } else if (points.length == 2) {
    print('> There are only two points, so there is only one possible distance');
    return Point.distance(points[0], points[1]);
  }

  print('> Sorting the points with respect to the x-coordinate');
  points.sort((Point p1, Point p2) => p1.x.compareTo(p2.x));
  print('> The sorted list is: $points');

  print('> Computing the closest pair recursively ...');
  return sqrt(_cp(points, 0, points.length-1));
}

double _cp(List<Point> points, int i, int k) {
  print('> Computing the closest pair between points[$i] and points[$k]');
  if (i == k) {
    print('> The indices are equal- base case');
    return double.infinity;
  }

  final j = (i + k) ~/ 2;
  final mid = (points[j].x + points[j+1].x) / 2;

  print('> Recursing on the two sublists ...');
  final d1 = _cp(points, i, j);
  final d2 = _cp(points, j+1, k);
  var d = min(d1, d2);
  print('> The minimum squared distances were $d1 and $d2, with total minimum $d');

  _merge(points, i, j, k);
  print('> After the merge, the points are now in the following order: $points');

  print('> Filtering the points within square root of $d of the midpoint line x=$mid within points[$i] and points[$k]');
  final filteredPoints = filterPoints(points, i, k, sqrt(d), mid);
  print('> These points are $filteredPoints');

  print('> Improving best distance using the filtered points');
  for (var a = 0; a < filteredPoints.length; a++) {
    for (var b = a+1; b <= min(a+5, filteredPoints.length-1); b++) {
      final newD = Point.distance2(filteredPoints[a], filteredPoints[b]);
      if (newD < d) {
        print('> Found a shorter distance between ${filteredPoints[a]} and ${filteredPoints[b]}- the new squared distance is $newD');
        d = newD;
      }
    }
  }

  print('> The overall shortest squared distance amongst values in points[$i] and points[$k] is: $d');

  return d;
}

void _merge(List<Point> points, int i, int j, int k) {
  if (i+1 <= k) {
    print('> Merging ${points.sublist(i, j+1)} with ${points.sublist(j+1, k+1)}');
    // start of first sublist
    int i1 = i;
    // start of second sublist
    int i2 = j+1;
    final merged = <Point>[];

    for (var i3 = 0; i3 <= k-i; i3++) {
      if (i1 > j) {
        merged.add(points[i2]);
        i2++;
      } else if (i2 > k) {
        merged.add(points[i1]);
        i1++;
      } else if (points[i1].y <= points[i2].y) {
        merged.add(points[i1]);
        i1++;
      } else {
        merged.add(points[i2]);
        i2++;
      }
    }
    print('> Merged to $merged');

    for (var a = i; a <= k; a++) {
      points[a] = merged[a-i];
    }
  }
}

List<Point> filterPoints(List<Point> points, int i, int k, double d, double mid) {
  final filteredPoints = <Point>[];
  for (var j = i; j <= k; j++) {
    if (points[j].x >= mid - d && points[j].x <= mid + d) {
      filteredPoints.add(points[j]);
    } 
  }
  return filteredPoints;
}

// void main(List<String> args) {
//   final points = [
//     Point(0, 1), Point(1, 1.5), Point(1.2, 1.2), Point(2, 1),
//     Point(2.75, 1), Point(3, 1.5), Point(4, 0), Point(5, 1)
//   ];
//   print(
//     closestPair(points)
//   );
// }

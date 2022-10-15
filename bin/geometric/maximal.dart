import 'intersection.dart';

List<Point> maximalPoints(List<Point> points) {
  if (points.isEmpty) {
    return [];
  }
  
  points.sort((Point p1, Point p2) => p2.x.compareTo(p1.x));
  final maximal = [points[0]];
  var maxY = points[0].y;
  
  for (var i=1; i<points.length; i++) {
    if (points[i].y > maxY) {
      maximal.add(points[i]);
      maxY = points[i].y;
    }
  }

  return maximal;
}

void main(List<String> args) {
  final points = [
    Point(4, 15), Point(6, 10), Point(1, 12), Point(7, 3), Point(1, 14), Point(7, 6), Point(2, 7), Point(4, 11),
    Point(3, 13), Point(6, 1), Point(2, 10), Point(8, 6), Point(5, 8), Point(3, 6), Point(7, 2), Point(5, 7)
  ];
  print(maximalPoints(points));
}

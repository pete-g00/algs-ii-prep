import 'package:classes/geometric.dart' show Point, grahamScan;

void main(List<String> args) {
  final points = [
    Point(0, 0), 
    Point(4, 2),
    Point(1, 1), 
    Point(2, 0.5), 
    Point(2, 1)
  ];
  // get an ordering of the points in the convex hull
  print(grahamScan(points));
}

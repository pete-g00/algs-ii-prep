import 'package:classes/geometric.dart' show Point, closestPair;

void main(List<String> args) {
  final points = [
    Point(0, 1), 
    Point(1, 1.5), 
    Point(1.2, 1.2), 
    Point(2, 1),
    Point(2.75, 1), 
    Point(3, 1.5), 
    Point(4, 0), 
    Point(5, 1)
  ];
  // get the distance between the closest pair of points
  print(closestPair(points));
}

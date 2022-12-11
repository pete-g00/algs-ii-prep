import 'package:classes/geometric.dart' show Point, simplePolygon;

void main(List<String> args) {
  final points = [
    Point(0, 0), 
    Point(4, 2),
    Point(1, 1), 
    Point(2, 0.5), 
    Point(2, 1)
  ];
  // reorder the points to construct the simple polygon
  simplePolygon(points);
  print(points);
}

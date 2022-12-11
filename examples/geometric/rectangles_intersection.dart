import 'package:classes/geometric.dart' show Point, Rectangle;

void main(List<String> args) {
  final r1 = Rectangle(
    Point(0, 0),
    Point(1, 5)
  );
  // get the top left coordinate of r1
  print(r1.topLeft);
  final r2 = Rectangle(
    Point(1, 1),
    Point(2, 2)
  );
  // find out whether two rectangles intersect
  print(r1.intersect(r2));
}

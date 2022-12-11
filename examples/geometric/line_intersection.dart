import 'package:classes/geometric.dart' show Line, Point;

void main(List<String> args) {
  // find out whether two lines intersect
  const l1 = Line(
    Point(0, 0),
    Point(1, 0)
  );
  const l2 = Line(
    Point(0, 1),
    Point(1, 5)
  );
  print(l1.intersect(l2));
}

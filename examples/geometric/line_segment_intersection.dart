import 'package:classes/geometric.dart' show Point, LineSegment;

void main(List<String> args) {
  // find out whether two line segments intersect
  final l1 = LineSegment.from(
    Point(0, 1),
    Point(1, 3)
  );
  final l2 = LineSegment.vertical(5, 0, 1);
  print(l1.intersect(l2));
}

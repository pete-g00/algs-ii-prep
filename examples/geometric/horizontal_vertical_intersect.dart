import 'package:classes/geometric.dart' show HorizontalLineSegment, VerticalLineSegment, intersection;

void main(List<String> args) {
  final horizontalPoints = [
    HorizontalLineSegment(0.5, 2, 0),
    HorizontalLineSegment(0.5, 1.5, 0.5),
    HorizontalLineSegment(0, 1, 1),
    HorizontalLineSegment(-0.5, 2, 1.5),
    HorizontalLineSegment(1, 2, 2)
  ];
  final verticalPoints = [
    VerticalLineSegment(1, -0.5, 2),
    VerticalLineSegment(2, 1, 3)
  ];
  // calculate the number of intersections between the horizontal and the vertical points
  print(intersection(horizontalPoints, verticalPoints));
}
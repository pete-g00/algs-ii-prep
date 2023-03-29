library geometric;

import 'package:quiver/core.dart' show hash2;
import 'dart:math' show pow, sqrt, atan2, min, max;

part 'geometric/closest_pair.dart';
part 'geometric/horizontal_vertical.dart';
part 'geometric/line.dart';
part 'geometric/line_segment.dart';
part 'geometric/point.dart';
part 'geometric/polygon.dart';
part 'geometric/rectangle.dart';
part 'geometric/exercises.dart';
part 'geometric/furthest_pair.dart';

void main(List<String> args) {
  final diagonals = [
    DiagonalLineSegment(0, 2, 0),
  ];
  final verticals = [
    VerticalLineSegment(1, 0, 2)
  ];
  intersectionsBetweenDiagonalAndVertical(diagonals, verticals);
}
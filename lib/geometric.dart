library geometric;

import 'package:quiver/core.dart' show hash2;
import 'dart:math' show pow, sqrt, atan2, min, max;
import 'package:binary_tree/binary_tree.dart';

part 'geometric/closest_pair.dart';
part 'geometric/horizontal_vertical.dart';
part 'geometric/line.dart';
part 'geometric/line_segment.dart';
part 'geometric/point.dart';
part 'geometric/polygon.dart';
part 'geometric/rectangle.dart';

void main(List<String> args) {
  final l1 = HorizontalLineSegment(0, 2, 0);
  final l2 = VerticalLineSegment(2, 0, 2);
  final values = [
    _ComparableLineSegment(l1, true),
    _ComparableLineSegment(l2, true),
    _ComparableLineSegment(l1, false)
  ];
  values.sort();
  print(values);
}
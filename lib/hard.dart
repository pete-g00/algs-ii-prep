library hard;

import 'dart:math' show min, max;
import 'common.dart';

part 'hard/colour_backtracking.dart';
part 'hard/knapsack.dart';
part 'hard/subset_problem.dart';
part 'hard/subset_approximation.dart';
part 'hard/max_sat_approximation.dart';
part 'hard/backtracking_3d.dart';
part 'hard/knapsack_approximation.dart';

// void main(List<String> args) {
//   final points = [
//       Point(0, 4, 4), Point(1, 2, 3), Point(2, 1, 0), Point(3, 3, 2), Point(4, 5, 1), 
//       Point(1, 4, 0),  Point(0, 5, 1), Point(2, 2, 4), Point(2, 4, 1), Point(3, 2, 1), 
//       Point(3, 5, 1), Point(4, 2, 1), Point(4, 2, 4), Point(4, 4, 0), Point(0, 2, 2)
//   ];
//   final matching = Matching3D(points, 5);
//   print(matching.findPerfectMatching());
// }

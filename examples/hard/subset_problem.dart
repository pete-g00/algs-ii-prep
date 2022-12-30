import 'package:classes/hard.dart' show subsetProblem, subsetProblemDP, subsetProblemDPWithTraceback, subsetProblemTrimmed;

void main(List<String> args) {
  final values = [10, 11, 12, 15, 20, 21, 22, 23, 24, 29, 30];
  // Returns whether it is possible to get the value 197 using the values given
  print(subsetProblemDP(values, 197));
  // If it is possible to get 197, show the values taken to achieve that sum
  print(subsetProblemDPWithTraceback(values, 197));
  // Returns the closest value below the target that can be achieved using the given values
  print(subsetProblem(values, 200));
  // Returns the closes value below the target that can be achieved using the given values, with trim delta = 1/6
  print(subsetProblemTrimmed(values, 200, 1/6));
}

part of '../hard.dart';

/// Merges the 2 sorted lists [l1] and [l2] into another sorted list containing values less than the target
List<int> _merge(List<int> l1, List<int> l2, int target) {
  final list = <int>[];
  var i = 0;
  var j = 0;
  var belowTarget = true;
  int? prevVal;
  
  while ((i != l1.length || j != l2.length) && belowTarget) {
    if (i == l1.length) {
      final val = l2[j++];
      if (val > target) {
        belowTarget = false;
      } else if (prevVal != val) {
        prevVal = val;
        list.add(val);
      }
    } else if (j == l2.length || l1[i] < l2[j]) {
      final val = l1[i++];
      if (val > target) {
        belowTarget = false;
      } else if (prevVal != val) {
        prevVal = val;
        list.add(val);
      }
    } else {
      final val = l2[j++];
      if (val > target) {
        belowTarget = false;
      } else if (prevVal != val) {  
        prevVal = val;
        list.add(val);
      }
    }
  }
  print('$l1 and $l2 merge to $list');

  return list;
}

/// Given a list of [values] and a [target], tries to find a sublist such that their sum 
/// is as close to the target as possible, while staying below the target
int subsetProblem(List<int> values, int target) {
  var matches = [0];
  for (var i = 0; i < values.length; i++) {
    final newMatches = matches.map((match) => match + values[i]).toList();
    matches = _merge(matches, newMatches, target);
    if (matches[matches.length-1] == target) {
      return target;
    }
  }

  return matches[matches.length-1];
}

/// Merges the 2 sorted lists [l1] and [l2] while:
/// - ensuring that no value bigger than target is taken, and
/// - ensuring that between any two consecutive numbers, they are beyond the trim threshold [val].
List<int> _mergeAndTrim(List<int> l1, List<int> l2, int target, double val) {
  final list = <int>[];
  var i = 0;
  var j = 0;
  var belowTarget = true;
  int? prevVal;
  
  while ((i != l1.length || j != l2.length) && belowTarget) {
    if (i == l1.length) {
      final nextVal = l2[j++];
      if (nextVal > target) {
        belowTarget = false;
      } else if (prevVal != val && (prevVal == null || (1-val)*nextVal > prevVal)) {
        prevVal = nextVal;
        list.add(nextVal);
      }
    } else if (j == l2.length || l1[i] < l2[j]) {
      final nextVal = l1[i++];
      if (nextVal > target) {
        belowTarget = false;
      } else if (prevVal != nextVal && (prevVal == null || (1-val)*nextVal > prevVal)) {
        prevVal = nextVal;
        list.add(nextVal);
      }
    } else {
      final nextVal = l2[j++];
      if (nextVal > target) {
        belowTarget = false;
      } else if (prevVal != nextVal && (prevVal == null || (1-val)*nextVal > prevVal)) {  
        prevVal = nextVal;
        list.add(nextVal);
      }
    }
  }
  print('$l1 and $l2 merge to $list');

  return list;
}

/// Given a list of [values] and a [target], tries to find a sublist such that their sum 
/// is as close to the target as possible, while staying below the target. Applies approximation 
/// with respect to the trim factor [val].
int subsetProblemTrimmed(List<int> values, int target, double val) {
  var matches = [0];
  for (var i = 0; i < values.length; i++) {
    final newMatches = matches.map((match) => match + values[i]).toList();
    matches = _mergeAndTrim(matches, newMatches, target, val);
    if (matches[matches.length-1] == target) {
      return target;
    }
  }

  return matches[matches.length-1];
}

// List<int> _trim(double val, List<int> list) {
//   final trimmed = <int>[];
//   var p = list[0];
//   trimmed.add(p);
//   for (var i = 1; i < list.length; i++) {
//     final q = list[i];
//     if ((1-val)*q > p) {
//       trimmed.add(q);
//       p = q;
//     }
//   }

//   return trimmed;
// }

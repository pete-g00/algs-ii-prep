part of '../geometric.dart';

/// Represents a tuple of a [line] and [isStart]- whether we are considering it at the start or the end.
/// 
/// Can be compared as follows:
/// 
/// - compare the x coordinate with respect to the value [isStart], i.e. the first x-coordinate if [isStart] and the second one otherwise.
/// - if they don't match, use that ordering
/// - otherwise, if either one satisfies [isStart], then return that one first
/// 
class _HorizontalLineTuple implements Comparable<_HorizontalLineTuple> {
  final HorizontalLineSegment line;
  final bool isStart;

  const _HorizontalLineTuple(this.line, this.isStart);

  double get x => isStart ? line.p1.x : line.p2.x;

  @override
  int compareTo(_HorizontalLineTuple other) {
    final x1 = x;
    final x2 = other.x;

    // if x1 != x2, then return the comparison value
    final compare = x1.compareTo(x2);
    if (compare != 0) {
      return compare;
    }

    // otherwise, if one of them isStart, return that one first
    if (isStart) {
      return -1;
    } else if (other.isStart) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  String toString() {
    final type = isStart ? 'starting ' : 'ending ';
    return type + line.toString();
  }
}

/// Given a list of horizontal line segments and vertical line segments, computes how many times they intersect
int intersection(List<HorizontalLineSegment> horizontals, List<VerticalLineSegment> verticals) {
  print('Computing the number of intersections between the given list of horizontal and vertical line segments');
  print('Sorting the vertical line segments with respect to their y-coordinate');
  // sort the vertical segments wrt y value
  verticals.sort((a, b) => a.constant.compareTo(b.constant));
  print('The sorted list is: $verticals');
  
  print('Sorting the horizontal line segments with respect to the x-coordinate (both at start and end)');
  // construct the horizontal segments and sort them
  final horizontalTuples = <_HorizontalLineTuple>[];
  for (var i = 0; i < horizontals.length; i++) {
    horizontalTuples.add(_HorizontalLineTuple(horizontals[i], true));
    horizontalTuples.add(_HorizontalLineTuple(horizontals[i], false));
  }
  horizontalTuples.sort();
  print('The sorted list is: $horizontalTuples');
  
  var i = 0;
  var j = 0;
  final candidates = <double>{};
  var count = 0;

  // while we have both a horizontal segment and a vertical segment left to consider,
  while (i < verticals.length && j < horizontalTuples.length) {
    print('Trying to check for intersection with the vertical line ${verticals[i]}');
    
    print('Adding/removing horizontal lines with x-coordinate < ${verticals[i].constant}');
    while (j < horizontalTuples.length && horizontalTuples[j].x < verticals[i].constant) {
      if (horizontalTuples[j].isStart) {
      print('Inserting the ${horizontalTuples[j]}, i.e. value ${horizontalTuples[j].line.constant}');
        candidates.add(horizontalTuples[j].line.constant);
      } else {
        print('Removing the ${horizontalTuples[j]}, i.e. value ${horizontalTuples[j].line.constant}');
        candidates.remove(horizontalTuples[j].line.constant);
      }
      j++;
    }

    print('Adding horizontal lines with x-coordinate = ${verticals[i].constant}');
    while (j < horizontalTuples.length && horizontalTuples[j].x == verticals[i].constant && horizontalTuples[j].isStart) {
      print('Inserting the ${horizontalTuples[j]}, i.e. value ${horizontalTuples[j].line.constant}');
      candidates.add(horizontalTuples[j].line.constant);
      j++;
    }

    print('Computing any intersections');
    if (candidates.isNotEmpty) {
      final newMatches = _search(candidates, verticals[i].start, verticals[i].end);
      print('Found $newMatches intersections!');
      count += newMatches;
    }
    
    print('Removing horizontal lines with x-coordinate = ${verticals[i].constant}');
    while (j < horizontalTuples.length && horizontalTuples[j].x == verticals[i].constant) {
      print('Removing the ${horizontalTuples[j]}, i.e. value ${horizontalTuples[j].line.constant}');
      candidates.remove(horizontalTuples[j].line.constant);
      j++;
    }

    i++;
  }
  print('In total, there are $count intersections');

  return count;
}

/// Counts the number of elements in the tree that lie between start and end
int _search(Set<double> values, double start, double end) {
  var count = 0;
  for (var value in values) {
    if (value >= start && value <= end) {
      count ++;
    }
  }
  return count;
}

// int _rangeSearch<E extends Comparable<E>>(TreeNode<E>? node, E start, E end) {
//   if (node == null) {
//     return 0;
//   }
//   print('> Searching the node with value ${node.data}');
  
//   // smaller than the start => only look at the right node (exclude the node)
//   if (node.data.compareTo(start) < 0) {
//     print('+1');
//     return _rangeSearch(node.right, start, end);
//   }
  
//   // bigger than the end => only look at the left node (exclude the node)
//   if (node.data.compareTo(end) > 0) {
//     print('1+');
//     return _rangeSearch(node.left, start, end);
//   }
//   print('Value ${node.data} lies in the range!');

//   // otherwise => got to look at both the children and add 1
//   return 1 + _rangeSearch(node.left, start, end) + _rangeSearch(node.right, start, end);
// }

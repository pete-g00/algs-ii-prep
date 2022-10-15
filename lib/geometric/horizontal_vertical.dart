part of '../geometric.dart';

class _ComparableLineSegment implements Comparable<_ComparableLineSegment> {
  final _StraightLineSegment line;
  final bool isStart;

  const _ComparableLineSegment(this.line, this.isStart);

  @override
  int compareTo(_ComparableLineSegment other) {
    final x1 = this.isStart ? line.p1.x : line.p2.x;
    final x2 = other.isStart ? other.line.p1.x : other.line.p2.x;

    // if x1 != x2, then return the comparison value
    final compare = x1.compareTo(x2);
    if (compare != 0) {
      return compare;
    }

    // same types => order doesn't matter
    if (line is VerticalLineSegment && other.line is VerticalLineSegment) {
      return 0;
    }
    if (line is HorizontalLineSegment && other.line is HorizontalLineSegment) {
      return 0;
    }

    // find out whether the horizontal line is the start or the end
    final isStart = line is HorizontalLineSegment ? this.isStart : other.isStart;
    
    // horizontal line comes first if isStart, otherwise horizontal line comes second
    return isStart ? 1 : -1;
  }

  @override
  String toString() {
    final type = line is HorizontalLineSegment ? 'horizontal line pos = ' : 'vertical line pos = ';
    return type + (isStart ? line.p1.toString() : line.p2.toString());
  }
}

int intersection(List<HorizontalLineSegment> horizontals, List<VerticalLineSegment> verticals) {
  // generate a list of points (with start/end) for the line segments
  final lines = <_ComparableLineSegment>[];
  
  for (var horizontal in horizontals) {
    lines.add(_ComparableLineSegment(horizontal, true));
    lines.add(_ComparableLineSegment(horizontal, false));
  }
  
  for (var vertical in verticals) {
    lines.add(_ComparableLineSegment(vertical, true));
  }

  // sort these lines
  lines.sort();
  
  final candidates = BinaryTree<num>();
  var count = 0;

  for (var i = 0; i < lines.length; i++) {
    if (lines[i].line is HorizontalLineSegment) {
      if (lines[i].isStart) {
        candidates.insert(lines[i].line.start);
      } else {
        candidates.remove(lines[i].line.start);
      }
    } else {
      count += _rangeSearch(candidates.root, lines[i].line.start, lines[i].line.end);
    }
  }

  return count;
}

/// Counts the number of elements in the tree that lie between start and end
int _rangeSearch<E extends Comparable<E>>(TreeNode<E>? node, E start, E end) {
  if (node == null) {
    return 0;
  }
  
  // smaller than the start => only look at the right node (exclude the node)
  if (node.data.compareTo(start) < 0) {
    print('+1');
    return _rangeSearch(node.right, start, end);
  }
  
  // bigger than the end => only look at the left node (exclude the node)
  if (node.data.compareTo(end) > 0) {
    print('1+');
    return _rangeSearch(node.left, start, end);
  }
  print('Value ${node.data} lies in the range!');
  
  // otherwise => got to look at both the children and add 1
  return 1 + _rangeSearch(node.left, start, end) + _rangeSearch(node.right, start, end);
}
import 'intersection.dart';

abstract class LineSegment {
  Point get start;
  Point get end;

  const LineSegment();
}

class HorizontalLineSegment extends LineSegment {
  final double x1;
  final double x2;
  final double y;

  const HorizontalLineSegment(this.x1, this.x2, this.y);

  @override
  Point get start => Point(x1, y);
  
  @override
  Point get end => Point(x1, y);
}

class VerticalLineSegment extends LineSegment {
  final double x;
  final double y1;
  final double y2;

  const VerticalLineSegment(this.x, this.y1, this.y2);

  @override
  Point get start => Point(x, y1);
  
  @override
  Point get end => Point(x, y2);
}

class LineSegmentPair {
  final HorizontalLineSegment? horizontal;
  final bool? isStart;
  final VerticalLineSegment? vertical;

  const LineSegmentPair({this.horizontal, this.isStart, this.vertical});

  LineSegmentPair addHorizontal(HorizontalLineSegment horizontal) => LineSegmentPair(horizontal: horizontal, vertical: vertical);
  
  LineSegmentPair addVertical(VerticalLineSegment vertical) => LineSegmentPair(horizontal: horizontal, vertical: vertical);
}

int intersection(List<HorizontalLineSegment> horizontals, List<VerticalLineSegment> verticals) {
  // generate a map to get the horizontal/vertical line segment; and a list of points (two for horizontal, one for vertical)
  final map = <Point, LineSegmentPair>{};
  final points = <Point>[];
  
  for (var horizontal in horizontals) {
    map[horizontal.start] = LineSegmentPair(horizontal: horizontal, isStart: true);
    points.add(horizontal.start);
    map[horizontal.end] = LineSegmentPair(horizontal: horizontal, isStart: false);
    points.add(horizontal.end);
  }

  for (var vertical in verticals) {
    final prev = map[vertical.start];
    if (prev == null) {
      map[vertical.start] = LineSegmentPair(vertical: vertical);
    } else {
      prev.addVertical(vertical);
    }
    points.add(vertical.start);
  }

  points.sort((Point p1, Point p2) {
    // different x-coordinate => normal comparison
    if (p1.x != p2.x) {
      return p1.x.compareTo(p2.x);
    }
    // both horizontal / vertical => 0

    // p1 horizontal start, p2 vertical => -1

    // p1 horizontal end, p2 vertical => 1
    return 0;
  });
  return 0;
}

// finds the index in the sorted list of the first value that is >= the given value (if smaller than the max; else the final index)
int _geqSearch<E extends Comparable<E>>(List<E> list, E value, int i, int k) {
  print('Searching the value $value in list[$i..$k]');
  if (i >= k) {
    return i;
  }
  
  final j = (i + k) ~/ 2;
  if (list[j] == value) {
    return j;
  } else if (list[j].compareTo(value) > 0) {
    return _geqSearch(list, value, i, j);
  } else {
    return _geqSearch(list, value, j+1, k);
  }
}

// finds the index in the sorted list of the value, if any
int binSearch<E extends Comparable<E>>(List<E> list, E value) {
  int i = _geqSearch(list, value, 0, list.length-1);
  return list[i] == value ? i : -1;
}

// adds the given value to the sorted list
void addToSortedList<E extends Comparable<E>>(List<E> list, E value) {
  // find the index where it should get added
  int i = _geqSearch(list, value, 0, list.length-1);
  list.insert(i, value);
}

// removes the given value from the sorted list
bool removeFromSortedList<E extends Comparable<E>>(List<E> list, E value) {
  int i = _geqSearch(list, value, 0, list.length-1);
  if (list[i] == value) {
    list.removeAt(i);
  } 
  return false;
}

// counts the number of values in the sorted list that are within start and end values (inclusive)
int rangeSearch<E extends Comparable<E>>(List<E> list, E start, E end) {
  var i = _geqSearch(list, start, 0, list.length-1);
  var count = 0;
  print('Starting at index $i');

  while (i < list.length && list[i].compareTo(end) <= 0) {
    print('The value list[$i] = ${list[i]} is in the range');
    i++;
    count++;
  }

  return count;
}

void main(List<String> args) {
  final list = [1, 3, 4, 5, 7];
  print(rangeSearch<num>(list, 2, 5));
}

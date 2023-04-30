part of '../hard.dart';

class Point {
  final int x;
  final int y;
  final int z;

  const Point(this.x, this.y, this.z);

  @override
  String toString() {
    return '($x, $y, $z)';
  }
}

class Matching3D {
  /// The initial points
  final List<Point> points;
  
  /// The matched indices
  final List<int> indices;

  /// The number of distinct values of x, y and z
  final int n;

  /// Whether the matching has been completed
  bool _matched;

  Matching3D(this.points, this.n):indices=[], _matched=false;

  /// Choose the i-th value to be added
  void _chooseNextValue(int i) {
    // print('Trying to add the ${i+1}-th element to the match');
    
    // the next index to look at
    var next = 0;
    if (i > 0) {
      next = indices[i-1] + 1;
    }

    // since the indices are collected in increasing order, the value next need not be 
    // any higher than i-n+points.length; otherwise, we won't be able to find n values
    while (next <= i-n+points.length && !_matched) {
      print('Looking at index $next- ${points[next]}');
      indices.add(i);
      if (_isValidMatching()) {
        print('We still have a valid matching');
        if (i == n-1) {
          print('Fully Matched!');
          _matched = true;
        } else {
        _chooseNextValue(i+1);
        }
      }

      if (!_matched) {
        indices.removeLast();
        next ++;
      }
    }
  }

  // checks whether the final element in the list of indices is valid
  bool _isValidMatching() {
    final i = indices[indices.length-1];
    for (var j = 0; j < indices.length-1; j++) {
      final k = indices[j];
      if (points[i].x == points[k].x || points[i].y == points[k].y || points[i].z == points[k].z) {
        return false;
      }
    }

    return true;
  }

  bool findPerfectMatching() {
    _chooseNextValue(0);
    return _matched;
  }
}

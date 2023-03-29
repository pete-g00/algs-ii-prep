part of '../geometric.dart';

// double rotatingCalipers(List<Point> points) {
//   final values = grahamScan(points);
  
//   // find the point with the max x-coordinate
//   var maxX = 0;
//   // find the point with the min y-coordinate
//   var minY = 0;
//   for (var i = 1; i < values.length; i++) {
//     if (values[maxX].x < values[i].x) {
//       maxX = i;
//     }
//     if (values[minY].y > values[i].y) {
//       minY = i;
//     }
//   }
  
//   var top = maxX;
//   var bottom = minY;
//   var distance = Point.distance2(values[top], values[bottom]);
//   var topAngle;
//   var bottomAngle;
  
//   while (top != minY && bottom != maxX) {
//     if (topAngle < bottomAngle) {
//       top ++;
//       if (top == values.length) {
//         top = 0;
//       }
//       // update topAngle
//     } else {
//       bottom ++;
//       if (bottom == values.length) {
//         bottom = 0;
//       }
//       // update bottomAngle
//     }
//   }

//   return distance;
// }
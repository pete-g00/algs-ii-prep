# Classes created as part of Algorithmics II course

This repository contains all the classes created as part of the Algorithmics II course, in Dart. That includes:

- geometric algorithms (`geometric/`):
    * point (`point.dart`), 
    * lines (`line.dart`), line segments (`line_segment.dart`) and rectangles (`rectangle.dart`), along with intersections
    * simple polygon and convex hull (`polygon.dart`), 
    * closest pair of points (`closest_pair.dart`), and
    * intersection of a list of horizontal and vertical points (`horizontal_vertical.dart`)
- string algorithms (`string/`)
    * (suffix) tries (`trie.dart`)- constructing a suffix trie given a string, finding the longest common substring (for 1 and 2 strings) and searching a string in the text
    * (suffix) trees (`tree.dart`)- constructing a suffix tree given a string, finding the longest common substring (for 1 and 2 strings) and searching a string in the text
    * ndfa (`ndfa.dart`) and regular expressions (`regular_exp.dart`)- constructing different ndfas for different regular expressions and matching regexp with a string
    * dynamic programming for longest common substring (`longest_common_substring.dart`) with O(n^2) space and O(n) space
    * dynamic programming for longest common subsequence (`longest_common_subsequence.dart`) with different variants

The code is in Dart. To install dart, you can follow the instructions [here](https://dart.dev/get-dart). Then, you can run write a main function on any of the immediate files within the `lib` folder to run the code (with verbose messages). You can see a lot of example code in the `examples` folder. To run the code, `cd lib` and `dart <file>.dart`.

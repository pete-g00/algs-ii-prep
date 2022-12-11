# Classes created as part of Algorithmics II course

This repository contains all the classes created as part of the Algorithmics II course, in Dart. That includes:

- geometric algorithms (`geometric/`):
    * intersection of lines (`line.dart`), line segments (`line_segment.dart`) and rectangles (`rectangle.dart`),
    * simple polygon and Graham scan for convex hull (`polygon.dart`), 
    * closest pair of points (`closest_pair.dart`), and
    * intersection of a list of horizontal and vertical points (`horizontal_vertical.dart`)
- string algorithms (`string/`)
    * (suffix) tries (`trie_and_tree.dart`)- constructing a suffix trie given a string, finding the longest common substring (for 1 and 2 strings) and searching a string in the text
    * (suffix) trees (`trie_and_tree.dart`)- constructing a suffix tree given a string, finding the longest common substring (for 1 and 2 strings) and searching a string in the text
    * ndfa (`ndfa.dart`) and regular expressions (`regular_exp.dart`)- constructing different ndfas for different regular expressions and matching regexp with a string
    * dynamic programming for longest common substring (`longest_common_substring.dart`) with O(n^2) space and O(n) space
    * dynamic programming for longest common subsequence (`longest_common_subsequence.dart`) with different variants
    * local similarity in strings (`smith_waterman.dart`) with different variants
- graph algorithms (`graph/`)
    * Matching in bipartile graphs (`bipartile_graph.dart`)
    * Network flow (`network_flow.dart`)- Ford-Fulkerson algorithm (max network flow)
    * Gale-Shapley algorithm for the stable matching problem (`gale_shapely.dart`) 
    * Floyd-Warshall algorithm for all-pairs shortest paths (`all_pairs_shortest_paths.dart`)
- hard (`hard/`)
    * The backtracking algorithm for the Graph Colouring Problem (`colour_backtracking.dart`)
    * The pseudo-polynomial algorithm for the subset problem (`subset_problem.dart`) and the knapsack problem (`knapsack.dart`)
    * The approximation algorithm for MAX-SAT problem (`max_sat_-_approximation.dart`)
    * The PTAS for the subset problem `subset_approximation.dart`

The code is in Dart. To install dart, you can follow the instructions [here](https://dart.dev/get-dart). Then, you can run write a main function on any of the immediate files within the `lib` folder to run the code (with verbose messages). You can see a lot of example code in the `examples` folder. To run the code, `cd lib` and `dart <file>.dart`.

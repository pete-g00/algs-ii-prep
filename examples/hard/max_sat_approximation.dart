import 'package:classes/hard.dart' show CNFClause, CNF;

void main(List<String> args) {
  final clause1 = CNFClause([0, 2], [false, false]); // v0 or v2
  final clause2 = CNFClause([0, 1], [true, false]); // not v0 or v1
  final clause3 = CNFClause([1, 2], [true, true]); // not v1 or not v2
  final clause4 = CNFClause([0, 1], [false, false]); // v0 or v1
  final clauses = CNF([clause1, clause2, clause3, clause4], 3); 
  
  // given an assignment of variables, check how many clauses are satisfied
  final assignments = [true, true, true]; // all 3 variables are true
  print(clauses.checkTrue(assignments)); // 3 => satisfies clauses 1, 2 and 4

  // get a variable assignment for each of the variables (that will satisfy at least 1/2 the clauses)
  final approxAssignments = clauses.approximate();
  print(approxAssignments);
  // compute how many clauses are satisfied by this assignment
  print(clauses.checkTrue(approxAssignments));
}

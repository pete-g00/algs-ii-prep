part of '../hard.dart';

class CNFClause {
  final List<int> labels;
  final List<bool> isNegated;
  
  const CNFClause(this.labels, this.isNegated);

  bool assign(Map<String, bool> assignments) {
    for (var i = 0; i < labels.length; i++) {
      final assignment = assignments[labels[i]]!;
      if (isNegated[i] != assignment) {
        return true;
      } 
    }
    return false;
  }

  @override
  String toString() {
    final buffer = StringBuffer('');
    for (var i = 0; i < labels.length; i++) {
      if (isNegated[i]) {
        buffer.write('¬');
      }
      buffer.write('x');
      buffer.write(labels[i]+1);
      if (i != labels.length-1) {
        buffer.write(' ∨ ');
      }
    }

    return buffer.toString();
  }
}

class CNF {
  final List<CNFClause> clauses;
  final int varCount;

  const CNF(this.clauses, this.varCount);

  /// Given a map of [assignments], returns how many clauses in the CNF are satisfied.
  int checkTrue(Map<String, bool> assignments) {
    var j = 0;
    for (var i = 0; i < clauses.length; i++) {
      if (clauses[i].assign(assignments)) {
        j++;
      }
    }
    return j;
  }

  List<bool> approximate() {
    print('Approximating the CNF');
    final assignments = List.filled(varCount, false);
    
    // the no of variables in a clause that could be satisfied (-1 if satisfied)
    final couldBeSatisfied = List.generate(clauses.length, (i) => clauses[i].labels.length);
    // the indices of clauses where a variable is present for each variable 
    final trueVariableIndices = List.generate(varCount, (i) => <int>[]);
    // the indices of clauses where a variable is present for each variable 
    final falseVariableIndices = List.generate(varCount, (i) => <int>[]);
    // the number of clauses left to be satisfied
    var remainingClauses = clauses.length;

    // compute the number of clauses where a variable is present (negated or not negated)
    for (var i = 0; i < clauses.length; i++) {
      final labels = clauses[i].labels;
      final isNegated = clauses[i].isNegated;
      // go through all the labels and keep track of it
      for (var j = 0; j < labels.length; j++) {
        final k = labels[j];
        if (isNegated[j]) {
          falseVariableIndices[k].add(i);
        } else {
          trueVariableIndices[k].add(i);
        }
      }
    }

    // go through each variable and assign it 
    for (var i = 0; i < varCount; i++) {
      print('The true variable indices is given by: $trueVariableIndices');
      print('The false variable indices is given by: $falseVariableIndices');
      print('There are ${trueVariableIndices[i].length} true assignments for variable x${i+1} and ${falseVariableIndices[i].length} false assignments');
      if (trueVariableIndices[i].length >= falseVariableIndices[i].length) {
        print('Assigning the variable x${i+1} true');
        assignments[i] = true;
        // go through all the clauses containing this var (not negated), and remove it
        for (final j in trueVariableIndices[i]) {
          print('Removing the satisfied clause ${clauses[j]}');
          remainingClauses --;
          couldBeSatisfied[j] = -1;
          // for other clauses containing this variable, remove this clause (only the variables that haven't been dealt with)
          for (final k in clauses[j].labels) {
            if (k > i){
              print('Removing this clause from variable x${k+1}');
              trueVariableIndices[k].remove(j);
              falseVariableIndices[k].remove(j);
            }
          }
        }
        // go through all the clauses containing this var negated, and remove the literal
        for (final j in falseVariableIndices[i]) {
          couldBeSatisfied[j] --;
          if (couldBeSatisfied[j] == 0) {
            remainingClauses --;
            couldBeSatisfied[j] = -1;
          }
        }
      } else {
        print('Assigning the variable x${i+1} false');
        assignments[i] = false;
        // go through all the clauses containing this var negated, and remove it
        for (final j in falseVariableIndices[i]) {
          remainingClauses --;
          couldBeSatisfied[j] = -1;
          // for other clauses containing this variable, remove this variable
          for (final k in clauses[j].labels) {
            if (k > i) {
              print('Removing this clause from variable x${k+1}');
              trueVariableIndices[k].remove(j);
              falseVariableIndices[k].remove(j);
            }
          }
        }
        // go through all the clauses containing this var (not negated), and remove the literal
        for (final j in trueVariableIndices[i]) {
          couldBeSatisfied[j] --;
          if (couldBeSatisfied[j] == 0) {
            remainingClauses --;
            couldBeSatisfied[j] = -1;
          }
        }
      }

      if (remainingClauses == 0) {
        print('No more remaining clauses- assigning all the remaining clauses false');
        break;
      }
    }

    return assignments;
  }

  @override
  String toString() {
    final buffer = StringBuffer("");
    for (var i = 0; i < clauses.length; i++) {
      buffer.write('(');
      buffer.write(clauses[i]);
      buffer.write(')');

      if (i != clauses.length-1) {
        buffer.write(' ∧ ');
      }
    }

    return buffer.toString();
  }
}

void main(List<String> args) {
  final clause1 = CNFClause([0, 2], [false, false]);
  final clause2 = CNFClause([0, 1], [true, false]);
  final clause3 = CNFClause([1, 2], [true, true]);
  final clause4 = CNFClause([0, 1], [false, false]);
  final clauses = CNF([clause1, clause2, clause3, clause4], 3);
  print(clauses.approximate());
}
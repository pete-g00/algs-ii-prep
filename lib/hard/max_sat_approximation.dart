part of '../hard.dart';

/// Represents a clause in CNF
class CNFClause {
  /// The labels for each variable in the clause (index in the list of variables)
  final List<int> labels;
  /// Whether the variable has been negated or not, with respect to the list of clauses
  final List<bool> isNegated;
  
  /// Given a list of [labels] for variables and whether they are negated ([isNegated]), constructs a CNF clause
  const CNFClause(this.labels, this.isNegated);

  /// Given a list of assignments for the variables, returns whether the clause has been satisfied
  bool assign(List<bool> assignments) {
    for (var i = 0; i < labels.length; i++) {
      final assignment = assignments[labels[i]];
      if (isNegated[i] != assignment) {
        print('Variable ${labels[i]} satisfied');
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

/// Represents a CNF
class CNF {
  /// The clauses in the CNF
  final List<CNFClause> clauses;
  /// The number of variables in the CNF
  final int varCount;

  /// Given the [clauses] and the [varCount], constructs a CNF
  const CNF(this.clauses, this.varCount);

  /// Given a list of variable [assignments], returns how many clauses in the CNF are satisfied.
  int checkTrue(List<bool> assignments) {
    var j = 0;
    for (var i = 0; i < clauses.length; i++) {
      if (clauses[i].assign(assignments)) {
        print('clause ${i+1} satisifed');
        j++;
      }
    }
    return j;
  }

  /// Returns an assignment of the variables that is guaranteed to satisfy at least 1/2 of the clauses.
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

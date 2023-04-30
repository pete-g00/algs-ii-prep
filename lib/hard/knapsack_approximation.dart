part of '../hard.dart';

class KnapsackProblem {
  final List<int> weights;
  final List<int> profits;
  final int capacity;
  int maxProfit;

  List<int> _currentProfits = [0];
  List<int> _currentWeights = [0];

  KnapsackProblem(this.weights, this.profits, this.capacity):maxProfit=0;

  /// Merge [_currentWeights] and [newWeights]. Also combining the relevant profits
  void _merge(List<int> newWeights, List<int> newProfits) {
    final weights = <int>[];
    final profits = <int>[];

    var i = 0;
    var j = 0;
    var belowCapacity = true;
    
    int? prevWeight;
    int? prevProfit;
    
    // while we still have stuff in either list AND we're below capacity, update the list of profits
    while ((i != _currentWeights.length || j != newWeights.length) && belowCapacity) {
      // completed added currentWeights => add newWeights
      if (i == _currentWeights.length) {
        final weight = newWeights[j];
        if (weight > capacity) {
          belowCapacity = false;
        } else if (prevWeight != weight) {
          prevWeight = weight;
          weights.add(weight);
          profits.add(newProfits[j]);
        }
        // cannot improve previous weight, but can still improve previous profit => improve profit
        else if (prevProfit != null && prevProfit < newProfits[j]) {
          profits[profits.length-1] = newProfits[j]; 
        }
        prevProfit = profits[profits.length-1];
        j++;
      } else if (j == newWeights.length || _currentWeights[i] < newWeights[j]) {
        final weight = _currentWeights[i];
        if (weight > capacity) {
          belowCapacity = false;
        } else if (prevWeight != weight) {
          prevWeight = weight;
          weights.add(weight);
          profits.add(_currentProfits[i]);
          prevProfit = _currentProfits[i];
          i++;
        }
      } else {
        final weight = newWeights[j];
        if (weight > capacity) {
          belowCapacity = false;
        } else if (prevWeight != weight) {  
          prevWeight = weight;
          weights.add(weight);
          profits.add(newProfits[j]);
        } else if (prevProfit != null && prevProfit < newProfits[j]) {
          profits[profits.length-1] = newProfits[j];
        }
        prevProfit = profits[profits.length-1];
        j++;
      }



      if (maxProfit < profits[profits.length-1]) {
        maxProfit = profits[profits.length-1];
      }
    }

    _currentProfits = profits;
    _currentWeights = weights;
  }

  int evaluate() {
    for (var i=0; i < weights.length; i++) {
      final newWeights = _currentWeights.map((weight) => weight + weights[i]).toList();
      final newProfits = _currentProfits.map((profit) => profit + profits[i]).toList();
      _merge(newWeights, newProfits);
    }

    return maxProfit;
  }

}


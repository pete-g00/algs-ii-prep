int nextFit(List<int> items, int capacity) {
  var binCount = 0;
  var binWeight = capacity;

  for (var i = 0; i < items.length; i++) {
    if (binWeight + items[i] >= capacity) {
      binCount ++;
      binWeight = 0;
    }
    binWeight += items[i];
  }

  return binCount;
}

int firstFit(List<int> items, int capacity) {
  final weights = <int>[];

  for (var i = 0; i < items.length; i++) {
    var added = false;
    
    // try placing the item in j-th bin
    var j = 0;
    while (!added && j < weights.length) {
      if (weights[j] + items[i] < capacity) {
        weights[j] += items[i];
        added = true;
      }
      j++;
    }

    if (!added) {
      weights.add(items[i]);
    }
  }

  return weights.length;
}


int firstFitDecreasing(List<int> items, int capacity) {
  // sort biggest first
  items.sort((x, y) => y.compareTo(x));

  final weights = <int>[];

  for (var i = 0; i < items.length; i++) {
    var added = false;
    
    // try placing the item in j-th bin
    var j = 0;
    while (!added && j < weights.length) {
      if (weights[j] + items[i] < capacity) {
        weights[j] += items[i];
        added = true;
      }
      j++;
    }

    if (!added) {
      weights.add(items[i]);
    }
  }

  return weights.length;
}

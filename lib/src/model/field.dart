enum Status {
  normal,
  warning,
}

class SudokuField {

  SudokuField(this.index) {
    resetPossibleValues();
  }

  static List<int> allPossibleValues = [1,2,3,4,5,6,7,8,9];

  void resetPossibleValues() {
    if (value > 0) {
      this.possibleValues = [];
    } else {
      this.possibleValues = List.of(allPossibleValues);
    }
  }

  int index;
  int value = 0;
  Status status = Status.normal;
  List<int> possibleValues;

  Status getStatus() {
    return status;
  }

  void incrementValue() {
    if (value == 9) {
      value = 0;
    } else {
      value++;
    }
  }

  void removePossibleValue(int valueToRemove) {
    possibleValues.remove(valueToRemove);
  }
}
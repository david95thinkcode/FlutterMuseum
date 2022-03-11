class Country {
  late String _codePays;
  int _nbHabitant = 0;

  String get codePays => _codePays;

  set codePays(String value) {
    _codePays = value;
  }

  int get nbHabitant => _nbHabitant;

  set nbHabitant(int value) {
    _nbHabitant = value;
  }
}
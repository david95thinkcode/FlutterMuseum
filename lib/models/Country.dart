class Country {
  static String table = "country";

  final String codePays;
  final int nbHabitant;

  const Country({
    required this.codePays,
    required this.nbHabitant
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'codepays': codePays,
      'nbhabitant': nbHabitant,
    };
  }

  @override
  String toString() {
    return 'Country{codePays: $codePays, nbHabitants: $nbHabitant}';
  }
}
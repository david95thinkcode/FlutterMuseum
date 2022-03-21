class Country {
  static String table = "country";
  final String countryCode;
  final String countryName;
  final int nbHabitant;

  const Country({
    required this.countryCode,
    required this.countryName,
    required this.nbHabitant
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'codepays': countryCode,
      'nompays': countryName,
      'nbhabitant': nbHabitant,
    };
  }

  @override
  String toString() {
    return 'Country{codepays: $countryCode, nompays: $countryName, nbhabitant: $nbHabitant}';
  }
}
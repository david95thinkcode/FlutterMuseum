class Visit {
  static String table = "visit";
  // final int id;
  final int numMus;
  final int nbVisiteurs;
  final String jour;

  const Visit({
    // required this.id,
    required this.nbVisiteurs,
    required this.numMus,
    required this.jour
  });

  Map<String, dynamic> toMap() {
    return {
      'nummus': numMus,
      'nbvisiteurs': nbVisiteurs,
      'jour': jour
    };
  }

  @override
  String toString() {
    return 'Visit{numMus: $numMus, nbVisiteur: $nbVisiteurs, jour: $jour}';
  }
}
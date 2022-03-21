class Visit {
  static String table = "visit";
  // final int id;
  final int nbVisiteurs;
  final int numMus;
  final String firstname;
  final String lastname;
  final String jour;

  const Visit({
    // required this.id,
    required this.firstname,
    required this.lastname,
    required this.numMus,
    required this.jour,
    required this.nbVisiteurs,
  });

  Map<String, dynamic> toMap() {
    return {
      'nummus': numMus,
      'firstname': firstname,
      'lastname': lastname,
      'nbvisiteurs': nbVisiteurs,
      'jour': jour
    };
  }

  @override
  String toString() {
    return 'Visit{numMus: $numMus, firstname: $firstname, lastnmae: $lastname, nbVisiteur: $nbVisiteurs, jour: $jour}';
  }
}
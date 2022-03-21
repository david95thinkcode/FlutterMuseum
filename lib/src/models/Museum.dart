
class Museum {
  static String table = "museum";

  final int? numMus;
  final String nomMus;
  final int nbLivres;
  final String codePays;

  const Museum({
    this.numMus,
    required this.nomMus,
    required this.nbLivres,
    required this.codePays
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'numMus': numMus,
      'nomMus': nomMus,
      'nblivres': nbLivres,
      'codepays': codePays
    };
  }

  @override
  String toString() {
    return 'Museum{numMus: $numMus, nomMus: $nomMus, nbLivres: $nbLivres, codePays: $codePays}';
  }
}
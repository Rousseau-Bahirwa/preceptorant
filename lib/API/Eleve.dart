class Eleve {
  int idEleve;
  String nom;
  String postnom;
  String prenom;
  Eleve({this.idEleve, this.nom, this.postnom, this.prenom});

  factory Eleve.fromJson(Map<String, dynamic> json) {
    return Eleve(
      idEleve: json['idEleve'] as int,
      nom: json['nom'] as String,
      postnom: json['Postnom'] as String,
      prenom: json['Prenom'] as String,
    );
  }
}

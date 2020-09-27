import 'dart:convert';

import 'package:http/http.dart' as http;

class EnsegnanApi {
  static const ROOT = "http://192.168.43.5/Prepation/Traitement.php";
  //static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';

//SELECTIONNER LES VALEUR DU TABLEAU
  static Future<List<Ensegnant>> get_all() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      print('get_all Response : ${response.body}');
      if (200 == response.statusCode) {
        List<Ensegnant> list = parseResposed(response.body);
        return list;
      } else {
        return List<Ensegnant>();
      }
    } catch (e) {
      print("mal fais" + e.toString());
      return List<Ensegnant>();
    }
  }

  static List<Ensegnant> parseResposed(String responseBody) {
    final reposed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return reposed.map<Ensegnant>((json) => Ensegnant.fromJson(json)).toList();
  }

  //Mothode Pour Insert dans Eleve
  static Future<String> addEnseignant(
      String nom, String postnom, String prenom) async {
    print("ADD EMPLOYE");
    print("action $_ADD_EMP_ACTION");
    print("Nom : $nom");
    print("Postnom : $postnom");
    print("Tel : $prenom");
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_EMP_ACTION;
      map['Nom'] = nom;
      map['Postnom'] = postnom;
      map['prenom'] = prenom;
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        // print("-------------------succefully-------------------------");
        return response.body;
      } else {
        return ("mal fait");
      }
    } catch (e) {
      return ("mal fait");
    }
  }
}

class Ensegnant {
  int idEnseig;
  String nom;
  String postnom;
  String prenom;
  String titre;
  String filiere;
  Ensegnant(
      {this.idEnseig,
      this.nom,
      this.postnom,
      this.prenom,
      this.titre,
      this.filiere});
  factory Ensegnant.fromJson(Map<String, dynamic> json) {
    return Ensegnant(
        idEnseig: json['idEnseig'] as int,
        nom: json['nom'] as String,
        postnom: json['postnom'] as String,
        prenom: json['prenom'] as String);
  }
}

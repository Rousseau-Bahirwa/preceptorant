import 'Eleve.dart' ;
import 'dart:convert';
import 'package:http/http.dart' as http;

class Service {
  static const ROOT = "http://192.168.43.5/Prepation/Traitement.php";
  //static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';

//SELECTIONNER LES VALEUR DU TABLEAU
  static Future<List<Eleve>> get_all() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      print('get_all Response : ${response.body}');
      if (200 == response.statusCode) {
        List<Eleve> list = parseResposed(response.body);
        return list;
      } else {
        return List<Eleve>();
      }
    } catch (e) {
      print("mal fais" + e.toString());
      return List<Eleve>();
    }
  }

  static List<Eleve> parseResposed(String responseBody) {
    final reposed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return reposed.map<Eleve>((json) => Eleve.fromJson(json)).toList();
  }

  //Mothode Pour Insert dans Eleve
  static Future<String> addEleve(
      String nom, String postnom, String tel) async {
    print("ADD EMPLOYE");
    print("action $_ADD_EMP_ACTION");
    print("Nom : $nom");
    print("Postnom : $postnom");
    print("Tel : $tel");
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_EMP_ACTION;
      map['Nom'] = nom;
      map['Postnom'] = postnom;
      map['telephone'] = tel;
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

  //Methode Pour la Modification
  static Future<String> updatEleve(
      int _id, String _nom, String _postnom) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_EMP_ACTION;
      map['id'] = _id;
      map['Nom'] = _nom;
      map['PostNom'] = _postnom;
      final response = await http.post(ROOT, body: map);
      print('updatEleve Response : ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return ("mal fait");
      }
    } catch (e) {
      return ("mal fait");
    }
  }

  //Mothode de la supression
  static Future<String> deleteEleve(String idEmp) async {
    try {
      print(
          "--------------------- bien supprimer:$idEmp -----------------------------------");
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_EMP_ACTION;
      map['id'] = idEmp;
      final response = await http.post(ROOT, body: map);
      print('deleteEleve Response : ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return ("mal fait");
      }
    } catch (e) {
      return ("mal fait");
    }
  }
}
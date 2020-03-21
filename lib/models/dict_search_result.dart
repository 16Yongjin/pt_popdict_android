import 'package:pt_popdic/models/dict.dart';

class DictSearchResult {
  bool error;
  String message;
  List<Dict> dicts;

  DictSearchResult({this.error, this.message, this.dicts});

  DictSearchResult.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];

    if (json['dicts'] != null) {
      List<dynamic> dictsJson = json['dicts'];
      dicts = dictsJson.map((dict) => new Dict.fromJson(dict)).toList();
    }
  }
}

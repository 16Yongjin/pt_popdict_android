import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pt_popdic/models/dict.dart';
import 'package:pt_popdic/models/dict_search_result.dart';
import 'package:http/http.dart' as http;

class DictProvider with ChangeNotifier {
  DictSearchResult searchResult;
  bool _isLoading = false;
  bool _isPopup = false;

  Future<void> search(String query) async {
    if (query == null || query.isEmpty) return;

    _isLoading = true;
    notifyListeners();
    // print(query);
    // print(Uri.encodeComponent(query));
    var response = await http.get('https://ptdic.hufs.app/search/$query');
    print(response.body);
    searchResult = DictSearchResult.fromJson(json.decode(response.body));

    print(searchResult.message);
    print(searchResult.error);
    print(searchResult.dicts);

    _isLoading = false;
    notifyListeners();
  }

  DictProvider updateIsPopup(bool value) {
    _isPopup = value;

    return this;
  }

  bool get isPopup => _isPopup;

  bool get hasDict =>
      searchResult != null && !searchResult.error && searchResult.dicts != null;

  bool get hasError => searchResult == null || searchResult.error;

  bool get isLoading => _isLoading;

  bool get noDict => !isLoading && searchResult == null;

  List<Dict> get dicts => searchResult.dicts;

  String get message => _isLoading
      ? '로딩 중'
      : searchResult != null ? searchResult.message : '????';
}

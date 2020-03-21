import 'package:flutter/material.dart';
import 'package:pt_popdic/provider/dict.dart';
import 'package:provider/provider.dart';

class DictSearchBar extends StatefulWidget {
  @override
  _DictSearchBarState createState() => _DictSearchBarState();
}

class _DictSearchBarState extends State<DictSearchBar> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  String get query => _textEditingController.text;

  void clearQuery() {
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(10.0),
      //   color: Colors.white,
      // ),
      child: TextFormField(
        validator: (query) {
          return query.isEmpty ? '단어를 입력해주세요' : null;
        },
        controller: _textEditingController,
        decoration: InputDecoration(
          labelText: "단어 검색",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(),
          ),
          suffixIcon: Wrap(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  clearQuery();
                },
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Provider.of<DictProvider>(context).search(query);
                },
              ),
            ],
          ),
        ),
        onFieldSubmitted: (query) {
          Provider.of<DictProvider>(context).search(query);
        },
        textInputAction: TextInputAction.search,
      ),
    );
  }
}

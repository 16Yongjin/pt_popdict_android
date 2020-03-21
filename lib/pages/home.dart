import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pt_popdic/models/dict.dart';
import 'package:pt_popdic/provider/dict.dart';
import 'package:pt_popdic/widgets/dict_search_bar.dart';
import 'package:pt_popdic/widgets/dict_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  static const platform = const MethodChannel('app.channel.shared.data');
  String dataShared;
  List<Dict> dicts;
  bool initialLoading = true;

  @override
  void initState() {
    super.initState();
    getSharedText();
  }

  bool get isPopup => initialLoading || dataShared != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isPopup ? Colors.black.withOpacity(0.2) : Colors.white,
      body: initialLoading
          ? Container(child: Center(child: CircularProgressIndicator()))
          : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                DictView(),
                if (dataShared == null) DictSearchBar(),
              ],
            ),
      appBar: !isPopup
          ? AppBar(
              title: Text('포르투갈어 검색', style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.white,
            )
          : null,
    );
  }

  getSharedText() async {
    try {
      var sharedData = await platform.invokeMethod("getSharedText");
      print(sharedData);

      if (sharedData != null) {
        setState(() {
          dataShared = sharedData;
          print(dataShared);
          print('텍스트 공유됨');
          Provider.of<DictProvider>(context)
              .updateIsPopup(true)
              .search(dataShared);
          initialLoading = false;
        });
      }
    } catch (e) {
      print('공유 텍스트 없음');
      setState(() {
        initialLoading = false;
      });
    }
  }
}

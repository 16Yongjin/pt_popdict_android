import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pt_popdic/models/dict.dart';
import 'package:pt_popdic/models/dict_search_result.dart';
import 'package:pt_popdic/provider/dict.dart';
import 'package:pt_popdic/widgets/dict_card.dart';
import 'package:provider/provider.dart';

import 'info_card.dart';

class DictView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dictProvider = Provider.of<DictProvider>(context);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          print('리스트뷰 클릭됨');
          if (dictProvider.isPopup) {
            print('앱 종료');
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }
        },
        child: ListView(children: [
          if (!dictProvider.isPopup) SizedBox(height: 10),
          if (dictProvider.isLoading)
            Container(
                height: 300, child: Center(child: CircularProgressIndicator()))
          else
            if (dictProvider.hasDict)
              GestureDetector(
                onTap: () {
                  print('단어 클릭됨');
                },
                child: Column(
                  children:
                      dictProvider.dicts.map((dict) => DictCard(dict)).toList(),
                ),
              )
            else
              if (dictProvider.noDict)
                Center(child: InfoCard('단어를 입력해주세요'))
              else
                if (dictProvider.hasError)
                  Center(child: InfoCard(dictProvider.message)),
          SizedBox(height: 10),
        ]),
      ),
    );
  }
}

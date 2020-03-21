import 'package:flutter/material.dart';
import 'package:pt_popdic/models/dict.dart';

class DictCard extends StatelessWidget {
  final Dict dict;

  DictCard(this.dict);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 8,
        child: Container(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 15),
          child: Column(
            children: <Widget>[
              CardTitle(dict),
              ...dict.means
                  .asMap()
                  .map((index, mean) =>
                      MapEntry(index, CardContent(index, mean)))
                  .values
            ],
          ),
        ),
      ),
    );
  }
}

class CardTitle extends StatelessWidget {
  final Dict dict;

  CardTitle(this.dict);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Text(dict.entry, style: TextStyle(fontSize: 26)),
          Text(
            ' ${dict.pron}',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          )
        ],
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final int index;
  final Mean mean;

  CardContent(this.index, this.mean);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: RichText(
          text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '${index + 1}. ',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: mean.part,
            style: TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(122, 150, 185, 1),
            ),
          ),
          TextSpan(
            text: ' ${mean.mean}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      )),
    );
  }
}

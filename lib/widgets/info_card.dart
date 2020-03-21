import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String text;

  InfoCard(this.text);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}

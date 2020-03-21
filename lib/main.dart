import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:pt_popdic/pages/home.dart';
import 'package:pt_popdic/provider/dict.dart';
import 'package:provider/provider.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(builder: (_) => DictProvider())],
      child: Consumer<DictProvider>(
        builder: (context, dictProvier, _) {
          return MaterialApp(
            title: 'PT POPDIC',
            home: HomePage(),
          );
        },
      ),
    );
  }
}

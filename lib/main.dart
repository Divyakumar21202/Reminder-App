import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
void main() {
  runApp(const MainApp());
}




class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {}),
        body: Center(
          child: Observer(
            builder: (context) {
              return Text('0');
            },
          ),
        ),
      ),
    );
  }
}

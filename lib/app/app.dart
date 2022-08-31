// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  MyApp._internal();
  int appState = 0;
  static final MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  void updateAppState() {
    MyApp().appState = 11;
  }

  void printAppState() {
    print(MyApp().appState);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Test2 extends StatelessWidget {
  const Test2({Key? key}) : super(key: key);
  void printAppState() {
    print(MyApp().appState);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

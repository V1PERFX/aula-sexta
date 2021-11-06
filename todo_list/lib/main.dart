import 'package:flutter/material.dart';
import 'package:todo_list/screens/home.dart';
import 'package:todo_list/theme/theme.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "ToDo List",
    home: const Home(),
    themeMode: ThemeMode.system,
    theme: lightTheme(),
    darkTheme: darkTheme(),
  ));
}


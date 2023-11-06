import 'package:flutter/material.dart';
import 'package:pokedexter/pages/home/home_page.dart';
import 'package:pokedexter/utils/extensions/theme_extension.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeApi Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeExt.lightTheme,
      themeMode: ThemeMode.light,
      darkTheme: ThemeExt.darkTheme,
      home: const HomePage(),
    );
  }
}

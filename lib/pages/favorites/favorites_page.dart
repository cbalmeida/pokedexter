import 'package:flutter/material.dart';
import 'package:pokedexter/utils/extensions/context_extension.dart';

import 'favorites_page_list.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();

  static navigateTo(BuildContext context) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FavoritesPage()));
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: context.primaryColor,
          foregroundColor: context.primaryBgColor,
          title: Text('Favorites', style: context.textTheme.displayLarge!.copyWith(color: context.primaryBgColor)),
        ),
        body: const FavoritesPageList());
  }
}

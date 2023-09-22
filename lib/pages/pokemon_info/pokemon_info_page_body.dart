import 'package:example/pages/pokemon_info/pokemon_info_page_tab.dart';
import 'package:example/pages/pokemon_info/tabs/pokemon_info_page_tab_about.dart';
import 'package:example/pages/pokemon_info/tabs/pokemon_info_page_tab_evolution.dart';
import 'package:example/pages/pokemon_info/tabs/pokemon_info_page_tab_moves.dart';
import 'package:example/pages/pokemon_info/tabs/pokemon_info_page_tab_stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/flutter_pokeapi.dart';

import '../../utils/values/poke_type_values.dart';

class PokemonInfoPageBody extends StatefulWidget {
  final Pokemon pokemon;
  final List<PokeType> pokeTypes;
  const PokemonInfoPageBody({super.key, required this.pokemon, required this.pokeTypes});

  @override
  State<PokemonInfoPageBody> createState() => _PokemonInfoPageBodyState();
}

class _PokemonInfoPageBodyState extends State<PokemonInfoPageBody> with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: tabs.length, vsync: this);

  late List<PokemonInfoPageTab> tabs = [
    PokemonInfoPageTabAbout(pokemon: widget.pokemon, pokeTypes: widget.pokeTypes),
    PokemonInfoPageTabStats(pokemon: widget.pokemon, pokeTypes: widget.pokeTypes),
    PokemonInfoPageTabEvolution(pokemon: widget.pokemon, pokeTypes: widget.pokeTypes),
    PokemonInfoPageTabMoves(pokemon: widget.pokemon, pokeTypes: widget.pokeTypes),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(controller: tabController, tabs: tabs.map((e) => e.tab).toList()),
        Expanded(child: AnimatedBuilder(animation: tabController, builder: (context, child) => tabs[tabController.index])),
      ],
    );
  }
}

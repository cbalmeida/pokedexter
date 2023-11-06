import 'package:flutter/material.dart';
import 'package:pokeapi_wrapper/pokeapi_wrapper.dart';

abstract class PokemonInfoPageTab extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonInfoPageTab({super.key, required this.pokemon});

  Tab get tab;
}

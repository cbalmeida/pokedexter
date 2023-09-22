import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/flutter_pokeapi.dart';

abstract class PokemonInfoPageTab extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonInfoPageTab({super.key, required this.pokemon});

  Tab get tab;
}

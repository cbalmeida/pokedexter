import 'package:example/widgets/poketype_chip/poketype_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/flutter_pokeapi.dart';

import '../../utils/values/poke_type_values.dart';

class PokeTypeChipList extends StatelessWidget {
  final Pokemon pokemon;
  final List<PokeType> pokeTypes;
  const PokeTypeChipList({Key? key, required this.pokemon, required this.pokeTypes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 4, runSpacing: 4, children: pokeTypes.map((pokeType) => PokeTypeChip(pokeType: pokeType)).toList());
  }
}

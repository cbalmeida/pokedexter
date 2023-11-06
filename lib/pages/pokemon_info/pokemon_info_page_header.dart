import 'package:flutter/material.dart';
import 'package:pokeapi_wrapper/pokeapi_wrapper.dart';

import '../../utils/values/poke_type_values.dart';
import '../../widgets/favorite_button.dart/favorite_button.dart';
import '../../widgets/pokemon_image_widget.dart';
import '../../widgets/poketype_chip/poketype_chip_list.dart';

class PokemonInfoPageHeader extends StatelessWidget {
  final Pokemon pokemon;
  final List<PokeType> pokeTypes;
  const PokemonInfoPageHeader({super.key, required this.pokemon, required this.pokeTypes});

  PokeType? get mainPokeType => pokeTypes.firstOrNull;
  double get spriteSize => 54;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: mainPokeType?.color, gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [mainPokeType?.color ?? Colors.white, mainPokeType?.colorCard ?? Colors.white])),
      child: Stack(
        children: [
          PokemonImageWidget(pokemon: pokemon),
          Align(alignment: Alignment.centerRight, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), child: PokeTypeChipList(pokemon: pokemon, pokeTypes: pokeTypes))),
          Padding(padding: const EdgeInsets.only(top: 16, right: 16), child: Align(alignment: Alignment.topRight, child: FavoriteButton(pokemon: pokemon))),
        ],
      ),
    );
  }
}

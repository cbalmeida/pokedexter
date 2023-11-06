import 'package:flutter/material.dart';
import 'package:pokeapi_wrapper/pokeapi_wrapper.dart';
import 'package:pokedexter/utils/extensions/context_extension.dart';
import 'package:pokedexter/utils/extensions/int_extension.dart';
import 'package:pokedexter/utils/extensions/string_extension.dart';

class PokemonNameWidget extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonNameWidget({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'PokemonNameWidget_${pokemon.id}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(pokemon.id.asPokemonIdNumber, style: context.textTheme.bodyMedium?.copyWith(color: Colors.white)),
          Text(
            pokemon.name.capitalizeFirstLetter,
            style: context.textTheme.displaySmall?.copyWith(color: Colors.white),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

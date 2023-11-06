import 'package:flutter/material.dart';
import 'package:pokeapi_wrapper/pokeapi_wrapper.dart';

import '../pokemon_widget.dart';
import 'pokemon_card_error.dart';
import 'pokemon_card_success.dart';
import 'pokemon_card_waiting.dart';

class PokemonCard extends PokemonWidget {
  static double get itemExtent => 132;
  final Function(Pokemon pokemon) onTap;
  const PokemonCard({super.key, required super.apiResource, required this.onTap});

  factory PokemonCard.fromPokemonId({required int pokemonId, required Function(Pokemon pokemon) onTap}) {
    return PokemonCard(apiResource: Pokemon.adapter.apiResourceFromId(pokemonId), onTap: onTap);
  }

  @override
  Widget onError(BuildContext context, Error error) {
    return PokemonCardError(error: error);
  }

  @override
  Widget onSuccess(BuildContext context, Pokemon value) {
    return PokemonCardSuccess(pokemon: value, onTap: onTap);
  }

  @override
  Widget onWaiting(BuildContext context) {
    return const PokemonCardWaiting();
  }
}

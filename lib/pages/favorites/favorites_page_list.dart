import 'package:flutter/material.dart';
import 'package:pokeapi_wrapper/pokeapi_wrapper.dart';

import '../../providers/favorites_provider.dart';
import '../../widgets/pokemon_card/pokemon_card.dart';
import '../../widgets/pokemon_id_list_widget.dart';
import '../pokemon_info/pokemon_info_page.dart';

class FavoritesPageList extends PokemonIdListWidget {
  const FavoritesPageList({super.key});

  @override
  Widget onBuildError(BuildContext context, Error error) {
    return Center(child: Text(error.toString()));
  }

  @override
  Widget onBuildPokemon(BuildContext context, int pokemonId) {
    return PokemonCard.fromPokemonId(pokemonId: pokemonId, onTap: (pokemon) => PokemonInfoPage.navigateTo(context, pokemon));
  }

  @override
  Widget onBuildWaiting(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  @override
  double get itemExtent => PokemonCard.itemExtent;

  @override
  Future<Either<Error, List<int>>> get future async => Right(FavoritesProvider.instance.favorites);
}

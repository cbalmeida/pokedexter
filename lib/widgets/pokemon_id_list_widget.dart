import 'package:flutter/cupertino.dart';
import 'package:flutter_pokeapi/flutter_pokeapi.dart';

abstract class PokemonIdListWidget extends FutureBuilderWidget<List<int>> {
  Widget onBuildPokemon(BuildContext context, int pokemonId);
  Widget onBuildWaiting(BuildContext context);
  Widget onBuildError(BuildContext context, Error error);

  double get itemExtent;

  const PokemonIdListWidget({super.key});

  @override
  Future<Either<Error, List<int>>> get future;

  @override
  Widget onWaiting(BuildContext context) => onBuildWaiting(context);

  @override
  Widget onError(BuildContext context, Error error) => onBuildError(context, error);

  @override
  Widget onSuccess(BuildContext context, List<int> value) {
    return ListView.builder(
      shrinkWrap: true,
      itemExtent: itemExtent,
      itemCount: value.length,
      itemBuilder: (context, index) {
        final int pokemonId = value[index];
        return onBuildPokemon(context, pokemonId);
      },
    );
  }
}

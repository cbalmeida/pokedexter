import 'package:pokeapi_wrapper/pokeapi_wrapper.dart';

abstract class PokemonWidget extends FutureBuilderWidget<Pokemon> {
  final PokemonApiResource apiResource;

  const PokemonWidget({super.key, required this.apiResource});

  @override
  Future<Either<Error, Pokemon>> get future => PokeApi.getPokemon(apiResource);
}

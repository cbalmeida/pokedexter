import 'package:flutter_pokeapi/flutter_pokeapi.dart';

extension PokemonExtension on Pokemon {
  /// Fetches the pokemon's types
  Future<Either<Error, List<Type>>> fetchTypes() async {
    List<Type> result = [];
    for (PokemonType pokemonType in types) {
      Either<Error, Type> type = await pokemonType.type;
      if (type.isLeft) return Left(type.left);
      result.add(type.right);
    }
    return Right(result);
  }

  /// Fetches the pokemon's abilities
  Future<Either<Error, List<Ability>>> fetchAbilities() async {
    List<Ability> result = [];
    for (PokemonAbility pokemonAbility in abilities) {
      Either<Error, Ability> ability = await pokemonAbility.ability;
      if (ability.isLeft) return Left(ability.left);
      result.add(ability.right);
    }
    return Right(result);
  }

  /// Fetches the pokemon's stats
  Future<Either<Error, List<Stat>>> fetchStats() async {
    List<Stat> result = [];
    for (PokemonStat pokemonStat in stats) {
      Either<Error, Stat> stat = await pokemonStat.stat;
      if (stat.isLeft) return Left(stat.left);
      result.add(stat.right);
    }
    return Right(result);
  }

  /// Fetches the pokemon's evolutions
  Future<Either<Error, List<Pokemon>>> fetchEvolutionList() async {
    Either<Error, PokemonSpecies> species = await this.species;
    if (species.isLeft) return Left(species.left);
    return species.right.fetchEvolutionList();
  }

  /// Fetches the pokemon's held items
  Future<Either<Error, List<Item>>> fetchHeldItems() async {
    List<Item> result = [];
    for (PokemonHeldItem pokemonHeldItem in heldItems) {
      Either<Error, Item> item = await pokemonHeldItem.item;
      if (item.isLeft) return Left(item.left);
      result.add(item.right);
    }
    return Right(result);
  }
}

extension PokemonSpeciesExtension on PokemonSpecies {
  /// Fetches the pokemon's evolutions
  Future<Either<Error, List<Pokemon>>> fetchEvolutionList() async {
    Either<Error, EvolutionChain> evolutionChain = await this.evolutionChain;
    if (evolutionChain.isLeft) return Left(evolutionChain.left);
    return evolutionChain.right.chain.fetchEvolutionList();
  }
}

extension ChainLinkExtension on ChainLink {
  /// Fetches the pokemon's evolutions
  Future<Either<Error, List<Pokemon>>> fetchEvolutionList() async {
    List<Pokemon> list = [];
    Either<Error, PokemonSpecies> species = await this.species;
    if (species.isLeft) return Left(species.left);
    Either<Error, Pokemon> pokemon = await Pokemon.adapter.fromName(service: service, name: species.right.name);
    list.add(pokemon.right);
    for (ChainLink chainLink in evolvesTo) {
      Either<Error, List<Pokemon>> pokemon = await chainLink.fetchEvolutionList();
      if (pokemon.isLeft) return Left(pokemon.left);
      list.addAll(pokemon.right);
    }
    return Right(list);
  }
}

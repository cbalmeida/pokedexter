import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi_wrapper/pokeapi_wrapper.dart';

class PokemonImageWidget extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonImageWidget({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'PokemonImageWidget_${pokemon.id}',
      child: CachedNetworkImage(
        imageUrl: pokemon.sprites.officialArtWork,
        fit: BoxFit.fill,
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}

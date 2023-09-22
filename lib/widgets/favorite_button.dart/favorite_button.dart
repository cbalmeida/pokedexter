import 'package:example/providers/favorites_provider.dart';
import 'package:example/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/flutter_pokeapi.dart';

import '../../utils/icons/poke_icons.dart';
import '../../utils/messages/messages.dart';

class FavoriteButton extends StatelessWidget {
  final Pokemon pokemon;
  const FavoriteButton({Key? key, required this.pokemon}) : super(key: key);

  FavoritesProvider get favoritesProvider => FavoritesProvider.instance;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: favoritesProvider,
      builder: (context, child) {
        return IconButton(
          onPressed: () => _toggleFavorite(context, favoritesProvider),
          icon: favoritesProvider.isFavorite(pokemon.id) ? const Icon(PokeIcons.heartFilled, color: Colors.white) : const Icon(PokeIcons.heart, color: Colors.white),
        );
      },
    );
  }

  void _toggleFavorite(BuildContext context, FavoritesProvider favoriteProvider) {
    favoriteProvider.toggleFavorite(pokemon.id);
    if (favoriteProvider.isFavorite(pokemon.id)) {
      Messages.of(context).addedToFavorites(pokemon.name.capitalizeFirstLetter);
    } else {
      Messages.of(context).removedFromFavorites(pokemon.name.capitalizeFirstLetter);
    }
  }
}

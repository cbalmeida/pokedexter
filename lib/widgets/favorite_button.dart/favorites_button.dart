import 'package:flutter/material.dart';

import '../../providers/favorites_provider.dart';
import '../../utils/icons/poke_icons.dart';

class FavoritesButton extends StatelessWidget {
  final VoidCallback onPressed;
  const FavoritesButton({super.key, required this.onPressed});

  FavoritesProvider get favoritesProvider => FavoritesProvider.instance;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: favoritesProvider,
      builder: (context, child) {
        List<int> favorites = favoritesProvider.favorites;
        return IconButton(
          onPressed: onPressed,
          icon: favorites.isEmpty
              ? const Icon(PokeIcons.heart, color: Colors.white, size: 24)
              : Badge.count(
                  count: favorites.length,
                  backgroundColor: Colors.yellow,
                  textColor: Colors.blue,
                  textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  child: const Icon(PokeIcons.heartFilled, color: Colors.white, size: 24),
                ),
          tooltip: "Favorites",
        );
      },
    );
  }
}

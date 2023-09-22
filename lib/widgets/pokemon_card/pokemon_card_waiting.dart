import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class PokemonCardWaiting extends StatelessWidget {
  const PokemonCardWaiting({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Container(
          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(32)),
        ),
      ),
    );
  }
}

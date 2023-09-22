import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class PokemonCardError extends StatelessWidget {
  final Error error;
  const PokemonCardError({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Container(
          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(32)),
          child: Center(
            child: Text(error.toString()),
          ),
        ),
      ),
    );
  }
}

import 'package:example/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../utils/values/poke_type_values.dart';

class PokeTypeChip extends StatelessWidget {
  final PokeType pokeType;
  const PokeTypeChip({Key? key, required this.pokeType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: pokeType.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 0.5, color: Colors.white, strokeAlign: BorderSide.strokeAlignCenter),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(pokeType.icon, color: Colors.white, size: 14),
            const SizedBox(width: 4),
            Text(pokeType.name.capitalizeFirstLetter, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}

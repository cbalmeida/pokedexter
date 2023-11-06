import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokeapi_wrapper/pokeapi_wrapper.dart';
import 'package:pokedexter/utils/extensions/pokeapi_extension.dart';

import '../../providers/favorites_provider.dart';
import '../../utils/assets/assets.dart';
import '../../utils/values/poke_type_values.dart';
import '../favorite_button.dart/favorite_button.dart';
import '../pokemon_image_widget.dart';
import '../pokemon_name_widget.dart';
import '../poketype_chip/poketype_chip_list.dart';

class PokemonCardSuccess extends StatefulWidget {
  final Pokemon pokemon;
  final Function(Pokemon pokemon) onTap;
  const PokemonCardSuccess({super.key, required this.pokemon, required this.onTap});

  @override
  State<PokemonCardSuccess> createState() => _PokemonCardSuccessState();
}

class _PokemonCardSuccessState extends State<PokemonCardSuccess> {
  List<PokeType> pokeTypes = [];

  PokeType? get mainPokeType => pokeTypes.firstOrNull;

  FavoritesProvider get favoritesProvider => FavoritesProvider.instance;

  _initializePokeTypes() async {
    pokeTypes = [];
    Either<Error, List<Type>> result = await widget.pokemon.fetchTypes();
    if (result.isLeft) return;
    for (Type type in result.right) {
      pokeTypes.add(PokeTypes.get(type.name));
    }
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant PokemonCardSuccess oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) _initializePokeTypes();
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) _initializePokeTypes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(widget.pokemon),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 0.5),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [mainPokeType?.color ?? Colors.white, mainPokeType?.colorCard ?? Colors.white]),
            borderRadius: BorderRadius.circular(0),
          ),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(flex: 12, child: SizedBox.shrink()),
                  Expanded(flex: 6, child: SvgPicture.asset(Assets.pokeball, fit: BoxFit.fitWidth)),
                  const Expanded(flex: 2, child: SizedBox.shrink()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 12,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(child: PokemonNameWidget(pokemon: widget.pokemon)),
                          const SizedBox(height: 16),
                          PokeTypeChipList(pokemon: widget.pokemon, pokeTypes: pokeTypes),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: PokemonImageWidget(pokemon: widget.pokemon),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16, right: 0),
                        child: FavoriteButton(pokemon: widget.pokemon),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

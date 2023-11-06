import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi_wrapper/pokeapi_wrapper.dart';
import 'package:pokedexter/utils/extensions/context_extension.dart';
import 'package:pokedexter/utils/extensions/int_extension.dart';
import 'package:pokedexter/utils/extensions/pokeapi_extension.dart';
import 'package:pokedexter/utils/extensions/string_extension.dart';

import '../../../utils/values/poke_type_values.dart';
import '../../../widgets/favorite_button.dart/favorite_button.dart';
import '../pokemon_info_page_tab.dart';

class PokemonInfoPageTabEvolution extends PokemonInfoPageTab {
  final List<PokeType> pokeTypes;
  const PokemonInfoPageTabEvolution({super.key, required super.pokemon, required this.pokeTypes});

  @override
  State<PokemonInfoPageTabEvolution> createState() => _PokemonInfoPageTabEvolutionState();

  @override
  Tab get tab => const Tab(child: Text("Evolution", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)));
}

class _PokemonInfoPageTabEvolutionState extends State<PokemonInfoPageTabEvolution> {
  Pokemon get pokemon => widget.pokemon;
  List<PokeType> get pokeTypes => widget.pokeTypes;
  PokeType? get mainPokeType => pokeTypes.firstOrNull;

  List<Pokemon>? evolutionList;

  @override
  void initState() {
    super.initState();
    pokemon.fetchEvolutionList().then((value) {
      if (value.isRight) evolutionList = value.right;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (evolutionList == null) return const Padding(padding: EdgeInsets.only(top: 48), child: Center(child: CircularProgressIndicator()));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: evolutionList!.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) => _PokemonCard(pokemon: evolutionList![index]),
      ),
    );
  }
}

class _PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  const _PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 0.5),
      child: Stack(
        children: [
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
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(pokemon.id.asPokemonIdNumber, style: context.textTheme.bodyMedium?.copyWith(color: Colors.white)),
                            Text(
                              pokemon.name.capitalizeFirstLetter,
                              style: context.textTheme.displaySmall?.copyWith(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: CachedNetworkImage(
                    imageUrl: pokemon.sprites.officialArtWork,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, right: 0),
                    child: FavoriteButton(pokemon: pokemon),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

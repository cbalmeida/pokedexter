import 'package:flutter/material.dart';
import 'package:pokeapi_wrapper/pokeapi_wrapper.dart';
import 'package:pokedexter/pages/pokemon_info/pokemon_info_page_body.dart';
import 'package:pokedexter/pages/pokemon_info/pokemon_info_page_header.dart';
import 'package:pokedexter/utils/extensions/context_extension.dart';
import 'package:pokedexter/utils/extensions/pokeapi_extension.dart';

import '../../providers/favorites_provider.dart';
import '../../utils/values/poke_type_values.dart';
import '../../widgets/pokemon_name_widget.dart';

class PokemonInfoPage extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonInfoPage({super.key, required this.pokemon});

  @override
  State<PokemonInfoPage> createState() => _PokemonInfoPageState();

  static navigateTo(BuildContext context, Pokemon pokemon) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => PokemonInfoPage(pokemon: pokemon)));
}

class _PokemonInfoPageState extends State<PokemonInfoPage> {
  List<PokeType> pokeTypes = [];

  PokeType? get mainPokeType => pokeTypes.firstOrNull;

  FavoritesProvider get favoritesProvider => FavoritesProvider.instance;

  _initializePokeTypes() async {
    Either<Error, List<Type>> result = await widget.pokemon.fetchTypes();
    if (result.isLeft) return;
    for (Type type in result.right) {
      pokeTypes.add(PokeTypes.get(type.name));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initializePokeTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainPokeType?.colorCard ?? context.primaryColor,
        appBar: AppBar(
          backgroundColor: mainPokeType?.color ?? context.primaryColor,
          foregroundColor: context.primaryBgColor,
          title: PokemonNameWidget(pokemon: widget.pokemon),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(flex: 1, child: PokemonInfoPageHeader(pokemon: widget.pokemon, pokeTypes: pokeTypes)),
            Expanded(flex: 4, child: PokemonInfoPageBody(pokemon: widget.pokemon, pokeTypes: pokeTypes)),
          ],
        ));
  }
}

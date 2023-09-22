import 'package:example/pages/pokemon_info/pokemon_info_page_tab.dart';
import 'package:example/utils/extensions/int_extension.dart';
import 'package:example/utils/extensions/pokeapi_extension.dart';
import 'package:example/utils/extensions/string_extension.dart';
import 'package:example/widgets/label_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/flutter_pokeapi.dart';

import '../../../utils/values/poke_type_values.dart';

class PokemonInfoPageTabAbout extends PokemonInfoPageTab {
  final List<PokeType> pokeTypes;
  const PokemonInfoPageTabAbout({super.key, required super.pokemon, required this.pokeTypes});

  @override
  State<PokemonInfoPageTabAbout> createState() => _PokemonInfoPageTabAboutState();

  @override
  Tab get tab => const Tab(child: Text("About", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)));
}

class _PokemonInfoPageTabAboutState extends State<PokemonInfoPageTabAbout> {
  Pokemon get pokemon => widget.pokemon;
  List<PokeType> get pokeTypes => widget.pokeTypes;
  PokeType? get mainPokeType => pokeTypes.firstOrNull;

  double get itemHeight => 48;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: itemHeight, child: LabelValueWidget(label: "Category", value: mainPokeType?.name.capitalizeFirstLetter ?? "")),
          SizedBox(height: itemHeight, child: LabelValueWidget(label: "Base Exp.", value: pokemon.baseExperience.toString())),
          SizedBox(height: itemHeight, child: LabelValueWidget(label: "Height", value: pokemon.height.metersToMetersOrCentimeters)),
          SizedBox(height: itemHeight, child: LabelValueWidget(label: "Weight", value: "${pokemon.weight}Hg")),
          SizedBox(height: itemHeight, child: LabelFutureValueWidget(label: "Abilities", futureValue: pokemon.fetchAbilities(), valueToString: (value) => value.map((e) => e.name.capitalizeFirstLetter).join(", "))),
          SizedBox(height: itemHeight, child: LabelFutureValueWidget(label: "Forms", futureValue: pokemon.forms, valueToString: (value) => value.map((e) => e.name.capitalizeFirstLetter).join(", "))),
          SizedBox(height: itemHeight, child: LabelFutureValueWidget(label: "Held Items", futureValue: pokemon.fetchHeldItems(), valueToString: (value) => value.map((e) => e.name.capitalizeFirstLetter).join(", "))),
        ],
      ),
    );
  }
}

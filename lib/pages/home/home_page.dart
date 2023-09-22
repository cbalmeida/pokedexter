import 'package:example/pages/pokemon_info/pokemon_info_page.dart';
import 'package:example/utils/extensions/context_extension.dart';
import 'package:example/widgets/poketype_chip/poketype_chip.dart';
import 'package:flutter/material.dart';

import '../../utils/assets/assets.dart';
import '../../utils/values/poke_type_values.dart';
import '../../widgets/favorite_button.dart/favorites_button.dart';
import '../../widgets/pokemon_list_widget.dart';
import '../favorites/favorites_page.dart';
import 'home_page_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  ValueNotifier<PokeType> selectedPokeType = ValueNotifier(PokeTypes.any);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomePageDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: context.primaryColor,
          foregroundColor: context.primaryBgColor,
          actions: [
            FavoritesButton(onPressed: () => FavoritesPage.navigateTo(context)),
          ],
          title: Center(child: SizedBox(height: 50, child: Image.asset(Assets.pokeApiDemo, fit: BoxFit.cover))),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Search",
                suffixIcon: ValueListenableBuilder(
                    valueListenable: selectedPokeType,
                    builder: (context, value, child) {
                      return PokeTypeDropdownMenu(selectedPokeType: selectedPokeType);
                    }),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(0), borderSide: BorderSide.none),
              ),
            ),
          )),
      body: ValueListenableBuilder(
          valueListenable: textEditingController,
          builder: (context, searchText, child) {
            return PokemonListWidget(
              onTapPokemon: (pokemon) => PokemonInfoPage.navigateTo(context, pokemon),
              searchTextEditingController: textEditingController,
              selectedPokeType: selectedPokeType,
            );
          }),
    );
  }
}

class PokeTypeDropdownMenu extends StatelessWidget {
  final ValueNotifier<PokeType> selectedPokeType;
  const PokeTypeDropdownMenu({super.key, required this.selectedPokeType});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PokeType>(
      icon: PokeTypeChip(pokeType: selectedPokeType.value),
      onSelected: (pokeType) => selectedPokeType.value = pokeType,
      itemBuilder: (BuildContext context) {
        return PokeTypes.types.map((PokeType pokeType) {
          return PopupMenuItem<PokeType>(value: pokeType, child: PokeTypeChip(pokeType: pokeType));
        }).toList();
      },
    );
  }
}

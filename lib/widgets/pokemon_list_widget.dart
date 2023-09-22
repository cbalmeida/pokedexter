import 'dart:async';

import 'package:example/utils/extensions/pokeapi_extension.dart';
import 'package:example/widgets/pokemon_card/pokemon_card.dart';
import 'package:example/widgets/pokemon_card/pokemon_card_success.dart';
import 'package:example/widgets/pokemon_card/pokemon_card_waiting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/flutter_pokeapi.dart';

import '../utils/values/poke_type_values.dart';

class PokemonListWidget extends StatefulWidget {
  final Function(Pokemon pokemon) onTapPokemon;
  final TextEditingController searchTextEditingController;
  final ValueNotifier<PokeType?> selectedPokeType;
  const PokemonListWidget({
    super.key,
    required this.onTapPokemon,
    required this.searchTextEditingController,
    required this.selectedPokeType,
  });

  @override
  State<PokemonListWidget> createState() => PokemonListWidgetState();
}

class PokemonListWidgetState extends State<PokemonListWidget> {
  final Map<int, Pokemon> pokemonList = {};
  final ScrollController controller = ScrollController();
  bool isLoadingApiResourceList = true;
  String errorLoadingApiResourceList = "";
  List<PokemonApiResource> pokemonApiResourceList = [];
  int lastCheckedItemIndex = -1;
  bool isLoadingNextItems = false;

  _loadNextItems() async {
    if (isLoadingNextItems) return;
    isLoadingNextItems = true;
    Future.delayed(const Duration(milliseconds: 100), () async {
      for (int i = 0; i < 10; i++) {
        int res = await addNewItem();
        if (res == -1) break;
      }
      isLoadingNextItems = false;
      setState(() {});
    });
  }

  Timer? timerSearch;

  onFilterChanged() {
    if (timerSearch != null) timerSearch!.cancel();
    timerSearch = Timer(const Duration(milliseconds: 500), () {
      lastCheckedItemIndex = -1;
      pokemonList.clear();
      _loadNextItems();
    });
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(controllerListener);
    widget.searchTextEditingController.addListener(onFilterChanged);
    widget.selectedPokeType.addListener(onFilterChanged);
    PokeApi.getPokemonList().then((result) {
      setState(() {
        if (result.isLeft) {
          errorLoadingApiResourceList = result.left.toString();
        } else {
          pokemonApiResourceList = result.right;
        }
        isLoadingApiResourceList = false;
        _loadNextItems();
      });
    });
  }

  @override
  void dispose() {
    controller.removeListener(controllerListener);
    widget.searchTextEditingController.removeListener(onFilterChanged);
    widget.selectedPokeType.removeListener(onFilterChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingApiResourceList) return const PokemonCardWaiting();
    if (errorLoadingApiResourceList.isNotEmpty) return Center(child: Text(errorLoadingApiResourceList));
    List<Pokemon> pokemonList = this.pokemonList.values.toList()..sort((a, b) => a.id.compareTo(b.id));
    return ListView.builder(
        controller: controller,
        itemExtent: PokemonCard.itemExtent,
        shrinkWrap: true,
        itemCount: pokemonList.length + (isLoadingNextItems ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= pokemonList.length - 1) _loadNextItems();
          if (index >= pokemonList.length) return const PokemonCardWaiting();
          return PokemonCardSuccess(key: ValueKey(pokemonList[index].id), pokemon: pokemonList[index], onTap: widget.onTapPokemon);
        });
  }

  void controllerListener() {
    if (controller.position.atEdge) {
      bool isTop = controller.position.pixels == 0;
      if (!isTop) {
        _loadNextItems();
      }
    }
  }

  Future<int> addNewItem() async {
    if (lastCheckedItemIndex >= pokemonApiResourceList.length) return -1;
    int nextItem = lastCheckedItemIndex;
    while (true) {
      nextItem++;
      if (nextItem >= pokemonApiResourceList.length) return -1;
      PokemonApiResource apiResource = pokemonApiResourceList[nextItem];
      Either<Error, Pokemon> pokemonResult = await PokeApi.getPokemon(apiResource);
      if (pokemonResult.isLeft) return -1;
      bool canShowPokemon = await onCanShowPokemon(pokemonResult.right);
      if (canShowPokemon) {
        lastCheckedItemIndex = nextItem;
        setState(() {
          Pokemon pokemon = pokemonResult.right;
          pokemonList[pokemon.id] = pokemon;
        });
        break;
      }
    }
    return lastCheckedItemIndex;
  }

  Future<bool> onCanShowPokemon(Pokemon pokemon) async {
    return await onCanShowPokemonByName(pokemon) && await onCanShowPokemonByType(pokemon);
  }

  Future<bool> onCanShowPokemonByName(Pokemon pokemon) async {
    if (widget.searchTextEditingController.text.isEmpty) return true;
    if (pokemon.name.toLowerCase().startsWith(widget.searchTextEditingController.text.toLowerCase())) return true;
    if (pokemon.id.toString().startsWith(widget.searchTextEditingController.text.toLowerCase())) return true;
    return false;
  }

  Future<bool> onCanShowPokemonByType(Pokemon pokemon) async {
    if (widget.selectedPokeType.value == null) return true;
    if (widget.selectedPokeType.value?.name == "any") return true;
    Either<Error, List<Type>> result = await pokemon.fetchTypes();
    if (result.isLeft) return false;
    List<Type> types = result.right;
    return types.any((element) => element.name == widget.selectedPokeType.value!.name);
  }
}

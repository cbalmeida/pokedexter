import 'package:flutter/material.dart';
import 'package:pokeapi_wrapper/pokeapi_wrapper.dart';
import 'package:pokedexter/utils/extensions/context_extension.dart';
import 'package:pokedexter/utils/extensions/string_extension.dart';

import '../../../utils/values/poke_type_values.dart';
import '../pokemon_info_page_tab.dart';

class PokemonInfoPageTabMoves extends PokemonInfoPageTab {
  final List<PokeType> pokeTypes;
  const PokemonInfoPageTabMoves({super.key, required super.pokemon, required this.pokeTypes});

  @override
  State<PokemonInfoPageTabMoves> createState() => _PokemonInfoPageTabMovesState();

  @override
  Tab get tab => const Tab(child: Text("Moves", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)));
}

class _PokemonInfoPageTabMovesState extends State<PokemonInfoPageTabMoves> {
  Pokemon get pokemon => widget.pokemon;
  List<PokeType> get pokeTypes => widget.pokeTypes;
  PokeType? get mainPokeType => pokeTypes.firstOrNull;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: pokemon.moves.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          PokemonMove pokemonMove = pokemon.moves[index];
          return _MoveCard(pokemonMove: pokemonMove);
        },
      ),
    );
  }
}

class _MoveCard extends StatefulWidget {
  final PokemonMove pokemonMove;
  const _MoveCard({super.key, required this.pokemonMove});

  @override
  State<_MoveCard> createState() => _MoveCardState();
}

class _MoveCardState extends State<_MoveCard> {
  Move? move;
  Type? type;

  PokeType get pokeType => PokeTypes.get(type?.name ?? "");

  _fetchMove() {
    widget.pokemonMove.move.then((value) {
      if (mounted) {
        setState(() {
          if (value.isRight) {
            move = value.right;
            _fetchType();
          }
        });
      }
    });
  }

  _fetchType() {
    move?.type.then((value) {
      if (mounted) {
        setState(() {
          if (value.isRight) type = value.right;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _fetchMove();
    });
  }

  @override
  Widget build(BuildContext context) {
    if ((move == null) || (type == null)) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 1, vertical: 0.5),
        child: ListTile(
          leading: SizedBox(height: 16, width: 16, child: CircularProgressIndicator()),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 0.5),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(color: pokeType.color, shape: BoxShape.circle),
          child: Padding(padding: const EdgeInsets.all(4.0), child: Icon(pokeType.icon, color: Colors.white, size: 14)),
        ),
        title: Text(move?.name.capitalizeFirstLetter ?? "", style: context.textTheme.labelLarge?.copyWith(color: Colors.white)),
        subtitle: Wrap(
          spacing: 8,
          children: [
            Text("Power: ${move?.power}" ?? "", style: context.textTheme.bodyMedium?.copyWith(color: Colors.white)),
            Text("PP: ${move?.pp}" ?? "", style: context.textTheme.bodyMedium?.copyWith(color: Colors.white)),
            Text("Accuracy: ${move?.accuracy}%" ?? "", style: context.textTheme.bodyMedium?.copyWith(color: Colors.white)),
            Text("Eff.Chance: ${move?.effectChance}%" ?? "", style: context.textTheme.bodyMedium?.copyWith(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

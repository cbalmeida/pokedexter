import 'package:flutter/material.dart';
import 'package:pokeapi_wrapper/pokeapi_wrapper.dart';
import 'package:pokedexter/utils/extensions/string_extension.dart';

import '../../../utils/values/poke_type_values.dart';
import '../../../widgets/label_value_progress_widget.dart';
import '../pokemon_info_page_tab.dart';

class PokemonInfoPageTabStats extends PokemonInfoPageTab {
  final List<PokeType> pokeTypes;
  const PokemonInfoPageTabStats({super.key, required super.pokemon, required this.pokeTypes});

  @override
  State<PokemonInfoPageTabStats> createState() => _PokemonInfoPageTabStatsState();

  @override
  Tab get tab => const Tab(child: Text("Stats", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)));
}

class _PokemonInfoPageTabStatsState extends State<PokemonInfoPageTabStats> {
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
        itemCount: pokemon.stats.length + 1,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          if (index < pokemon.stats.length) {
            final PokemonStat pokemonStat = pokemon.stats[index];
            return FutureBuilder<Either<Error, Stat>>(
                future: pokemonStat.stat,
                builder: (context, data) {
                  if (data.hasError) return const SizedBox.shrink();
                  if (!data.hasData) return const SizedBox.shrink();
                  if (data.data!.isLeft) return const SizedBox.shrink();
                  Stat stat = data.data!.right;
                  double progress = pokemonStat.baseStat.toDouble();
                  return SizedBox(height: 48, child: LabelValueProgressWidget(label: stat.name.capitalizeFirstLetter, value: pokemonStat.baseStat, progress: progress));
                });
          } else {
            int totalStat = pokemon.stats.fold(0, (previousValue, element) => previousValue + element.baseStat);
            double totalProgress = (totalStat / (pokemon.stats.length * 100)) * 100;
            return SizedBox(height: 48, child: LabelValueProgressWidget(label: "Total", value: totalStat, progress: totalProgress));
          }
        },
      ),
    );
  }
}

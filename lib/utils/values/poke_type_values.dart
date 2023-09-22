import 'package:flutter/material.dart';

import '../icons/poke_icons.dart';

class PokeTypes {
  PokeTypes._();

  static PokeType any = const PokeType(name: "any", color: Colors.black, colorCard: Colors.black, icon: Icons.clear_all_sharp);
  static PokeType grass = PokeType(name: "grass", color: Colors.green, colorCard: Colors.green[300]!, icon: PokeIcons.grass);
  static PokeType poison = PokeType(name: "poison", color: Colors.purple, colorCard: Colors.purple[300]!, icon: PokeIcons.poison);
  static PokeType fire = PokeType(name: "fire", color: Colors.red, colorCard: Colors.red[300]!, icon: PokeIcons.fire);
  static PokeType flying = PokeType(name: "flying", color: Colors.teal, colorCard: Colors.teal[300]!, icon: PokeIcons.flying);
  static PokeType water = PokeType(name: "water", color: Colors.blue, colorCard: Colors.blue[300]!, icon: PokeIcons.water);
  static PokeType normal = PokeType(name: "normal", color: Colors.blueGrey, colorCard: Colors.blueGrey[300]!, icon: PokeIcons.normal);
  static PokeType electric = PokeType(name: "electric", color: Colors.orange, colorCard: Colors.orange[300]!, icon: PokeIcons.electric);
  static PokeType ground = PokeType(name: "ground", color: Colors.brown, colorCard: Colors.brown[300]!, icon: PokeIcons.ground);
  static PokeType fairy = PokeType(name: "fairy", color: Colors.pink, colorCard: Colors.pink[300]!, icon: PokeIcons.fairy);
  static PokeType bug = PokeType(name: "bug", color: Colors.deepPurple, colorCard: Colors.deepPurple[300]!, icon: PokeIcons.bug);
  static PokeType fighting = PokeType(name: "fighting", color: Colors.deepOrange, colorCard: Colors.deepOrange[300]!, icon: PokeIcons.fighting);
  static PokeType psychic = PokeType(name: "psychic", color: Colors.grey[700]!, colorCard: Colors.grey, icon: PokeIcons.psychic);
  static PokeType rock = PokeType(name: "rock", color: Colors.grey[800]!, colorCard: Colors.grey[600]!, icon: PokeIcons.rock);
  static PokeType steel = PokeType(name: "steel", color: Colors.blueGrey[800]!, colorCard: Colors.blueGrey[600]!, icon: PokeIcons.steel);
  static PokeType ice = PokeType(name: "ice", color: Colors.lightBlue, colorCard: Colors.lightBlue[300]!, icon: PokeIcons.ice);
  static PokeType ghost = PokeType(name: "ghost", color: Colors.indigo, colorCard: Colors.indigo[300]!, icon: PokeIcons.ghost);
  static PokeType dark = const PokeType(name: "dark", color: Colors.black, colorCard: Colors.black38, icon: PokeIcons.dark);
  static PokeType dragon = PokeType(name: "dragon", color: Colors.orange, colorCard: Colors.orange[300]!, icon: PokeIcons.dragon);

  static final Map<String, PokeType> _types = {
    "any": any,
    "grass": grass,
    "poison": poison,
    "fire": fire,
    "flying": flying,
    "water": water,
    "normal": normal,
    "electric": electric,
    "ground": ground,
    "fairy": fairy,
    "bug": bug,
    "fighting": fighting,
    "psychic": psychic,
    "rock": rock,
    "steel": steel,
    "ice": ice,
    "ghost": ghost,
    "dark": dark,
    "dragon": dragon,
  };

  static List<PokeType> get types => _types.values.toList();
  static PokeType get(String name) {
    return _types[name] ?? grass;
  }
}

class PokeType {
  final String name;
  final Color color;
  final Color colorCard;
  final IconData icon;

  const PokeType({required this.name, required this.color, required this.colorCard, required this.icon});
}

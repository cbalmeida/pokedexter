import 'package:example/utils/extensions/context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../icons/poke_icons.dart';

class Messages {
  final BuildContext context;
  Messages._(this.context);

  factory Messages.of(BuildContext context) {
    return Messages._(context);
  }

  void showError(String message) => _showMessage(message, Colors.red);

  void showMessage(String message) => _showMessage(message, Colors.green);

  void addedToFavorites(String pokemonName) => _favoriteSnack(true, pokemonName);

  void removedFromFavorites(String pokemonName) => _favoriteSnack(false, pokemonName);

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, style: context.textTheme.titleLarge!.copyWith(color: Colors.white)),
      backgroundColor: color,
    ));
  }

  void _favoriteSnack(bool isAdd, String pokemonName) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 700),
        width: MediaQuery.sizeOf(context).width,
        clipBehavior: Clip.hardEdge,
        content: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(color: Color.fromRGBO(50, 50, 93, 0.25), blurRadius: 15, spreadRadius: -5, offset: Offset(-2, 5)),
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.3), blurRadius: 16, spreadRadius: -8, offset: Offset(0, 5)),
            ],
            color: Colors.white,
            border: Border.all(color: const Color(0xffFFD600), width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isAdd ? Icon(PokeIcons.heartFilled, color: context.primaryColor) : const Icon(PokeIcons.heart, color: Colors.black),
                const SizedBox(width: 10),
                SizedBox(width: MediaQuery.sizeOf(context).width - 90, child: Text(isAdd ? "$pokemonName was added to Favorites" : "$pokemonName was removed from Favorites", style: context.textTheme.titleLarge)),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0));
  }

  void showOKDialog({
    required String title,
    required String message,
  }) {
    showAdaptiveDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog.adaptive(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          _adaptiveAction(context: context, onPressed: () => Navigator.pop(context, 'OK'), child: const Text('OK')),
        ],
      ),
    );
  }

  Widget _adaptiveAction({required BuildContext context, required VoidCallback onPressed, required Widget child}) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextButton(onPressed: onPressed, child: child);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
    }
  }
}

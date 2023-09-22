import 'package:example/utils/extensions/context_extension.dart';
import 'package:example/utils/extensions/int_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokeapi/flutter_pokeapi.dart';

import '../../utils/assets/assets.dart';
import '../../utils/messages/messages.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: context.primaryColor),
            child: Center(child: Image.asset(Assets.pokeApiDemo, fit: BoxFit.cover)),
          ),
          const HomePageDrawerItemClearCache(),
        ],
      ),
    );
  }
}

class HomePageDrawerItemClearCache extends StatefulWidget {
  const HomePageDrawerItemClearCache({super.key});

  @override
  State<HomePageDrawerItemClearCache> createState() => _HomePageDrawerItemClearCacheState();
}

class _HomePageDrawerItemClearCacheState extends State<HomePageDrawerItemClearCache> {
  String currentMessage = 'Click to clear cache';
  int cacheSize = 0;

  @override
  void initState() {
    super.initState();
    PokeApi.cacheSize.then((value) => setState(() => cacheSize = value));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: PokeApi.clearCacheProgressNotifier,
        builder: (context, child) {
          final currentProgress = PokeApi.clearCacheProgressNotifier.value.progress;
          return ListTile(
            leading: const Icon(Icons.delete_forever_outlined),
            title: Text('Clear Cache (${cacheSize.asBytes})'),
            subtitle: currentProgress > 0 ? LinearProgressIndicator(value: currentProgress / 100) : Text(currentMessage),
            onTap: () {
              PokeApi.clearCache().then((value) {
                PokeApi.cacheSize.then((value) => setState(() => cacheSize = value));
                Messages.of(context).showOKDialog(title: "Clear Cache", message: 'Cache cleared successfully!');
              });
            },
          );
        });
  }
}

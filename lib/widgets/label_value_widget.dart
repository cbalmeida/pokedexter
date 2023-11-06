import 'package:flutter/material.dart';
import 'package:pokeapi_wrapper/pokeapi_wrapper.dart';
import 'package:pokedexter/utils/extensions/context_extension.dart';

class LabelValueWidget extends StatelessWidget {
  final String label;
  final String value;
  final int flexLabel;
  final int flexValue;
  const LabelValueWidget({super.key, required this.label, required this.value, this.flexLabel = 1, this.flexValue = 2});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: flexLabel, child: Text(label, style: context.textTheme.labelLarge!.copyWith(color: Colors.white70))),
        Expanded(flex: flexValue, child: Text(value, style: context.textTheme.titleLarge!.copyWith(color: Colors.white))),
      ],
    );
  }
}

class LabelFutureValueWidget<T> extends StatelessWidget {
  final String label;
  final Future<Either<Error, T>> futureValue;
  final int flexLabel;
  final int flexValue;
  final String Function(T value) valueToString;
  const LabelFutureValueWidget({super.key, required this.label, this.flexLabel = 1, this.flexValue = 2, required this.futureValue, required this.valueToString});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: flexLabel, child: Text(label, style: context.textTheme.labelLarge!.copyWith(color: Colors.white70))),
        Expanded(
            flex: flexValue,
            child: FutureBuilder<Either<Error, T>>(
                future: futureValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) return const SizedBox();
                  if (snapshot.data == null) return const SizedBox();
                  if (snapshot.hasError) return Text(snapshot.error.toString(), style: context.textTheme.titleLarge!.copyWith(color: Colors.white));
                  if (snapshot.data?.isLeft ?? false) return Text(snapshot.error.toString(), style: context.textTheme.titleLarge!.copyWith(color: Colors.white));
                  return Text(valueToString(snapshot.data!.right), style: context.textTheme.titleLarge!.copyWith(color: Colors.white));
                })),
      ],
    );
  }
}

import 'package:example/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class LabelValueProgressWidget extends StatelessWidget {
  final String label;
  final int value;
  final double progress;
  const LabelValueProgressWidget({super.key, required this.label, required this.value, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: Text(label, style: context.textTheme.labelLarge!.copyWith(color: Colors.white70))),
        Expanded(flex: 1, child: Text(value.toString(), style: context.textTheme.titleLarge!.copyWith(color: Colors.white), textAlign: TextAlign.right)),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(4),
              color: progress < 80 ? context.primaryColor : const Color(0xff0804B4),
              backgroundColor: context.secondaryBgColor,
              value: progress / 100,
            ),
          ),
        )
      ],
    );
  }
}

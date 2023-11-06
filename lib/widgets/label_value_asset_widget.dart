import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedexter/utils/extensions/context_extension.dart';

class LabelValueAssetWidget extends StatelessWidget {
  final String label;
  final String value;
  final String? asset;
  const LabelValueAssetWidget({super.key, required this.label, required this.value, this.asset});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.textTheme.labelLarge!.copyWith(color: Colors.white70)),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            asset != null ? SizedBox(height: 14, child: SvgPicture.asset(asset!, color: Colors.white)) : const SizedBox.shrink(),
            SizedBox(child: Text(value, style: context.textTheme.titleLarge!.copyWith(color: Colors.white))),
          ],
        )
      ],
    );
  }
}

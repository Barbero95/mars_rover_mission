import 'package:flutter/material.dart';

class CustomInfoWidget extends StatelessWidget {
  final String text;

  const CustomInfoWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      visualDensity: VisualDensity.compact,
      leading: const Icon(Icons.info_outline),
      title: Text(text),
    );
  }
}

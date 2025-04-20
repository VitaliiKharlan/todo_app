import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:todo_app/ui/ui.dart';

class SettingsToggleCard extends StatelessWidget {
  const SettingsToggleCard({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 24,
      ),
      child: BaseContainer(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 8,
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium,
            ),
            CupertinoSwitch(
              value: value,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

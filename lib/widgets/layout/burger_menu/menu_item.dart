import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(
        icon,
        size: 24,
        color: theme.colorScheme.onSurface,
      ),
      title: Text(
        title,
        style: theme.textTheme.titleSmall!.copyWith(
          color: theme.colorScheme.onSurface,
          fontSize: 24,
        ),
      ),
      onTap: onTap,
    );
  }
}

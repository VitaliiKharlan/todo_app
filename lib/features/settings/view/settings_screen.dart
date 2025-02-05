import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:todo_app/features/settings/widgets/widgets.dart';
import 'package:todo_app/ui/ui.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            title: Center(
              child: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(
            child: SettingsToggleCard(
              title: 'Dark Theme',
              value: true,
              onChanged: (value) {},
            ),
          ),
          SliverToBoxAdapter(
            child: SettingsToggleCard(
              title: 'Notifications',
              value: true,
              onChanged: (value) {},
            ),
          ),
          SliverToBoxAdapter(
            child: SettingsToggleCard(
              title: 'Analytics',
              value: true,
              onChanged: (value) {},
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 48),
          ),
          SliverToBoxAdapter(
            child: SettingsActionCard(
              title: 'Clear History',
              onTap: () {},
              iconData: Icons.delete,
              iconColor: Theme.of(context).primaryColor,
            ),
          ),
          SliverToBoxAdapter(
            child: SettingsActionCard(
              title: 'Support',
              onTap: () {},
              iconData: Icons.message,
            ),
          ),
        ],
      ),
    );
  }
}


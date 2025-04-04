import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/bloc/theme/theme_cubit.dart';

class MenuButtonWidget extends StatelessWidget {
  const MenuButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final brightnessValue = context.read<ThemeCubit>();
    final brightnessValueIsLight = brightnessValue.state.isLight;

    return IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
          if (renderBox == null) {
            return;
          }
          final size = renderBox.size;
          final position = renderBox
              .localToGlobal(Offset.zero);

          final RelativeRect positionForMenu = RelativeRect.fromLTRB(
            position.dx + 20,
            position.dy + kToolbarHeight,
            position.dx + size.width,
            position.dy + size.height,
          );

          showMenu(
            context: context,
            position: positionForMenu,
            items: [
              PopupMenuItem<String>(
                value: 'Change app color',
                child: Row(
                  children: [
                    Icon(Icons.color_lens, size: 20),
                    SizedBox(width: 8),
                    Text('Change app color'),
                  ],
                ),
                onTap: () {
                  _setThemeBrightness(
                    brightnessValue,
                    brightnessValueIsLight,
                  );
                },
              ),
              PopupMenuItem<String>(
                value: 'Change app typography',
                child: Row(
                  children: [
                    Icon(Icons.text_fields, size: 20),
                    SizedBox(width: 8),
                    Text('Change app typography'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'Change app language',
                child: Row(
                  children: [
                    Icon(Icons.language, size: 20),
                    SizedBox(width: 8),
                    Text('Change app language'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'Select sorting priorities',
                onTap: () {
                  _showSortingSubMenu(context);
                },
                child: Row(
                  children: const [
                    Icon(Icons.sort, size: 20),
                    SizedBox(width: 8),
                    Text('Select sorting priorities'),
                  ],
                ),
              ),
            ],
            elevation: 8.0,
          ).then((value) {
            if (value != null) {
              debugPrint('Selected: $value');
            }
          });
        });
      },
    );
  }

  void _setThemeBrightness(
      ThemeCubit brightnessValue, bool brightnessValueIsLight) {
    brightnessValue.setThemeBrightness(
        brightnessValueIsLight ? Brightness.dark : Brightness.light);
  }

  void _showSortingSubMenu(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);

    final RelativeRect positionForSubMenu = RelativeRect.fromLTRB(
      position.dx + 40,
      position.dy + kToolbarHeight,
      position.dx + size.width,
      position.dy + size.height,
    );

    showMenu(
      context: context,
      position: positionForSubMenu,
      items: [
        PopupMenuItem<String>(
          value: 'Priority: High to Low',
          child: Row(
            children: [
              Icon(Icons.arrow_downward, size: 20),
              SizedBox(width: 8),
              Text('Priority: High to Low'),
            ],
          ),
          onTap: () {
            // Sort tasks: High to Low
            debugPrint("Sorting: High to Low");
            context.router.maybePop();
          },
        ),
        PopupMenuItem<String>(
          value: 'Priority: Low to High',
          child: Row(
            children: [
              Icon(Icons.arrow_upward, size: 20),
              SizedBox(width: 8),
              Text('Priority: Low to High'),
            ],
          ),
          onTap: () {
            // Sort tasks: Low to High
            debugPrint("Sorting: Low to High");
            context.router.maybePop();
          },
        ),
        PopupMenuItem<String>(
          value: 'Sort by Due Date',
          child: Row(
            children: [
              Icon(Icons.date_range, size: 20),
              SizedBox(width: 8),
              Text('Sort by Due Date'),
            ],
          ),
          onTap: () {
            // Sort tasks by due date
            debugPrint("Sorting by Due Date");
            context.router.maybePop();
          },
        ),
      ],
      elevation: 8.0,
    );
  }
}

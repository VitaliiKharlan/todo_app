import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/bloc/theme/theme_cubit.dart';
import 'package:todo_app/features/create_new_task/bloc/entities/priorities_entity.dart';
import 'package:todo_app/features/create_new_task/bloc/tasks_bloc.dart';

class MenuButtonWidget extends StatelessWidget {
  const MenuButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          final position = renderBox.localToGlobal(Offset.zero);

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
                    Text(
                      'Change app color',
                      style: theme.textTheme.labelMedium,
                    ),
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
                    Text(
                      'Change app typography',
                      style: theme.textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'Change app language',
                child: Row(
                  children: [
                    Icon(Icons.language, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Change app language',
                      style: theme.textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'Select sorting priorities',
                onTap: () {
                  _showSortingSubMenu(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.sort, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Select sorting priorities',
                      style: theme.textTheme.labelMedium,
                    ),
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

  void printTextStyle(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelMedium;

    debugPrint('Font size: ${textStyle?.fontSize}');
    debugPrint('Font weight: ${textStyle?.fontWeight}');
    debugPrint('Font style: ${textStyle?.fontStyle}');
    debugPrint('Color: ${textStyle?.color}');
    debugPrint('Letter spacing: ${textStyle?.letterSpacing}');
    debugPrint('Height: ${textStyle?.height}');
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
        _buildSortingMenuItem(
          context,
          'Priority: High to Low',
          SortingOption.priorityHighToLow,
          Icons.arrow_downward,
        ),
        _buildSortingMenuItem(
          context,
          'Priority: Low to High',
          SortingOption.priorityLowToHigh,
          Icons.arrow_upward,
        ),
        _buildSortingMenuItem(
          context,
          'Sort by Last to First',
          SortingOption.createAtLastToFirst,
          Icons.date_range,
        ),
        _buildSortingMenuItem(
          context,
          'Sort by First to Last',
          SortingOption.createAtFirstToLast,
          Icons.date_range,
        ),
      ],
      elevation: 8.0,
    );
  }

  PopupMenuItem<String> _buildSortingMenuItem(
      BuildContext context, String label, SortingOption option, IconData icon) {
    final theme = Theme.of(context);
    return PopupMenuItem<String>(
      value: label,
      child: Row(
        children: [
          Icon(icon, size: 20),
          SizedBox(width: 8),
          Text(
            label,
            style: theme.textTheme.labelMedium,
          ),
        ],
      ),
      onTap: () {
        debugPrint("Sorting: $label");
        printTextStyle(context);
        context.read<TasksBloc>().add(SortTasksEvent(option));
        context.router.maybePop();
      },
    );
  }
}

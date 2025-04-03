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
          if (renderBox == null)
            return; // If the render box is still null, we do nothing.

          final size = renderBox.size; // Получаем размеры виджета
          final position = renderBox
              .localToGlobal(Offset.zero); // Получаем глобальную позицию

          final RelativeRect positionForMenu = RelativeRect.fromLTRB(
            position.dx + 20, // X позиция
            position.dy + kToolbarHeight, // Y позиция (под AppBar)
            position.dx + size.width, // Правый отступ
            position.dy + size.height, // Нижний отступ
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
                  _setThemeBrightness(brightnessValue, brightnessValueIsLight);
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
                child: Row(
                  children: [
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
}

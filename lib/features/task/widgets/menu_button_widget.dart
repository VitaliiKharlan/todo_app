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
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(0, 20, 0, 0),
          items: [
            PopupMenuItem<String>(
              value: 'Change app color',
              child: Text('Change app color'),
              onTap: () {
                _setThemeBrightness(brightnessValue, brightnessValueIsLight);
              },
            ),
            PopupMenuItem<String>(
              value: 'Change app typography',
              child: Text('Change app typography'),
            ),
            PopupMenuItem<String>(
              value: 'Change app language',
              child: Text('Change app language'),
            ),
            PopupMenuItem<String>(
              value: 'Select sorting priorities',
              child: Text('Select sorting priorities'),
            ),
          ],
          elevation: 8.0,
        ).then((value) {
          if (value != null) {
            debugPrint('Selected: $value');
          }
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



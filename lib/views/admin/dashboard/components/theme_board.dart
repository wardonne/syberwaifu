import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/titled_card.dart';
import 'package:syberwaifu/constants/theme.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';

class ThemeBoard extends StatelessWidget {
  const ThemeBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeVM>(
      builder: (context, theme, child) {
        final colorPicker = BlockPicker(
          pickerColor: Theme.of(context).colorScheme.primary,
          availableColors: ThemeConstants.materialColors.values.toList(),
          useInShowDialog: false,
          onColorChanged: (value) {
            theme.color = value as MaterialColor;
          },
        );
        final darkModeIcon = theme.darkMode
            ? const Icon(
                Icons.brightness_6,
                color: Colors.white54,
              )
            : const Icon(Icons.brightness_2, color: Colors.black54);
        return TitledCard(
          labelText: S.of(context).cardTitleThemeConfig,
          actions: [
            IconButton(
              onPressed: () {
                theme.switchDarkMode();
              },
              icon: darkModeIcon,
              splashRadius: 20,
            )
          ],
          child: colorPicker,
        );
      },
    );
  }
}

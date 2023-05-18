import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/buttons/custom_icon_button.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/models/preset/preset_model.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';

class EditButton extends StatelessWidget {
  final PresetModel preset;
  const EditButton({super.key, required this.preset});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeVM>(builder: (context, theme, child) {
      return CustomIconButton(
        icon: Icons.edit,
        iconSize: 20,
        buttonHeight: 24,
        buttonWidth: 24,
        borderRadius: BorderRadius.circular(12),
        hoverColor: Theme.of(context).colorScheme.primary,
        hoverIconColor: theme.forecolor,
        tooltip: S.of(context).btnEdit,
        onPressed: () async {
          await Navigator.pushNamed(
            context,
            RouterSettings.presetUpdate,
            arguments: preset,
          );
        },
      );
    });
  }
}

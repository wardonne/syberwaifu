import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/buttons/custom_icon_button.dart';
import 'package:syberwaifu/functions/open_dialog.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/models/avatar.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';

class ViewButton extends StatelessWidget {
  final AvatarModel avatar;
  const ViewButton({super.key, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeVM>(
      builder: (context, theme, child) {
        return CustomIconButton(
          icon: Icons.search,
          iconSize: 20,
          buttonHeight: 24,
          buttonWidth: 24,
          borderRadius: BorderRadius.circular(12),
          hoverColor: Theme.of(context).colorScheme.primary,
          hoverIconColor: theme.forecolor,
          tooltip: S.of(context).btnView,
          onPressed: () {
            openImageView(context, imageSrc: avatar.uri!);
          },
        );
      },
    );
  }
}

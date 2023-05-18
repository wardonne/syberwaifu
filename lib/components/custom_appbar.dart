import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/buttons/close_window_button.dart';
import 'package:syberwaifu/components/buttons/maximize_window_button.dart';
import 'package:syberwaifu/components/buttons/minimize_window_button.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';
import 'package:window_manager/window_manager.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? leadings;
  final List<Widget>? floatingLeadings;
  final List<Widget>? actions;
  const CustomAppBar(
    this.title, {
    super.key,
    this.leadings,
    this.floatingLeadings,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  State<StatefulWidget> createState() {
    return CustomAppBarState();
  }
}

class CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final themeVM = Provider.of<ThemeVM>(context);
    return DragToMoveArea(
      child: Container(
        decoration: BoxDecoration(
          color: themeVM.darkMode
              ? Theme.of(context).primaryColorDark
              : Theme.of(context).primaryColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.of(context).primaryColor,
              offset: const Offset(0.0, 0.0),
              blurRadius: 5,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            if ((widget.leadings ?? []).isNotEmpty)
              Column(children: [
                Row(children: widget.leadings!),
              ]),
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      widget.title,
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: themeVM.forecolor,
                      ),
                    ),
                  ),
                  if (widget.floatingLeadings?.isNotEmpty ?? false)
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: Row(
                        children: widget.floatingLeadings!,
                      ),
                    ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: Row(
                      children: [
                        if ((widget.actions ?? []).isNotEmpty)
                          ...widget.actions!,
                        const MinimizeWindowButton(),
                        const MaximizeWindowButton(),
                        const CloseWindowButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

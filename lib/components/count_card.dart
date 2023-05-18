import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/loading.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';

class CountCard extends StatefulWidget {
  final bool loading;
  final Widget icon;
  final String title;
  final String content;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? hoverBackgroundColor;
  final Color? iconBackgroundColor;
  final Color? hoverIconBackgroundColor;
  final void Function()? onTap;
  const CountCard({
    super.key,
    this.loading = false,
    required this.icon,
    required this.title,
    required this.content,
    this.tooltip,
    this.backgroundColor,
    this.hoverBackgroundColor,
    this.iconBackgroundColor,
    this.hoverIconBackgroundColor,
    this.onTap,
  });

  @override
  State<StatefulWidget> createState() {
    return CountCardState();
  }
}

class CountCardState extends State<CountCard> {
  bool _isHover = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeVM>(
      builder: (context, theme, child) {
        final themeData = Theme.of(context);
        final textStyle =
            TextStyle(color: theme.darkMode ? null : theme.forecolor);
        final backgrondColor = widget.backgroundColor ??
            (theme.darkMode
                ? themeData.colorScheme.background
                : themeData.colorScheme.primary);
        final hoverBackgroundColor =
            widget.hoverBackgroundColor ?? themeData.hoverColor;
        final iconBackgroundColor =
            widget.iconBackgroundColor ?? Colors.transparent;
        final hoverIconBackgroundColor =
            widget.hoverIconBackgroundColor ?? Colors.transparent;
        final card = MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (event) => setState(() {
            _isHover = true;
          }),
          onExit: (event) => setState(() {
            _isHover = false;
          }),
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: _isHover ? hoverBackgroundColor : backgrondColor,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [BoxShadow(color: themeData.primaryColor)],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    alignment: Alignment.centerRight,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: _isHover
                          ? hoverIconBackgroundColor
                          : iconBackgroundColor,
                      child: widget.icon,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Divider(
                          height: 20,
                          color: Colors.transparent,
                        ),
                        Center(
                            child: widget.loading
                                ? const Loading()
                                : Text(
                                    widget.content,
                                    textScaleFactor: 2.0,
                                    style: textStyle.copyWith(
                                        fontWeight: FontWeight.bold),
                                  )),
                        const Divider(
                          height: 10,
                          color: Colors.transparent,
                        ),
                        Center(
                            child: Text(
                          widget.title,
                          textScaleFactor: 1.2,
                          style: textStyle,
                        )),
                        const Divider(
                          height: 20,
                          color: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ),
          ),
        );
        return widget.tooltip == null
            ? card
            : Tooltip(
                verticalOffset: 80,
                message: widget.tooltip,
                child: card,
              );
      },
    );
  }
}

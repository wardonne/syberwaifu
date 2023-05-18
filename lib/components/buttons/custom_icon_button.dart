import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;
  final Color? hoverIconColor;
  final BorderRadius? borderRadius;
  final Color? color;
  final Color? hoverColor;
  final Function()? onPressed;
  final String? tooltip;
  final double? buttonWidth;
  final double? buttonHeight;
  const CustomIconButton({
    super.key,
    required this.icon,
    this.iconSize,
    this.iconColor,
    this.hoverIconColor,
    this.borderRadius,
    this.color,
    this.hoverColor,
    this.onPressed,
    this.tooltip,
    this.buttonHeight,
    this.buttonWidth,
  });

  @override
  State<StatefulWidget> createState() {
    return CustomIconButtonState();
  }
}

class CustomIconButtonState extends State<CustomIconButton> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      widget.icon,
      color: _isHover ? widget.hoverIconColor : widget.iconColor,
      size: widget.iconSize,
    );
    final btn = InkWell(
      borderRadius: widget.borderRadius,
      hoverColor: widget.hoverColor,
      onTap: widget.onPressed,
      onHover: (value) {
        setState(() {
          _isHover = value;
        });
      },
      child: Container(
        width: widget.buttonWidth,
        height: widget.buttonHeight,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          color: _isHover ? Colors.transparent : widget.color,
        ),
        child: icon,
      ),
    );
    return widget.tooltip != null
        ? Tooltip(
            message: widget.tooltip,
            child: btn,
          )
        : btn;
  }
}

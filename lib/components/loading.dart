import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';

class Loading extends StatelessWidget {
  final Color? color;
  final double? size;
  const Loading({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeVM>(context);
    return LoadingAnimationWidget.staggeredDotsWave(
        color: color ?? theme.forecolor, size: size ?? 30);
  }
}

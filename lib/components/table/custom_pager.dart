import 'package:flutter/material.dart';
import 'package:pager/pager.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/constants/application.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';

class CustomPager extends StatelessWidget {
  final int totalPages;
  final int currentPage;
  final Function(int page) onPageChanged;
  const CustomPager({
    super.key,
    required this.totalPages,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: ApplicationConstants.pagerHeight,
      child: Pager(
        totalPages: totalPages,
        onPageChanged: onPageChanged,
        currentPage: currentPage,
        pagesView: 5,
        numberTextUnselectedColor: Provider.of<ThemeVM>(context).darkMode
            ? Colors.white
            : Colors.black,
        numberButtonSelectedColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

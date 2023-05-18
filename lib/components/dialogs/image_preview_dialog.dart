import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:syberwaifu/components/dialogs/content_dialog.dart';
import 'package:syberwaifu/functions/image.dart';
import 'package:syberwaifu/generated/l10n.dart';

class ImageViewDialog extends StatelessWidget {
  final String filePath;
  const ImageViewDialog({
    super.key,
    required this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(S.of(context).dialogTitleViewImage),
      titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      contentPadding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: ClipRect(
              child: ExtendedImage.file(
                File(getUri(filePath)),
                fit: BoxFit.contain,
                mode: ExtendedImageMode.gesture,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as image_lib;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syberwaifu/components/custom_divider.dart';
import 'package:syberwaifu/components/dialogs/content_dialog.dart';
import 'package:syberwaifu/enums/divider_direction.dart';
import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/generated/l10n.dart';

class ImageEditorDialog extends StatelessWidget {
  final String filePath;
  final GlobalKey<ExtendedImageEditorState>? editorKey;
  const ImageEditorDialog({
    super.key,
    required this.filePath,
    this.editorKey,
  });

  @override
  Widget build(BuildContext context) {
    final extendedImageEditorKey =
        editorKey ?? GlobalKey<ExtendedImageEditorState>();
    const divider = CustomDivider(
      size: 20,
      direction: DividerDirection.vertical,
    );
    return ContentDialog(
        title: Text(S.of(context).dialogTitleCropImage),
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        contentPadding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              child: ClipRect(
                child: ExtendedImage.file(
                  File(filePath),
                  fit: BoxFit.contain,
                  mode: ExtendedImageMode.editor,
                  cacheRawData: true,
                  extendedImageEditorKey: extendedImageEditorKey,
                  initEditorConfigHandler: (state) {
                    return EditorConfig(
                      initialCropAspectRatio: CropAspectRatios.ratio1_1,
                      cropAspectRatio: CropAspectRatios.ratio1_1,
                      cornerColor: Theme.of(context).colorScheme.primary,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  divider,
                  IconButton(
                    onPressed: () {
                      extendedImageEditorKey.currentState!.rotate(right: false);
                    },
                    icon: const Icon(
                      Icons.rotate_90_degrees_ccw,
                    ),
                    splashRadius: 20,
                  ),
                  divider,
                  IconButton(
                    onPressed: () {
                      extendedImageEditorKey.currentState!.rotate();
                    },
                    icon: const Icon(Icons.rotate_90_degrees_cw_outlined),
                    splashRadius: 20,
                  ),
                  divider,
                  IconButton(
                    onPressed: () {
                      extendedImageEditorKey.currentState!.flip();
                    },
                    icon: const Icon(Icons.flip),
                    splashRadius: 20,
                  ),
                  divider,
                  IconButton(
                    onPressed: () {
                      extendedImageEditorKey.currentState!.reset();
                    },
                    icon: const Icon(Icons.settings_backup_restore),
                    splashRadius: 20,
                  ),
                  divider,
                  IconButton(
                    onPressed: () async {
                      final data =
                          extendedImageEditorKey.currentState!.rawImageData;
                      final editDetail =
                          extendedImageEditorKey.currentState!.editAction;
                      image_lib.Image? src =
                          await compute<Uint8List, image_lib.Image?>(
                              image_lib.decodeImage, data);
                      if (!empty(src)) {
                        src = image_lib.bakeOrientation(src!);
                        if (editDetail?.needCrop ?? false) {
                          final cropRect = extendedImageEditorKey.currentState!
                              .getCropRect()!;
                          src = image_lib.copyCrop(
                            src,
                            x: cropRect.left.toInt(),
                            y: cropRect.top.toInt(),
                            width: cropRect.width.toInt(),
                            height: cropRect.height.toInt(),
                          );
                        }
                        if (editDetail?.needFlip ?? false) {
                          if (editDetail!.flipX && editDetail.flipY) {
                            src = image_lib.flipHorizontalVertical(src);
                          } else if (editDetail.flipY) {
                            src = image_lib.flipVertical(src);
                          } else if (editDetail.flipX) {
                            src = image_lib.flipHorizontal(src);
                          }
                        }
                        if (editDetail?.hasRotateAngle ?? false) {
                          src = image_lib.copyRotate(
                            src,
                            angle: editDetail!.rotateAngle,
                          );
                        }
                        final temporaryDirpath = await getTemporaryDirectory();
                        final avatarPath = joinAll([
                          temporaryDirpath.path,
                          'syberwaifu',
                          'avatars',
                          '${DateTime.now().millisecondsSinceEpoch}.png'
                        ]);
                        await image_lib.encodeImageFile(avatarPath, src);
                        if (context.mounted) {
                          back<String>(context, result: avatarPath);
                        }
                      }
                    },
                    icon: const Icon(Icons.send),
                    splashRadius: 20,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

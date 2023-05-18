import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:syberwaifu/components/dialogs/avatar_library_dialog.dart';
import 'package:syberwaifu/components/dialogs/confirm_dialog.dart';
import 'package:syberwaifu/components/dialogs/image_editor_dialog.dart';
import 'package:syberwaifu/components/dialogs/image_preview_dialog.dart';
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/models/avatar.dart';
import 'package:syberwaifu/models/chat/chat_message_model.dart';
import 'package:syberwaifu/view_models/chat/chat_messages_vm.dart';

Future<T?> openDialog<T>(BuildContext context,
    {Widget? icon, Widget? title, required Widget child}) {
  return Future<T?>(
    () => showDialog<T?>(
      context: context,
      builder: (context) {
        final List<Widget> leadings = [];
        leadings.add(icon ?? const Icon(Icons.edit));
        leadings
            .add(const VerticalDivider(width: 10, color: Colors.transparent));
        if (title != null) {
          leadings.add(title);
        }

        final closeBtn = GestureDetector(
          onTap: () => back(context),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Tooltip(
              message: S.of(context).btnClose,
              child: const Icon(Icons.close),
            ),
          ),
        );
        final endings = <Widget>[closeBtn];

        final header = Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black26))),
          child: Row(
            children: [
              Expanded(child: Row(children: leadings)),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: endings),
            ],
          ),
        );

        return Dialog(
          alignment: Alignment.center,
          elevation: 0,
          child: SizedBox(
            width: 600,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                header,
                SingleChildScrollView(child: child),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Future<String?> openImageEditor(BuildContext context,
    {required String imageSrc,
    GlobalKey<ExtendedImageEditorState>? editorKey}) async {
  return showDialog<String>(
    context: context,
    builder: (context) {
      return ImageEditorDialog(filePath: imageSrc, editorKey: editorKey);
    },
  );
}

Future<void> openImageView(BuildContext context,
    {required String imageSrc}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return ImageViewDialog(
        filePath: imageSrc,
      );
    },
  );
}

Future<void> openConfirmDialog(BuildContext context,
    {String? title,
    required String message,
    required void Function() onConfirmed}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return ConfirmDialog(
        title: title ?? S.of(context).dialogTitleConfirm,
        content: message,
        onConfirmed: onConfirmed,
      );
    },
  );
}

Future<AvatarModel?> openAvatarLibrary(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return const AvatarLibraryDialog();
    },
  );
}

Future<void> openErrorMessageDialog(
    BuildContext context, ChatMessageModel message, ChatMessagesVM vm) {
  return openConfirmDialog(
    context,
    message: S.of(context).confirmResendMessage,
    onConfirmed: () {
      vm.sendMessage(message, true);
      back(context);
    },
  );
}

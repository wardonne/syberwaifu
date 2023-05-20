import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/buttons/custom_elevated_button.dart';
import 'package:syberwaifu/components/chat_avatar.dart';
import 'package:syberwaifu/components/custom_divider.dart';
import 'package:syberwaifu/components/loading.dart';
import 'package:syberwaifu/enums/divider_direction.dart';
import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/functions/open_dialog.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/view_models/admin/chat/chat_detail_vm.dart';

class AvatarPicker extends StatefulWidget {
  const AvatarPicker({super.key});

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatDetailVM>(
      builder: (context, vm, child) {
        if (vm.loading) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const SizedBox(
                width: 100, height: 100, child: Center(child: Loading())),
          );
        }
        final avatar = ChatAvatar.middle(avatar: vm.avatar);
        const divider = CustomDivider(
          size: 10,
          direction: DividerDirection.vertical,
        );
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Tooltip(
                message: S.of(context).btnView,
                child: GestureDetector(
                  onTap: () => _viewAvatar(vm),
                  child: avatar,
                ),
              ),
            ),
            if (vm.editable) ...[
              divider,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomElevatedButton(
                  icon: const Icon(Icons.file_open),
                  label: Text(S.of(context).btnPickFile),
                  onPressed: () => _pickAvatar(vm),
                ),
              ),
              divider,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomElevatedButton(
                  icon: const Icon(Icons.library_add),
                  label: Text(S.of(context).btnPickAvatarLibrary),
                  onPressed: () async {
                    final avatar = await openAvatarLibrary(context);
                    if (!empty(avatar)) {
                      vm.importAvatar(avatar!);
                    }
                  },
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  _viewAvatar(ChatDetailVM vm) {
    openImageView(context, imageSrc: vm.avatar);
  }

  _pickAvatar(ChatDetailVM vm) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (result != null) {
      final filePath = result.paths.first;
      if (filePath != null && context.mounted) {
        final avatarPath = await openImageEditor(context, imageSrc: filePath);
        if (!empty<String>(avatarPath)) {
          debugPrint("avatarPath: $avatarPath");
          vm.avatar = 'file://$avatarPath';
        }
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/custom_divider.dart';
import 'package:syberwaifu/components/form/base_input.dart';
import 'package:syberwaifu/components/selects/message_role_selector.dart';
import 'package:syberwaifu/enums/divider_direction.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/models/preset/preset_message_model.dart';
import 'package:syberwaifu/validators/required.dart';
import 'package:syberwaifu/view_models/admin/preset/preset_detail_vm.dart';

class MessageInput extends StatelessWidget {
  final PresetMessageModel message;

  const MessageInput({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Consumer<PresetDetailVM>(
      builder: (context, detail, child) {
        controller.text = message.content!;
        bool roleSelectable = true;
        if (detail.messages
                .indexWhere((element) => element.uuid == message.uuid) ==
            0) {
          roleSelectable = false;
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                child: MessageRoleSelector(
                  value: message.role!,
                  onChanged: detail.editable && roleSelectable && !detail.saving
                      ? (value) {
                          message.role = value;
                          detail.updateMessage(message);
                        }
                      : null,
                ),
              ),
              const CustomDivider(
                size: 10,
                direction: DividerDirection.vertical,
              ),
              Expanded(
                child: BaseInput(
                  controller: controller,
                  maxLines: null,
                  suffix: detail.editable
                      ? TextButton.icon(
                          onPressed: detail.messages.indexWhere((element) =>
                                      element.uuid == message.uuid) ==
                                  0
                              ? null
                              : () {
                                  detail.removeMessage(message);
                                },
                          icon: const Icon(Icons.remove),
                          label: Text(S.of(context).btnRemove),
                        )
                      : null,
                  readOnly: !detail.editable || detail.saving,
                  validator: (value) => requiredValidator(
                    value,
                    S.of(context).columnNamePresetMessageContent,
                  ),
                  onSaved: (value) {
                    message.content = value ?? '';
                    detail.updateMessage(message);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

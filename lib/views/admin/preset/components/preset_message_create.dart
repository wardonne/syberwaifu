import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/custom_divider.dart';
import 'package:syberwaifu/components/selects/message_role_selector.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/models/preset/preset_message_model.dart';
import 'package:syberwaifu/validators/required.dart';
import 'package:syberwaifu/view_models/admin/preset/preset_message_create_vm.dart';

class PresetMessageCreate extends StatelessWidget {
  final String presetId;
  const PresetMessageCreate({super.key, required this.presetId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PresetMessageCreateVM(presetId),
      child: Consumer<PresetMessageCreateVM>(
        builder: (context, form, child) {
          final controller = TextEditingController(text: form.content);
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: form.content.length));
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  MessageRoleSelector(
                    value: form.role,
                    onChanged: (value) {
                      form.role = value!;
                    },
                  ),
                  const CustomDivider(size: 20),
                  TextFormField(
                    controller: controller,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: S.of(context).columnNamePresetMessageContent,
                    ),
                    onChanged: (value) {
                      form.content = value;
                    },
                    validator: (value) => requiredValidator(
                        value, S.of(context).columnNamePresetMessageContent),
                  ),
                  const CustomDivider(size: 20),
                  Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context)
                                .pop<PresetMessageModel>(form.message);
                          },
                          icon: const Icon(Icons.send),
                          label: Text(S.of(context).btnConfirm),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

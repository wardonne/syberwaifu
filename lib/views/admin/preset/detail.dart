import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/buttons/custom_back_button.dart';
import 'package:syberwaifu/components/buttons/custom_elevated_button.dart';
import 'package:syberwaifu/components/custom_appbar.dart';
import 'package:syberwaifu/components/custom_divider.dart';
import 'package:syberwaifu/components/loading.dart';
import 'package:syberwaifu/components/titled_card.dart';
import 'package:syberwaifu/enums/divider_direction.dart';
import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/functions/open_dialog.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/models/preset/preset_message_model.dart';
import 'package:syberwaifu/models/preset/preset_model.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syberwaifu/view_models/admin/preset/preset_detail_vm.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';
import 'package:syberwaifu/views/admin/preset/components/preset_form/created_time_input.dart';
import 'package:syberwaifu/views/admin/preset/components/preset_form/is_default_select.dart';
import 'package:syberwaifu/views/admin/preset/components/preset_form/name_input.dart';
import 'package:syberwaifu/views/admin/preset/components/preset_form/nickname_input.dart';
import 'package:syberwaifu/views/admin/preset/components/preset_form/updated_time_input.dart';
import 'package:syberwaifu/views/admin/preset/components/preset_message_create.dart';
import 'package:syberwaifu/views/admin/preset/components/preset_message_form/message_input.dart';

class PresetDetail extends StatefulWidget {
  final bool editable;
  const PresetDetail({super.key, this.editable = false});

  @override
  State<StatefulWidget> createState() {
    return PresetDetailState();
  }
}

class PresetDetailState extends State<PresetDetail> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final model = ModalRoute.of(context)?.settings.arguments as PresetModel?;
    final isCreate = model == null;
    return ChangeNotifierProvider(
      create: (context) => isCreate
          ? PresetDetailVM()
          : PresetDetailVM.detail(
              model,
              widget.editable,
            ),
      child: Consumer2<ThemeVM, PresetDetailVM>(
        builder: (context, theme, detail, child) {
          final title = isCreate
              ? S.of(context).pageTitlePresetCreate
              : detail.editable
                  ? S.of(context).pageTitlePresetEdit(model.name!)
                  : S.of(context).pageTitlePresetDetail(model.name!);
          return Scaffold(
            appBar: CustomAppBar(
              title,
              floatingLeadings: const [
                CustomBackButton(),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Center(
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              _basicInfoCard(detail),
                              _presetMessagesCard(detail),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (detail.editable) _buttonBar(detail)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _basicInfoCard(PresetDetailVM detail) {
    return TitledCard(
      labelText: S.of(context).cardTitleBasicInfo,
      child: Column(
        children: [
          const CustomDivider(size: 10),
          Row(
            children: const [
              Expanded(child: NameInput()),
              CustomDivider(size: 20, direction: DividerDirection.vertical),
              Expanded(child: NicknameInput()),
            ],
          ),
          const CustomDivider(size: 20),
          if (!detail.editable) ...[
            Row(
              children: const [
                Expanded(child: IsDefaultSelect()),
                CustomDivider(size: 20, direction: DividerDirection.vertical),
                Expanded(child: CreatedTimeInput()),
              ],
            ),
            const CustomDivider(size: 20),
            Row(
              children: const [
                Expanded(child: UpdatedTimeInput()),
                CustomDivider(size: 20, direction: DividerDirection.vertical),
                Expanded(child: SizedBox()),
              ],
            ),
            const CustomDivider(size: 20),
          ],
        ],
      ),
    );
  }

  Widget _presetMessagesCard(PresetDetailVM detail) {
    const loading = SizedBox(
      height: 100,
      child: Center(
        child: Loading(),
      ),
    );
    return TitledCard(
      labelText: S.of(context).cardTitlePresetMessages,
      child: detail.loadingMessages
          ? loading
          : Column(
              children: [
                ...detail.messages.map((message) {
                  return MessageInput(message: message);
                }).toList(),
                if (detail.editable)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final message =
                                await openDialog<PresetMessageModel>(
                              context,
                              child: PresetMessageCreate(
                                presetId: detail.presetId,
                              ),
                              title:
                                  Text(S.of(context).cardTitleAddPresetMessage),
                            );
                            if (!empty<PresetMessageModel>(message)) {
                              detail.addMessage(message!);
                            }
                          },
                          icon: const Icon(Icons.add),
                          label: Text(S.of(context).btnAdd),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
    );
  }

  Widget _buttonBar(PresetDetailVM detail) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).colorScheme.background,
            blurRadius: 2,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomElevatedButton(
            icon: detail.saving ? const Loading() : const Icon(Icons.send),
            label: Text(S.of(context).btnConfirm),
            onPressed: detail.saving
                ? null
                : () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      await detail.save();
                      if (context.mounted) {
                        Navigator.of(context).popAndPushNamed(
                            RouterSettings.presetDetail,
                            arguments: detail.preset);
                      }
                    }
                  },
          ),
        ],
      ),
    );
  }
}

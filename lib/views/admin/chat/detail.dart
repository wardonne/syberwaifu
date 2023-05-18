import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/buttons/custom_back_button.dart';
import 'package:syberwaifu/components/custom_appbar.dart';
import 'package:syberwaifu/components/custom_divider.dart';
import 'package:syberwaifu/components/loading.dart';
import 'package:syberwaifu/components/titled_card.dart';
import 'package:syberwaifu/enums/divider_direction.dart';
import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/models/chat/chat_model.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syberwaifu/view_models/admin/chat/chat_detail_vm.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';
import 'package:syberwaifu/views/admin/chat/components/chat_form/avatar_picker.dart';
import 'package:syberwaifu/views/admin/chat/components/chat_form/created_time_input.dart';
import 'package:syberwaifu/views/admin/chat/components/chat_form/last_chat_time_input.dart';
import 'package:syberwaifu/views/admin/chat/components/chat_form/name_input.dart';
import 'package:syberwaifu/views/admin/chat/components/chat_form/openai_token_select.dart';
import 'package:syberwaifu/views/admin/chat/components/chat_form/preset_select.dart';
import 'package:syberwaifu/views/admin/chat/components/chat_form/updated_time_input.dart';

class ChatDetail extends StatefulWidget {
  final bool editable;
  const ChatDetail({super.key, this.editable = false});

  @override
  State<StatefulWidget> createState() {
    return ChatDetailState();
  }
}

class ChatDetailState extends State<ChatDetail> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final chat = ModalRoute.of(context)?.settings.arguments as ChatModel?;
    final isCreate = empty(chat);
    return ChangeNotifierProvider(
      create: (context) => isCreate
          ? ChatDetailVM()
          : ChatDetailVM.detail(chat!, widget.editable),
      child: Consumer2<ThemeVM, ChatDetailVM>(
        builder: (context, theme, vm, child) {
          if (vm.loading) {
            return const Center(child: Loading());
          }
          var title = isCreate
              ? S.of(context).pageTitleChatCreate
              : vm.editable
                  ? S.of(context).pageTitleChatEdit(vm.name)
                  : S.of(context).pageTitleChatDetail(vm.name);
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
                      child: TitledCard(
                        labelText: S.of(context).cardTitleBasicInfo,
                        child: Center(
                          child: _buildForm(vm),
                        ),
                      ),
                    ),
                  ),
                ),
                _buttonBar(vm),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildForm(ChatDetailVM vm) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const CustomDivider(size: 10),
          Row(
            children: const [
              AvatarPicker(),
            ],
          ),
          const CustomDivider(size: 20),
          Row(
            children: const [
              Expanded(child: NameInput()),
              CustomDivider(
                size: 20,
                direction: DividerDirection.vertical,
              ),
              Expanded(child: PresetSelect()),
            ],
          ),
          const CustomDivider(size: 20),
          Row(
            children: [
              const Expanded(child: OpenAITokenSelect()),
              const CustomDivider(
                size: 20,
                direction: DividerDirection.vertical,
              ),
              if (!vm.editable)
                const Expanded(child: LastChatTimeInput())
              else
                Expanded(child: Container()),
            ],
          ),
          const CustomDivider(size: 20),
          if (!vm.editable) ...[
            Row(
              children: const [
                Expanded(child: CreatedTimeInput()),
                CustomDivider(
                  size: 20,
                  direction: DividerDirection.vertical,
                ),
                Expanded(child: UpdatedTimeInput()),
              ],
            ),
            const CustomDivider(size: 20),
          ]
        ],
      ),
    );
  }

  Widget _buttonBar(ChatDetailVM vm) {
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
          if (vm.editable)
            SizedBox(
              height: 40,
              child: ElevatedButton.icon(
                onPressed: vm.saving
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          await vm.save();
                          if (context.mounted) {
                            replace(
                              context,
                              RouterSettings.chatDetail,
                              arguments: vm.chat,
                            );
                          }
                        }
                      },
                icon: vm.saving ? const Loading() : const Icon(Icons.send),
                label: Text(S.of(context).btnConfirm),
              ),
            )
          else
            SizedBox(
              height: 40,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.chat),
                label: Text(S.of(context).btnChat),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouterSettings.chat,
                    (route) => false,
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}

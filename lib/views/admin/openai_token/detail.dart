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
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/models/openai_token_model.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syberwaifu/view_models/admin/openai_token/openai_token_detail_vm.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';
import 'package:syberwaifu/views/admin/openai_token/components/openai_token_form/created_time_input.dart';
import 'package:syberwaifu/views/admin/openai_token/components/openai_token_form/name_input.dart';
import 'package:syberwaifu/views/admin/openai_token/components/openai_token_form/status_select.dart';
import 'package:syberwaifu/views/admin/openai_token/components/openai_token_form/updated_time_input.dart';
import 'package:syberwaifu/views/admin/openai_token/components/openai_token_form/token_input.dart';

class OpenAITokenDetail extends StatefulWidget {
  final bool editable;
  const OpenAITokenDetail({super.key, this.editable = false});

  @override
  State<OpenAITokenDetail> createState() => _OpenAITokenDetailState();
}

class _OpenAITokenDetailState extends State<OpenAITokenDetail> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final openAIToken =
        ModalRoute.of(context)?.settings.arguments as OpenAITokenModel?;
    final isCreate = empty(openAIToken);
    var title = isCreate
        ? S.of(context).pageTitleOpenAITokenCreate
        : widget.editable
            ? S.of(context).pageTitleOpenAITokenEdit
            : S.of(context).pageTitleOpenAITokenDetail;
    return ChangeNotifierProvider(
      create: (context) => isCreate
          ? OpenAITokenDetailVM()
          : OpenAITokenDetailVM.detail(openAIToken!, widget.editable),
      child: Consumer2<ThemeVM, OpenAITokenDetailVM>(
        builder: (context, theme, vm, child) {
          if (vm.loading) {
            return const Center(child: Loading());
          }
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
                          horizontal: 20, vertical: 20),
                      child: TitledCard(
                        labelText: S.of(context).cardTitleBasicInfo,
                        child: Center(
                          child: _buildForm(vm),
                        ),
                      ),
                    ),
                  ),
                ),
                if (vm.editable) _buttonBar(vm),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildForm(OpenAITokenDetailVM vm) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const CustomDivider(size: 20),
          Row(
            children: const [
              Expanded(child: NameInput()),
              CustomDivider(
                size: 20,
                direction: DividerDirection.vertical,
              ),
              Expanded(child: StatusSelect()),
            ],
          ),
          const CustomDivider(size: 20),
          Row(
            children: const [Expanded(child: TokenInput())],
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
          ],
        ],
      ),
    );
  }

  Widget _buttonBar(OpenAITokenDetailVM vm) {
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
            icon: vm.saving ? const Loading() : const Icon(Icons.send),
            label: Text(S.of(context).btnConfirm),
            onPressed: vm.saving
                ? null
                : () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await vm.save();
                      if (context.mounted) {
                        replace(
                          context,
                          RouterSettings.openAITokenDetail,
                          arguments: vm.openAIToken,
                        );
                      }
                    }
                  },
          ),
        ],
      ),
    );
  }
}

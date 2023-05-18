import 'package:flutter/material.dart';

class OpenAITokenEdit extends StatefulWidget {
  final void Function(String tokenId)? afterSubmit;

  const OpenAITokenEdit({super.key, this.afterSubmit});

  @override
  State<StatefulWidget> createState() {
    return OpenAITokenEditState();
  }
}

class OpenAITokenEditState extends State<OpenAITokenEdit> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Container();
    // Form(
    //   key: formKey,
    //   autovalidateMode: AutovalidateMode.onUserInteraction,
    //   child: Column(
    //     children: [
    //       TextFormField(
    //         decoration: InputDecoration(
    //           labelText: S.of(context).name,
    //           border: const OutlineInputBorder(),
    //           prefixIcon: const Icon(Icons.title),
    //         ),
    //         controller: TextEditingController.fromValue(
    //             TextEditingValue(text: vm.name)),
    //         validator: (value) {
    //           if (empty<String>(value)) {
    //             return S.of(context).requiredErrorMessage(S.of(context).name);
    //           }
    //           return null;
    //         },
    //         onChanged: (value) => vm.name = value,
    //       ),
    //       const SizedBox(height: 10.0),
    //       TextFormField(
    //         decoration: InputDecoration(
    //           labelText: S.of(context).openaiToken,
    //           border: const OutlineInputBorder(),
    //           prefixIcon: const Icon(Icons.token),
    //         ),
    //         controller: TextEditingController.fromValue(
    //             TextEditingValue(text: vm.token)),
    //         validator: (value) {
    //           if (empty<String>(value)) {
    //             return S
    //                 .of(context)
    //                 .requiredErrorMessage(S.of(context).openaiToken);
    //           }
    //           return null;
    //         },
    //         onChanged: (value) => vm.token = value,
    //       ),
    //       const SizedBox(height: 10.0),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: [
    //           ElevatedButton.icon(
    //             onPressed: () async {
    //               if (formKey.currentState?.validate() ?? false) {
    //                 await vm.save();
    //               }
    //               if (widget.afterSubmit != null) {
    //                 widget.afterSubmit!(vm.uuid);
    //               }
    //             },
    //             icon: const Icon(Icons.send),
    //             label: Text(S.of(context).confirm),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}

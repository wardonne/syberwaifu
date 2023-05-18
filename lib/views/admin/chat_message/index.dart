import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/buttons/custom_back_button.dart';
import 'package:syberwaifu/components/custom_appbar.dart';
import 'package:syberwaifu/components/loading.dart';
import 'package:syberwaifu/components/table/custom_pager.dart';
import 'package:syberwaifu/constants/application.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/types/chat_message_list_conditions.dart';
import 'package:syberwaifu/view_models/admin/chat_message/chat_message_index_vm.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ChatMessageIndex extends StatefulWidget {
  const ChatMessageIndex({super.key});

  @override
  State<ChatMessageIndex> createState() => _ChatMessageIndexState();
}

class _ChatMessageIndexState extends State<ChatMessageIndex> {
  @override
  Widget build(BuildContext context) {
    final conditions = ModalRoute.of(context)?.settings.arguments
        as ChatMessageListConditions?;
    final chat = conditions?.chat;
    return Scaffold(
      appBar: CustomAppBar(
        '${S.of(context).pageTitleChatMessageManager}${chat == null ? '' : '(${chat.name})'}',
        floatingLeadings: const [
          CustomBackButton(),
        ],
      ),
      body: ChangeNotifierProvider(
        create: (context) => ChatMessageIndexVM(context, conditions),
        child: Consumer<ChatMessageIndexVM>(
          builder: (context, vm, child) {
            if (vm.loading) {
              return const Center(child: Loading());
            }
            return LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: [
                  _dataTable(constraints, vm),
                  if (vm.totalPage > 1) _dataPager(vm),
                ],
              );
            });
          },
        ),
      ),
    );
  }

  Widget _dataTable(BoxConstraints constraints, ChatMessageIndexVM vm) {
    const loading = Center(child: Loading());
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: constraints.maxHeight -
            (vm.totalPage > 1 ? ApplicationConstants.pagerHeight : 0),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: vm.loadingData
            ? loading
            : SfDataGrid(
                source: vm,
                rowsPerPage: vm.pageSize,
                headerGridLinesVisibility: GridLinesVisibility.both,
                gridLinesVisibility: GridLinesVisibility.both,
                isScrollbarAlwaysShown: true,
                allowSorting: true,
                frozenColumnsCount: 1,
                footerFrozenColumnsCount: 1,
                columnWidthMode: ColumnWidthMode.fill,
                columns: _dataHeaders(),
              ),
      ),
    );
  }

  List<GridColumn> _dataHeaders() {
    final locale = S.of(context);
    return [
      GridColumn(
        columnName: 'UUID',
        label: Center(child: Text(locale.columnNameChatMessageUUID)),
      ),
      GridColumn(
        columnName: 'ROLE',
        label: Center(child: Text(locale.columnNameChatMessageRole)),
      ),
      GridColumn(
        allowSorting: false,
        columnName: 'CONTENT',
        label: Center(child: Text(locale.columnNameChatMessageContent)),
      ),
      GridColumn(
        columnName: 'QUOTE_COUNT',
        label: Center(child: Text(locale.columnNameChatMessageQuoteCount)),
      ),
      GridColumn(
        columnName: 'CREATED_AT',
        label: Center(child: Text(locale.columnNameChatMessageCreatedAt)),
      ),
      GridColumn(
        allowSorting: false,
        columnName: 'ACTIONS',
        label: Center(child: Text(locale.columnNameActions)),
      ),
    ];
  }

  Widget _dataPager(ChatMessageIndexVM vm) {
    return CustomPager(
      currentPage: vm.page,
      totalPages: vm.totalPage,
      onPageChanged: vm.setPage,
    );
  }
}

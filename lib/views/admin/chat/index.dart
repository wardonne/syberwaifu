import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/buttons/back_to_chat_button.dart';
import 'package:syberwaifu/components/buttons/custom_back_button.dart';
import 'package:syberwaifu/components/buttons/custom_elevated_button.dart';
import 'package:syberwaifu/components/custom_appbar.dart';
import 'package:syberwaifu/components/loading.dart';
import 'package:syberwaifu/components/table/custom_pager.dart';
import 'package:syberwaifu/components/table/title_header.dart';
import 'package:syberwaifu/constants/application.dart';
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syberwaifu/types/chat_list_conditions.dart';
import 'package:syberwaifu/view_models/admin/chat/chat_index_vm.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ChatIndex extends StatefulWidget {
  const ChatIndex({super.key});

  @override
  State<StatefulWidget> createState() {
    return ChatIndexState();
  }
}

class ChatIndexState extends State<ChatIndex> {
  final key = GlobalKey<ChatIndexState>();

  @override
  Widget build(BuildContext context) {
    final conditions =
        ModalRoute.of(context)?.settings.arguments as ChatListConditions?;
    return Scaffold(
      appBar: CustomAppBar(
        '${S.of(context).pageTitleChatManager}${conditions != null ? '($conditions)' : ''}',
        floatingLeadings: const [
          CustomBackButton(),
          BackToChatButton(),
        ],
      ),
      body: ChangeNotifierProvider(
        create: (context) => ChatIndexVM(context, conditions: conditions),
        child: Consumer<ChatIndexVM>(
          builder: (context, vm, child) {
            if (vm.loading) {
              return const Center(child: Loading());
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    _dataTable(constraints, vm),
                    if (vm.totalPage > 1) _dataPager(vm),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _dataTable(BoxConstraints constraints, ChatIndexVM vm) {
    const loading = Center(child: Loading());
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: constraints.maxHeight -
              (vm.totalPage > 1 ? ApplicationConstants.pagerHeight : 0)),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: vm.loadingData
            ? loading
            : SfDataGrid(
                source: vm,
                rowsPerPage: vm.pageSize,
                headerGridLinesVisibility: GridLinesVisibility.both,
                gridLinesVisibility: GridLinesVisibility.both,
                allowSorting: true,
                frozenColumnsCount: 3,
                footerFrozenColumnsCount: 1,
                columnWidthMode: ColumnWidthMode.fitByColumnName,
                columns: _dataHeaders(),
                isScrollbarAlwaysShown: true,
                stackedHeaderRows: _stackedHeaders(vm),
              ),
      ),
    );
  }

  List<StackedHeaderRow> _stackedHeaders(ChatIndexVM vm) {
    return [
      TitleHeader(
        title: S.of(context).tableTitleChatList,
        actions: [
          CustomElevatedButton(
            onPressed: () async {
              await forward(context, RouterSettings.chatCreate);
              vm.reload();
            },
            icon: const Icon(Icons.add),
            label: Text(S.of(context).btnAdd),
          ),
        ],
        columns: [
          'UUID',
          'NAME',
          'AVATAR',
          'PRESET',
          'MESSAGE_COUNT',
          'OPENAI_TOKEN',
          'LAST_CHATED_AT',
          'CREATED_AT',
          'UPDATED_AT',
          'ACTIONS',
        ],
      ).build(context),
    ];
  }

  List<GridColumn> _dataHeaders() {
    final locale = S.of(context);
    return [
      GridColumn(
        columnName: 'UUID',
        width: 100,
        columnWidthMode: ColumnWidthMode.lastColumnFill,
        label: Center(child: Text(locale.columnNameChatUUID)),
      ),
      GridColumn(
        columnName: 'NAME',
        label: Center(child: Text(locale.columnNameChatName)),
      ),
      GridColumn(
        columnName: 'AVATAR',
        label: Center(child: Text(S.of(context).columnNameChatAvatar)),
      ),
      GridColumn(
        columnName: 'PRESET',
        label: Center(child: Text(locale.columnNamePresetName)),
      ),
      GridColumn(
        allowSorting: false,
        columnName: 'OPENAI_TOKEN',
        label: Center(child: Text(locale.columnNameOpenAIToken)),
      ),
      GridColumn(
        allowSorting: false,
        columnName: 'MESSAGE_COUNT',
        label: Center(child: Text(S.of(context).columnNameChatMessageCount)),
      ),
      GridColumn(
        columnName: 'LAST_CHATED_AT',
        label: Center(child: Text(locale.columnNameChatLastChatedAt)),
      ),
      GridColumn(
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        columnName: 'CREATED_AT',
        label: Center(child: Text(locale.columnNameCreatedAt)),
      ),
      GridColumn(
        columnName: 'UPDATED_AT',
        label: Center(child: Text(locale.columnNameUpdatedAt)),
      ),
      GridColumn(
        width: 140,
        allowSorting: false,
        columnName: 'ACTIONS',
        label: Center(child: Text(locale.columnNameActions)),
      ),
    ];
  }

  Widget _dataPager(ChatIndexVM vm) {
    return CustomPager(
      currentPage: vm.page,
      totalPages: vm.totalPage,
      onPageChanged: vm.setPage,
    );
  }
}

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
import 'package:syberwaifu/view_models/admin/openai_token/openai_token_index_vm.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OpenAITokenIndex extends StatefulWidget {
  const OpenAITokenIndex({super.key});

  @override
  State<StatefulWidget> createState() {
    return OpenAITokenIndexState();
  }
}

class OpenAITokenIndexState extends State<OpenAITokenIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        S.of(context).pageTitleOpenAITokenManager,
        floatingLeadings: const [
          CustomBackButton(),
          BackToChatButton(),
        ],
      ),
      body: ChangeNotifierProvider(
        create: (context) => OpenAITokenIndexVM(context),
        child: Consumer<OpenAITokenIndexVM>(
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

  Widget _dataTable(BoxConstraints constraints, OpenAITokenIndexVM vm) {
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
                frozenColumnsCount: 1,
                footerFrozenColumnsCount: 1,
                columnWidthMode: ColumnWidthMode.fill,
                columns: _dataHeaders(),
                stackedHeaderRows: _stackedHeaders(vm),
              ),
      ),
    );
  }

  List<StackedHeaderRow> _stackedHeaders(OpenAITokenIndexVM vm) {
    return [
      TitleHeader(
        title: S.of(context).tableTitleOpenAITokenList,
        actions: [
          CustomElevatedButton(
            icon: const Icon(Icons.add),
            label: Text(S.of(context).btnAdd),
            onPressed: () async {
              await forward(context, RouterSettings.openAITokenCreate);
              vm.reload();
            },
          ),
        ],
        columns: [
          'UUID',
          'NAME',
          'TOKEN',
          'CHAT_COUNT',
          'CREATED_AT',
          'UPDATED_AT',
          'ACTIONS',
        ],
      ).build(context),
    ];
  }

  List<GridColumn> _dataHeaders() {
    final local = S.of(context);
    return [
      GridColumn(
        columnName: 'UUID',
        width: 100,
        label: Center(
          child: Text(local.columnNameOpenAITokenUUID),
        ),
      ),
      GridColumn(
        columnName: 'NAME',
        label: Center(child: Text(local.columnNameOpenAITokenName)),
      ),
      GridColumn(
        allowSorting: false,
        columnName: 'TOKEN',
        label: Center(child: Text(local.columnNameOpenAITokenContent)),
      ),
      GridColumn(
          allowSorting: false,
          columnName: 'CHAT_COUNT',
          label: Center(
            child: Text(local.columnNameOpenAITokenChatCount),
          )),
      GridColumn(
        columnName: 'CREATED_AT',
        label: Center(child: Text(local.columnNameCreatedAt)),
      ),
      GridColumn(
        columnName: 'UPDATED_AT',
        label: Center(child: Text(local.columnNameUpdatedAt)),
      ),
      GridColumn(
        allowSorting: false,
        columnName: 'ACTIONS',
        label: Center(child: Text(local.columnNameActions)),
      ),
    ];
  }

  Widget _dataPager(OpenAITokenIndexVM vm) {
    return CustomPager(
      currentPage: vm.page,
      totalPages: vm.totalPage,
      onPageChanged: vm.setPage,
    );
  }
}

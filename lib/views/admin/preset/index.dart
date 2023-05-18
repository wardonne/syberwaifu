import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/buttons/back_to_chat_button.dart';
import 'package:syberwaifu/components/buttons/custom_back_button.dart';
import 'package:syberwaifu/components/buttons/custom_elevated_button.dart';
import 'package:syberwaifu/components/custom_appbar.dart';
import 'package:syberwaifu/components/loading.dart';
import 'package:syberwaifu/components/table/custom_pager.dart';
import 'package:syberwaifu/constants/application.dart';
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syberwaifu/view_models/admin/preset/preset_index_vm.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PresetIndex extends StatefulWidget {
  const PresetIndex({super.key});

  @override
  State<StatefulWidget> createState() {
    return PresetIndexState();
  }
}

class PresetIndexState extends State<PresetIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        S.of(context).pageTitlePresetManager,
        floatingLeadings: const [
          CustomBackButton(),
          BackToChatButton(),
        ],
      ),
      body: ChangeNotifierProvider(
        create: (context) => PresetIndexVM(context),
        child: Consumer<PresetIndexVM>(
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

  Widget _dataTable(BoxConstraints constraints, PresetIndexVM vm) {
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
                stackedHeaderRows: [
                  StackedHeaderRow(cells: [
                    StackedHeaderCell(
                      columnNames: [
                        'UUID',
                        'NAME',
                        'NICKNAME',
                        'IS_DEFAULT',
                        'CHAT_COUNT',
                        'CREATED_AT',
                        'UPDATED_AT',
                        'ACTIONS',
                      ],
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                S.of(context).tableTitlePresetList,
                                textScaleFactor: 1.3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            CustomElevatedButton(
                              icon: const Icon(Icons.add),
                              label: Text(S.of(context).btnAdd),
                              onPressed: () async {
                                await forward(
                                    context, RouterSettings.presetCreate);
                                vm.reload();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
      ),
    );
  }

  List<GridColumn> _dataHeaders() {
    final locale = S.of(context);
    return [
      GridColumn(
        columnWidthMode: ColumnWidthMode.lastColumnFill,
        allowEditing: false,
        columnName: 'UUID',
        label: Center(
          child: Text(
            locale.columnNamePresetUUID,
          ),
        ),
      ),
      GridColumn(
        columnWidthMode: ColumnWidthMode.auto,
        columnName: 'NAME',
        label: Center(
          child: Text(locale.columnNamePresetName),
        ),
      ),
      GridColumn(
        columnWidthMode: ColumnWidthMode.auto,
        columnName: 'NICKNAME',
        label: Center(
          child: Text(locale.columnNamePresetNickname),
        ),
      ),
      GridColumn(
        columnWidthMode: ColumnWidthMode.auto,
        columnName: 'IS_DEFAULT',
        label: Center(
          child: Text(locale.columnNamePresetIsDefault),
        ),
      ),
      GridColumn(
        allowSorting: false,
        columnWidthMode: ColumnWidthMode.auto,
        columnName: 'CHAT_COUNT',
        label: Center(child: Text(S.of(context).columnNamePresetChatCount)),
      ),
      GridColumn(
        columnWidthMode: ColumnWidthMode.auto,
        columnName: 'CREATED_AT',
        label: Center(
          child: Text(locale.columnNameCreatedAt),
        ),
      ),
      GridColumn(
        columnWidthMode: ColumnWidthMode.auto,
        columnName: 'UPDATED_AT',
        label: Center(
          child: Text(locale.columnNameUpdatedAt),
        ),
      ),
      GridColumn(
        width: 120,
        allowEditing: false,
        allowFiltering: false,
        allowSorting: false,
        columnName: 'ACTIONS',
        label: Center(child: Text(locale.columnNameActions)),
      ),
    ];
  }

  Widget _dataPager(PresetIndexVM vm) {
    return CustomPager(
      currentPage: vm.page,
      totalPages: vm.totalPage,
      onPageChanged: vm.setPage,
    );
  }
}

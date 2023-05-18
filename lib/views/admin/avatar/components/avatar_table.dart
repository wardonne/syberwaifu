import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/buttons/custom_elevated_button.dart';
import 'package:syberwaifu/components/loading.dart';
import 'package:syberwaifu/components/table/custom_pager.dart';
import 'package:syberwaifu/components/table/title_header.dart';
import 'package:syberwaifu/constants/application.dart';
import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/functions/open_dialog.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/models/avatar.dart';
import 'package:syberwaifu/view_models/admin/avatar/avatar_index_vm.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AvatarTable extends StatefulWidget {
  final bool isPopup;
  const AvatarTable({
    super.key,
    this.isPopup = false,
  });

  @override
  State<AvatarTable> createState() => _AvatarTableState();
}

class _AvatarTableState extends State<AvatarTable> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AvatarIndexVM(
        context,
        isPopup: widget.isPopup,
      ),
      child: Consumer<AvatarIndexVM>(
        builder: (context, avatarIndexVM, child) {
          if (avatarIndexVM.loading) {
            return const Center(child: Loading());
          }
          return LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  _dataTable(constraints, avatarIndexVM),
                  if (avatarIndexVM.totalPage > 1) _dataPager(avatarIndexVM),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _dataTable(BoxConstraints constraints, AvatarIndexVM avatarIndexVM) {
    const loading = Center(child: Loading());
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: constraints.maxHeight -
            (avatarIndexVM.totalPage > 1
                ? ApplicationConstants.pagerHeight
                : 0),
      ),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: avatarIndexVM.loadingData
            ? loading
            : SfDataGrid(
                selectionMode:
                    widget.isPopup ? SelectionMode.single : SelectionMode.none,
                onSelectionChanged: (addedRows, removedRows) {
                  if (addedRows.isEmpty && removedRows.isEmpty) return;
                  if (avatarIndexVM.selectedAvatar?.uuid ==
                      addedRows.first.getCells()[1].value as String) {
                    avatarIndexVM.selectedAvatar = null;
                  } else {
                    avatarIndexVM.selectedAvatar = avatarIndexVM.models
                        .firstWhere((element) =>
                            element.uuid ==
                            addedRows.first.getCells()[1].value as String);
                  }
                  avatarIndexVM.refresh();
                },
                navigationMode: GridNavigationMode.row,
                source: avatarIndexVM,
                rowsPerPage: avatarIndexVM.pageSize,
                headerGridLinesVisibility: GridLinesVisibility.both,
                gridLinesVisibility: GridLinesVisibility.both,
                allowSorting: true,
                frozenColumnsCount: 3,
                footerFrozenColumnsCount: 1,
                columnWidthMode: ColumnWidthMode.fill,
                columns: _dataHeaders(avatarIndexVM),
                stackedHeaderRows: _stackedHeaders(avatarIndexVM),
              ),
      ),
    );
  }

  List<StackedHeaderRow> _stackedHeaders(AvatarIndexVM avatarIndexVM) {
    return [
      TitleHeader(title: S.of(context).tableTitleAvatarList, actions: [
        if (widget.isPopup)
          CustomElevatedButton(
            icon: const Icon(Icons.send),
            label: Text(S.of(context).btnConfirm),
            onPressed: () {
              back<AvatarModel>(context, result: avatarIndexVM.selectedAvatar);
            },
          )
        else
          CustomElevatedButton(
            icon: const Icon(Icons.add),
            label: Text(S.of(context).btnAdd),
            onPressed: () {
              _pickerAvatar(avatarIndexVM);
            },
          ),
      ], columns: [
        if (avatarIndexVM.isPopup) 'CHECKBOX',
        'UUID',
        'URI',
        if (!avatarIndexVM.isPopup) 'CHAT_COUNT',
        'CREATED_AT',
        'ACTIONS',
      ]).build(context),
    ];
  }

  List<GridColumn> _dataHeaders(AvatarIndexVM vm) {
    final locale = S.of(context);
    return [
      if (vm.isPopup)
        GridColumn(
            allowSorting: false,
            width: 80,
            columnName: 'CHECKBOX',
            label: const Text('')),
      GridColumn(
        columnName: 'UUID',
        label: Center(child: Text(locale.columnNameAvatarUUID)),
      ),
      GridColumn(
        allowSorting: false,
        columnName: 'URI',
        label: Center(child: Text(locale.columnNameAvatarImage)),
      ),
      if (!vm.isPopup)
        GridColumn(
          allowSorting: false,
          columnName: 'CHAT_COUNT',
          label: Center(
            child: Text(locale.columnNameAvatarChatCount),
          ),
        ),
      GridColumn(
        columnName: 'CREATED_AT',
        label: Center(child: Text(locale.columnNameCreatedAt)),
      ),
      GridColumn(
        allowSorting: false,
        columnName: 'ACTIONS',
        label: Center(child: Text(locale.columnNameActions)),
      ),
    ];
  }

  Widget _dataPager(AvatarIndexVM vm) {
    return CustomPager(
      totalPages: vm.totalPage,
      currentPage: vm.page,
      onPageChanged: vm.setPage,
    );
  }

  _pickerAvatar(AvatarIndexVM vm) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (result != null) {
      final filePath = result.paths.first;
      if (filePath != null && context.mounted) {
        final avatarPath = await openImageEditor(context, imageSrc: filePath);
        if (!empty<String>(avatarPath)) {
          await vm.create(avatarPath!);
          vm.reload();
        }
      }
    }
  }
}

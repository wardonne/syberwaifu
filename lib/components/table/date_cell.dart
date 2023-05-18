import 'package:intl/intl.dart';
import 'package:syberwaifu/components/table/text_cell.dart';

class DateCell extends TextCell {
  final DateTime dateTime;
  final String format;

  DateCell({
    super.key,
    required this.dateTime,
    this.format = 'yyyy-MM-dd HH:mm:ss',
  }) : super(value: DateFormat(format).format(dateTime));
}

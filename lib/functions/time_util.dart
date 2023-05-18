class TimeUtil {
  static DateTime now() {
    return DateTime.now();
  }

  static DateTime fromTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  static DateTime fromMilliTimestamp(int milliseconds) {
    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

  static int timestamp(DateTime? dateTime) {
    return milliTimestamp(dateTime) ~/ 1000;
  }

  static int milliTimestamp(DateTime? dateTime) {
    return dateTime != null
        ? dateTime.millisecondsSinceEpoch
        : now().millisecondsSinceEpoch;
  }
}

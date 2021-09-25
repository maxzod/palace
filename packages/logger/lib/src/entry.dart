class _LogEntry {
  final String msg;
  final String tag;
  final DateTime createdAt = DateTime.now();
  _LogEntry({
    required this.msg,
    required this.tag,
  });
}

class _ErrorLog extends _LogEntry {
  final StackTrace? stackTrace;
  _ErrorLog({
    required String msg,
    required String tag,
    this.stackTrace,
  }) : super(msg: msg, tag: tag);
}

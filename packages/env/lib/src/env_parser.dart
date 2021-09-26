bool isAComment(String line) {
  return line.startsWith('//') || RegExp(r'''#.*(?:[^'"])$''').hasMatch(line);
}

String extractKey(String line) {
  final indexOfEqual = line.indexOf('=');
  return line.replaceRange(indexOfEqual, line.length, '').trim();
}

String extractValue(String line) {
  final indexOfEqual = line.indexOf('=');
  return line.replaceRange(0, indexOfEqual + 1, '').trim();
}

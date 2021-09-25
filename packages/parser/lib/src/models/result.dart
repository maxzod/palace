import 'dart:convert';

class Result {
  // *  the parsed body
  final Map<String, dynamic> body;

  // * the parsed query
  final Map<String, dynamic> query;

  Result({
    required this.body,
    required this.query,
  });

  Map<String, dynamic> toMap() {
    return {
      'body': body,
      'query': query,
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  /// * return `true` if request has noy query or body paramters
  bool get isEmpty => keys.isEmpty;

  /// * return the value from request `either` the `body` `first` if `null` return from the `query` `else` return `null`
  dynamic get(String key) => body[key] ?? query[key];

  /// * return the keys from the request body and query
  List<String> get keys => [...body.keys, ...query.keys];

  /// * return true if the request body or query has value with the provided key
  bool has(String key) => get(key) != null;
}

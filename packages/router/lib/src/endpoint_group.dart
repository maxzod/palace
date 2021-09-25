import 'package:core/core.dart';
import 'package:router/src/endpoint.dart';

class EndPointGroup {
  final _children = <String, EndPoint>{};

  void add(EndPoint endPoint) {
    if (_children[endPoint.method] == null) {
      // TODO :: use logger
      print('''
          you have used this route with this method before,
          palace will ovrride it and use the leatest endpint,
          new one is ${endPoint.method} => ${endPoint.path}
          ''');
    }
    _children[endPoint.method] = endPoint;
  }

  EndPoint findChild(String method) {
    final result = _children[method];
    if (result == null) {
      /// method is not supported
      throw NotFound(
        {
          'message':
              'method $method is not supported , the supported methods for this route is ${_children.keys}'
        },
      );
    }
    // else if (method == '*' && _children.keys.length > 1) {
    //   /// more than one match
    //   throw NotFound(
    //     {
    //       'message':
    //           'this route has more than one method and you registerd method all in one of them , so plase remove them and keep only the all method'
    //     },
    //   );
    // }

    return result;
  }
}

import 'package:palace/palace.dart';
import 'package:palace/src/core/chief_handler.dart';
import 'package:palace/src/decorators/http_method.dart';
import 'package:palace/src/decorators/use_guard.dart';
import '../types.dart';
// <3 ♥ :3
import 'dart:mirrors';

/// the standard class variables
/// will use it to throw error if the `controller` instance contains variable
/// which is not here and is not `HttpMethodDecorator`
const _whiteList = [
  #==,
  #hashCode,
  #toString,
  #noSuchMethod,
  #runtimeType,
  #path,
  #guards,
];

/// takes list of controllers and palace instance
/// and register the controllers to the palace
class Collector {
  final List<PalaceController> controllers;
  final Palace palace;
  Collector(this.controllers, this.palace);

  /// init `controller` values to the `palace`
  void collect() {
    for (final controller in controllers) {
      _setEndPointsFromController(controller);
    }
  }

  void _setEndPointsFromController(PalaceController controller) {
    /// reflect the controller
    final _controllerReflection = reflect(controller);

    /// extract methods
    final _endpointsHandlers =
        _extractHttpMethodsFromController(_controllerReflection);

    /// for each http method decorator set up new endpoint
    _endpointsHandlers.forEach((key, value) {
      /// extract endpoint http methods
      final _endPointMethods =
          value.metadata.where((v) => v.reflectee is HttpMethodDecorator);

      /// extract endpoint guards
      final _endPointGuards = _extractEndpointGuards(value);

      /// guards
      final _guards = <Function>[...controller.guards, ..._endPointGuards];

      /// no need to check for duplicate since openGates(); do it any way
      for (final _httpMethodMirror in _endPointMethods) {
        /// the method decorator instance
        final _methodDecorator =
            _httpMethodMirror.reflectee as HttpMethodDecorator;

        /// the http method name might be 'GET' or 'PUT' or 'post' and so on
        final _method = _methodDecorator.method;

        /// the endpoint path
        /// the condition to fix common miss understanding
        final _path = _methodDecorator.path == '/' ? '' : _methodDecorator.path;
        final _functionMirror =
            _controllerReflection.getField(value.simpleName);
        _validateHandler(
          _functionMirror.getField(#call).type as FunctionTypeMirror,
          MirrorSystem.getName(_controllerReflection.type.simpleName),
        );

        /// the endpoint handler
        final _handler = _functionMirror.reflectee;

        /// register the reflected variables from the mirrors
        palace.register(
          /// append the endpoint path to the controller path
          path: '${controller.path + (_path.isEmpty ? '' : _path)}',
          handler: (req, res) => chiefHandler(req, res, _handler, null)
              .onError((e, st) => throw e!),
          method: _method,
          guards: _guards,
        );
      }
    });
  }

  ///  * take controller instance reflection and return the `HttpMethodDecorator`
  /// ? throw error if the controller is not valid
  /// ! controllers only allowed to contain functions that are decorated with HttpMethodDecorator

  Map<Symbol, MethodMirror> _extractHttpMethodsFromController(
      InstanceMirror controllerReflection) {
    /// to group the http methods
    final methods = <Symbol, MethodMirror>{};

    /// loop throw every member of this controller instance
    controllerReflection.type.instanceMembers.forEach((key, value) {
      try {
        // if pass this line means he got one decorator for this method
        value.metadata.firstWhere((v) => v.reflectee is HttpMethodDecorator);

        /// assign the method to result set;
        methods[key] = value;
      } on StateError {
        // if its not in the white list then it must not be in controller in the first place
        if (!_whiteList.contains(key)) {
          /// is not decorated and is not in the white list
          /// throw it away
          throw '''
         [palace][controller] ${MirrorSystem.getName(key)} is not decorated function with HttpMethodDecorator
         controllers only allowed to contain functions that are decorated with HttpMethodDecorator  
         Like Get(),Post(),Put()....etc
         ''';
        }
      }
    });

    /// the controller does not contain any methods decorated with HttpMethodDecorator
    if (methods.keys.isEmpty) {
      throw '[controller] ${MirrorSystem.getName(controllerReflection.type.simpleName)} must have at least one http method handler';
    }
    return methods;
  }

  /// extract the guards from the decorator
  List<Function> _extractEndpointGuards(MethodMirror methodMirror) {
    final _guards = <Function>[];
    for (final meta in methodMirror.metadata
        .where((d) => d.reflectee is UseGuard || d.reflectee is UseGuards)) {
      if (meta.reflectee is UseGuard) {
        _guards.add((meta.reflectee as UseGuard).guard.call);
      } else if (meta.reflectee is UseGuards) {
        _guards.addAll((meta.reflectee as UseGuards).guards.map((e) => e.call));
      }
    }
    print(_guards);
    return _guards;
  }

  void _validateHandler(FunctionTypeMirror mirror, String controllerName) {
    /// no named parameters
    // TODO(2) :: get the real name
    final currentMethodName = MirrorSystem.getName(mirror.simpleName);
    for (final param in mirror.parameters) {
      final currentParamName = MirrorSystem.getName(param.simpleName);

      if (param.isNamed) {
        throw '''
        [palace][collector:$controllerName] $currentMethodName cant have any named parameters
        but you give it $currentParamName fix it !
        ''';
      } else if (param.isOptional) {
        throw '''
        [palace][collector:$controllerName] $currentMethodName cant have any optional parameters
        but you give it $currentParamName fix it !
        ''';
      } else if (param.type.reflectedType == dynamic) {
        throw '''
        [palace][collector:$controllerName] $currentMethodName cant have any dynamic parameters
        but you give it $currentParamName give it a type it !
        ''';
      }
    }
  }
}

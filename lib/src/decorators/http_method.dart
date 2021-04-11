class HttpMethodDecorator {
  final String method;
  final String path;
  const HttpMethodDecorator(this.method, this.path);
}

class Get extends HttpMethodDecorator {
  const Get([String path = '']) : super('GET', path);
}

class Post extends HttpMethodDecorator {
  const Post([String path = '']) : super('POST', path);
}

class Put extends HttpMethodDecorator {
  const Put([String path = '']) : super(' PUT', path);
}

class Delete extends HttpMethodDecorator {
  const Delete([String path = '']) : super('DELETE', path);
}

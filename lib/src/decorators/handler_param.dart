abstract class PalaceParamDecorator {
  const PalaceParamDecorator();
}

class Next extends PalaceParamDecorator {
  const Next();
}

class Body extends PalaceParamDecorator {
  final String key;
  const Body([this.key = '']);
}

class Query extends PalaceParamDecorator {
  final String key;
  const Query([this.key = '']);
}

class Param extends PalaceParamDecorator {
  final String key;
  const Param([this.key = '']);
}

// class Req extends PalaceParamDecorator {
//   const Req();
// }

// class Res extends PalaceParamDecorator {
//   const Res();
// }

// class Request extends PalaceParamDecorator {
//   const Request();
// }

// class Response extends PalaceParamDecorator {
//   const Response();
// }

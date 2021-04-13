abstract class PalaceParamDecorator {
  const PalaceParamDecorator();
}

class Next extends PalaceParamDecorator {
  const Next();
}

abstract class OneKeyDecorator extends PalaceParamDecorator {
  final String key;
  const OneKeyDecorator([this.key = '']);
}

class Body extends OneKeyDecorator {
  const Body([String key = '']) : super(key);
}

class Query extends OneKeyDecorator {
  const Query([String key = '']) : super(key);
}

class Param extends OneKeyDecorator {
  const Param([String key = '']) : super(key);
}

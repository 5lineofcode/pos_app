
dynamic js;

class JS {
  static execute(
    String methodName, {
    List params = const [],
  }) {
    js.context.callMethod(methodName, params);
  }
}

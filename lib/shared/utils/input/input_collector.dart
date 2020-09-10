class InputCollector {
  static Map<String, dynamic> valueList = {};
  static String dataSource;
  
  static reset() {
    valueList = {};
  }

  static add(id, value) {
    valueList[id] = value;
  }
}

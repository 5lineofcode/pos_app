extension AddIfListExtension<T> on List<T> {
  addIf<R>({
    dynamic content,
    bool condition,
  }) {
    if (condition) {
      this.add(content);
    }
  }
}

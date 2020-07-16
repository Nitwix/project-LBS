import 'dart:math' show Random;

extension RandomElement<T> on List<T> {
  T get randomElement{
    return this[Random().nextInt(this.length)];
  }
}
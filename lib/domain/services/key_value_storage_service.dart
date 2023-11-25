import 'dart:async';

abstract class KeyValueStorageService<T> {
  String get key;
  Future<T?> read();
  Future<void> save(T value);
  Future<void> delete();
  ObjectToStringParser<T>? get parser;
}

abstract class ObjectToStringParser<T> {
  StringBuilderFromObject<T> stringBuilder();
  ObjectBuilderFromString<T> objectBuilder();
}

typedef StringBuilderFromObject<T> = String Function(T value);
typedef ObjectBuilderFromString<T> = T Function(String value);

class KeyAndValueStorageTypeNotImplementedException<T> implements Exception {}

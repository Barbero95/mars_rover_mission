import 'package:collection/collection.dart';

enum CommandType {
  F,
  L,
  R;

  static CommandType? fromText(String text) => values.firstWhereOrNull(
        (value) => value.name.toUpperCase() == text.toUpperCase(),
      );
}

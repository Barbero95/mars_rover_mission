import 'package:flutter/material.dart';
import 'package:flutter_template/core/commons/services/translation/generated/l10n.dart';

extension BuildContextHelper on BuildContext {
  Translation get trl {
    return Translation.of(this);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mars_rover_mission/core/commons/domain/enums/export_enums.dart';
import 'package:mars_rover_mission/core/utils/upper_case_text_input_formatter.dart';

class _Constants {
  static const commandRegex = '[flrFLR]';
  static const defaultMaxLength = 25;
}

class _Strings {
  static const defaultError = 'Fill field';
  static const invalidNumberError = 'Enter a valid number';
  static const invalidCommandError = 'Only the letters F, L, and R are allowed';
}

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextFormFieldType type;
  final int maxLength;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.controller,
    required this.type,
    this.maxLength = _Constants.defaultMaxLength,
  });

  (TextInputType, List<TextInputFormatter>, TextCapitalization) get _setup =>
      switch (type) {
        TextFormFieldType.number => (
            TextInputType.number,
            [
              FilteringTextInputFormatter.digitsOnly,
            ],
            TextCapitalization.none
          ),
        TextFormFieldType.command => (
            TextInputType.text,
            [
              UpperCaseTextInputFormatter(),
              FilteringTextInputFormatter.allow(
                RegExp(_Constants.commandRegex),
              ),
            ],
            TextCapitalization.words,
          ),
      };

  @override
  Widget build(BuildContext context) {
    final (keyboardType, inputFormatters, textCapitalization) = _setup;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return _Strings.defaultError;
        }
        if (type.isNumber && int.tryParse(value) == null) {
          return _Strings.invalidNumberError;
        }
        if (type.isCommand &&
            !RegExp(_Constants.commandRegex).hasMatch(value)) {
          return _Strings.invalidCommandError;
        }
        return null;
      },
    );
  }
}

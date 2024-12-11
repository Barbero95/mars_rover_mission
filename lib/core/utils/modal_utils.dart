import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mars_rover_mission/core/commons/domain/enums/export_enums.dart';
import 'package:mars_rover_mission/core/commons/ui/widgets/export_widgets.dart';

class _Strings {
  static const errorTitle = 'Ups!';
  static const closeButton = 'Close';
  static const saveButton = 'Save';
  static const newCommands = 'New commands';
}

class ModalUtils {
  static Future<void> basicModal({
    required BuildContext context,
    required String title,
    Widget? content,
    String? primaryButtonLabel,
    String? secondaryButtonLabel,
    VoidCallback? onPressedPrimaryBtn,
    VoidCallback? onPressedSecondaryBtn,
    IconData? titleIcon,
    bool? barrierDismissible,
  }) async {
    await showDialog<void>(
      barrierDismissible: barrierDismissible ?? true,
      context: context,
      builder: (context) {
        return CustomModal(
          title: title,
          barrierDismissible: barrierDismissible ?? true,
          content: content,
          primaryButtonLabel: primaryButtonLabel,
          secondaryButtonLabel: secondaryButtonLabel ?? _Strings.closeButton,
          onPressedPrimaryButton: onPressedPrimaryBtn,
          onPressedSecondaryButton: onPressedSecondaryBtn,
          titleIcon: titleIcon,
        );
      },
    );
  }

  static Future<void> errorModal({
    required BuildContext context,
    required String description,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return CustomModal(
          title: _Strings.errorTitle,
          content: Text(
            description,
          ),
          secondaryButtonLabel: _Strings.closeButton,
          titleIcon: Icons.error_outline,
        );
      },
    );
  }

  static Future<void> editCommandsModal({
    required BuildContext context,
    required String commands,
    required void Function(String) onPressedPrimaryBtn,
  }) async {
    final formKey = GlobalKey<FormState>();
    final commandsTE = TextEditingController(text: commands);
    await showDialog<void>(
      context: context,
      builder: (context) {
        return CustomModal(
          title: _Strings.errorTitle,
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  label: _Strings.newCommands,
                  controller: commandsTE,
                  type: TextFormFieldType.command,
                ),
              ],
            ),
          ),
          primaryButtonLabel: _Strings.saveButton,
          onPressedPrimaryButton: () {
            if (formKey.currentState!.validate()) {
              onPressedPrimaryBtn(commandsTE.text);
              context.pop();
            }
          },
          secondaryButtonLabel: _Strings.closeButton,
          titleIcon: Icons.edit,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mars_rover_mission/core/commons/ui/widgets/export_widgets.dart';

class _Strings {
  static const errorTitle = 'Ups!';
  static const errorCloseButton = 'Close';
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
          secondaryButtonLabel: secondaryButtonLabel ?? _Strings.errorTitle,
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
          secondaryButtonLabel: _Strings.errorCloseButton,
          titleIcon: Icons.error_outline,
        );
      },
    );
  }
}

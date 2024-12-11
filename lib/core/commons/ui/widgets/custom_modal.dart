import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mars_rover_mission/core/commons/ui/styles/export_styles.dart';

class _Constants {
  static const double borderRadius = 32;
}

class CustomModal extends StatelessWidget {
  final String? title;
  final String? primaryButtonLabel;
  final String? secondaryButtonLabel;
  final VoidCallback? onPressedPrimaryButton;
  final VoidCallback? onPressedSecondaryButton;
  final Widget? content;
  final bool barrierDismissible;
  final IconData? titleIcon;
  final MainAxisAlignment? actionsAlignment;

  const CustomModal({
    super.key,
    this.title,
    this.primaryButtonLabel,
    this.secondaryButtonLabel,
    this.onPressedPrimaryButton,
    this.onPressedSecondaryButton,
    this.content,
    this.barrierDismissible = true,
    this.titleIcon,
    this.actionsAlignment = MainAxisAlignment.end,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: CustomColors.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          _Constants.borderRadius,
        ),
      ),
      insetPadding: const EdgeInsets.all(
        Spaces.spaceM,
      ),
      titlePadding: const EdgeInsets.only(
        left: Spaces.spaceXS,
        top: Spaces.spaceXS,
        right: Spaces.spaceXXS,
      ),
      title: _buildTitle(context),
      content: content,
      actionsAlignment: actionsAlignment,
      actions: [
        if (secondaryButtonLabel != null)
          TextButton(
            child: Text(
              secondaryButtonLabel!,
            ),
            onPressed: () {
              onPressedSecondaryButton?.call();
              if (context.canPop()) {
                context.pop();
              }
            },
          ),
        if (primaryButtonLabel != null)
          FilledButton(
            child: Text(primaryButtonLabel!),
            onPressed: () {
              onPressedPrimaryButton?.call();
              if (context.canPop()) {
                context.pop();
              }
            },
          ),
      ],
    );
  }

  Widget get _titleWidget => title != null
      ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.titleHeight,
                horizontalTitleGap: Spaces.spaceXXS,
                title: Text(
                  title!,
                ),
                leading: titleIcon != null
                    ? Icon(
                        titleIcon,
                        color: Colors.black,
                      )
                    : null,
                contentPadding: const EdgeInsets.all(
                  Spaces.spaceXXXS,
                ),
              ),
            ),
          ],
        )
      : const SizedBox.shrink();

  Widget _buildTitle(BuildContext context) {
    if (!barrierDismissible) {
      return _titleWidget;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: _titleWidget,
        ),
        if (barrierDismissible)
          const Padding(
            padding: EdgeInsets.only(
              top: Spaces.spaceXXS,
            ),
            child: CloseButton(
              color: Colors.black,
            ),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_shadows.dart';
import '../../app/theme/app_typography.dart';

enum FinsightButtonVariant { filled, tonal }

/// Pill-shaped button. [filled] is forest green, [tonal] is pale mint.
///
/// When [expanded] is true the button fills the available width. If the
/// parent gives unbounded width, it safely falls back to its content width.
class FinsightPrimaryButton extends StatelessWidget {
  const FinsightPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.variant = FinsightButtonVariant.filled,
    this.expanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final FinsightButtonVariant variant;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    final filled = variant == FinsightButtonVariant.filled;
    final bg = filled ? AppColors.forest : AppColors.mint;
    final fg = filled ? Colors.white : AppColors.forest;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bounded = constraints.hasBoundedWidth;
        final fill = expanded && bounded;

        final text = Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.button.copyWith(color: fg),
        );

        final content = Row(
          mainAxisSize: fill ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              Icon(leadingIcon, color: fg, size: 22),
              const SizedBox(width: 10),
            ],
            if (bounded) Flexible(child: text) else text,
            if (trailingIcon != null) ...[
              const SizedBox(width: 10),
              Icon(trailingIcon, color: fg, size: 22),
            ],
          ],
        );

        return Semantics(
          button: true,
          enabled: enabled,
          label: label,
          child: Opacity(
            opacity: enabled ? 1 : 0.5,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                boxShadow: filled && enabled ? AppShadows.button : null,
              ),
              child: Material(
                color: bg,
                shape: const StadiumBorder(),
                child: InkWell(
                  customBorder: const StadiumBorder(),
                  onTap: onPressed,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 56,
                      minWidth: fill ? constraints.maxWidth : 0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Center(
                        widthFactor: fill ? null : 1,
                        heightFactor: 1,
                        child: content,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

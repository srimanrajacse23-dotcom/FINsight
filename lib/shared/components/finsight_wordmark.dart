import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';

class FinsightWordmark extends StatelessWidget {
  const FinsightWordmark({
    super.key,
    this.size = 34,
    this.showMark = false,
    this.showTagline = false,
  });

  final double size;
  final bool showMark;
  final bool showTagline;

  @override
  Widget build(BuildContext context) {
    final wordmark = RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'FIN',
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.w800,
              color: AppColors.forestDeep,
              letterSpacing: -1.5,
            ),
          ),
          TextSpan(
            text: 'sight',
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.w500,
              color: AppColors.forest,
              letterSpacing: -1.2,
            ),
          ),
        ],
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showMark) ...[
          Container(
            width: size + 12,
            height: size + 12,
            decoration: BoxDecoration(
              gradient: AppColors.heroGradient,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.bar_chart_rounded,
              color: Colors.white,
              size: size * 0.65,
            ),
          ),
          const SizedBox(width: 10),
        ],
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              wordmark,
              if (showTagline)
                Text(
                  'YOUR FINANCIAL COMPANION',
                  style: AppTypography.overline.copyWith(
                    fontSize: 9,
                    letterSpacing: 1.5,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

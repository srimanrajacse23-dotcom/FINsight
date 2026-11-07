import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/responsive/finsight_layout.dart';
import '../../shared/components/finsight_hero_card.dart';
import '../../shared/components/finsight_primary_button.dart';
import '../../shared/components/finsight_wordmark.dart';

/// Single branded welcome screen.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = FinLayout.of(constraints.maxWidth) != FinFormFactor.mobile;

        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.page,
                vertical: AppSpacing.xl,
              ),
              child: Center(
                child: FinContentFrame(
                  maxWidth: wide ? 1000 : FinLayout.formMaxWidth,
                  child: wide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: _Copy(
                                showPreview: false,
                                onStart: () => _start(context),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xxxl),
                            const Expanded(child: _FinancialPreview()),
                          ],
                        )
                      : _Copy(
                          showPreview: true,
                          onStart: () => _start(context),
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _start(BuildContext context) => context.go(AppRoutes.profileSelection);
}

class _Copy extends StatelessWidget {
  const _Copy({required this.showPreview, required this.onStart});

  final bool showPreview;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FinsightWordmark(size: 32, showMark: true, showTagline: true),
        const SizedBox(height: AppSpacing.xxl),
        Text.rich(
          TextSpan(
            style: AppTypography.display,
            children: [
              const TextSpan(text: 'Smarter Choices for a '),
              TextSpan(
                text: 'Brighter Tomorrow',
                style: AppTypography.display.copyWith(color: AppColors.gold),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const Text(
          'Manage your money, track your goals and build a better '
          'financial future, all in one place.',
          style: AppTypography.body,
        ),
        if (showPreview) ...[
          const SizedBox(height: AppSpacing.xl),
          const _FinancialPreview(),
        ],
        const SizedBox(height: AppSpacing.xl),
        FinsightPrimaryButton(
          label: 'Get started',
          trailingIcon: Icons.arrow_forward_rounded,
          onPressed: onStart,
        ),
        const SizedBox(height: AppSpacing.md),
        const Text(
          'FINsight V1 is a simulated ecosystem. No real money moves.',
          style: AppTypography.caption,
        ),
      ],
    );
  }
}

/// Decorative preview with no real balance or currency values.
class _FinancialPreview extends StatelessWidget {
  const _FinancialPreview();

  static const double _chartHeight = 72;

  static const List<double> _bars = [0.35, 0.55, 0.42, 0.7, 0.5, 0.85, 0.65];

  @override
  Widget build(BuildContext context) {
    return FinsightHeroCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your financial overview',
            style: AppTypography.body.copyWith(
              color: AppColors.textOnDarkMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ExcludeSemantics(
            child: FractionallySizedBox(
              widthFactor: 0.55,
              alignment: Alignment.centerLeft,
              child: Container(
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          ExcludeSemantics(
            child: SizedBox(
              height: _chartHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (var i = 0; i < _bars.length; i++)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Container(
                          height: _chartHeight * _bars[i],
                          decoration: BoxDecoration(
                            color: i == _bars.length - 2
                                ? AppColors.gold
                                : Colors.white.withValues(alpha: 0.22),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text(
              'Simulated preview',
              style: AppTypography.caption.copyWith(
                color: AppColors.goldSoft,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

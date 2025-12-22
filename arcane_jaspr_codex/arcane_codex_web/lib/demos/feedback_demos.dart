import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Demo builders for feedback components
class FeedbackDemos {
  static List<Component> dialog() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.lg,
            background: Background.surface,
            borderRadius: Radius.lg,
            raw: {'box-shadow': 'var(--arcane-shadow-lg)'},
          ),
          children: [
            ArcaneColumn(
              gapSize: Gap.md,
              children: [
                ArcaneHeading.h3(child: ArcaneText('Dialog Title')),
                ArcaneText('Dialog content goes here.'),
                ArcaneRow(
                  gapSize: Gap.sm,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ArcaneButton.ghost(label: 'Cancel', onPressed: () {}),
                    ArcaneButton.primary(label: 'Confirm', onPressed: () {}),
                  ],
                ),
              ],
            ),
          ],
        ),
      ];

  static List<Component> alertBanner() => [
        ArcaneAlertBanner(
          message: 'This is an alert message',
          variant: AlertVariant.info,
        ),
        ArcaneAlertBanner(
          message: 'Success message',
          variant: AlertVariant.success,
        ),
      ];
}

import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Demo builders for feedback components
class FeedbackDemos {
  static List<Component> statusBadge() => [
        ArcaneRow(
          gapSize: Gap.md,
          children: [
            ArcaneStatusBadge.success('All Systems Operational'),
            ArcaneStatusBadge.warning('Degraded Performance'),
            ArcaneStatusBadge.error('Service Down'),
          ],
        ),
        ArcaneDiv(
          styles: const ArcaneStyleData(margin: MarginPreset.topMd),
          children: [
            ArcaneRow(
              gapSize: Gap.md,
              children: [
                ArcaneStatusBadge.info('Maintenance Scheduled'),
                ArcaneStatusBadge.offline('Offline'),
              ],
            ),
          ],
        ),
        ArcaneDiv(
          styles: const ArcaneStyleData(margin: MarginPreset.topMd),
          children: [
            ArcaneRow(
              gapSize: Gap.md,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ArcaneStatusBadge.success('Small', size: StatusBadgeSize.sm),
                ArcaneStatusBadge.success('Medium', size: StatusBadgeSize.md),
                ArcaneStatusBadge.success('Large', size: StatusBadgeSize.lg),
              ],
            ),
          ],
        ),
      ];

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

  static List<Component> emailDialog() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.md,
            background: Background.surface,
            borderRadius: Radius.md,
          ),
          children: [
            ArcaneColumn(
              gapSize: Gap.sm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ArcaneText('Email Dialog', weight: FontWeight.bold),
                ArcaneText('Collect email addresses with validation', color: TextColor.muted),
                ArcaneButton.secondary(
                  label: 'Open Email Dialog',
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ];

  static List<Component> timeDialog() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.md,
            background: Background.surface,
            borderRadius: Radius.md,
          ),
          children: [
            ArcaneColumn(
              gapSize: Gap.sm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ArcaneText('Time Dialog', weight: FontWeight.bold),
                ArcaneText('Time picker in dialog format', color: TextColor.muted),
                ArcaneButton.secondary(
                  label: 'Open Time Dialog',
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ];

  static List<Component> itemPicker() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.md,
            background: Background.surface,
            borderRadius: Radius.md,
          ),
          children: [
            ArcaneColumn(
              gapSize: Gap.sm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ArcaneText('Item Picker', weight: FontWeight.bold),
                ArcaneText('Select from a list of items', color: TextColor.muted),
                ArcaneButton.secondary(
                  label: 'Open Item Picker',
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ];
}

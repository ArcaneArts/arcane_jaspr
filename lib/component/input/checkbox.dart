import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;
import '../../util/tools/styles.dart';

/// Checkbox input component
class Checkbox extends StatelessComponent {
  final bool checked;
  final String? label;
  final String? description;
  final String size;
  final String checkedColor;
  final bool disabled;

  const Checkbox({
    required this.checked,
    this.label,
    this.description,
    this.size = '20px',
    this.checkedColor = '#10B981',
    this.disabled = false,
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '12px',
        'cursor': disabled ? 'not-allowed' : 'pointer',
        'opacity': disabled ? '0.5' : '1',
      }),
      [
        // Checkbox box
        div(
          styles: Styles(raw: {
            'width': size,
            'height': size,
            'border-radius': '6px',
            'background': checked ? checkedColor : 'transparent',
            'border': checked
                ? '2px solid $checkedColor'
                : '2px solid rgba(63, 63, 70, 0.8)',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'flex-shrink': '0',
            'transition': 'all 0.15s ease',
          }),
          [
            if (checked)
              span(
                styles: Styles(raw: {
                  'color': '#FFFFFF',
                  'font-size': 'calc($size * 0.6)',
                  'font-weight': '700',
                  'line-height': '1',
                }),
                [text('✓')],
              ),
          ],
        ),
        // Label and description
        if (label != null || description != null)
          div(
            styles: Styles(raw: {
              'flex': '1',
            }),
            [
              if (label != null)
                span(
                  styles: Styles(raw: {
                    'font-size': '14px',
                    'font-weight': '500',
                    'color': '#FAFAFA',
                    'display': 'block',
                  }),
                  [text(label!)],
                ),
              if (description != null)
                span(
                  styles: Styles(raw: {
                    'font-size': '13px',
                    'color': '#A1A1AA',
                    'display': 'block',
                    'margin-top': '2px',
                  }),
                  [text(description!)],
                ),
            ],
          ),
      ],
    );
  }
}

/// Radio button component
class Radio extends StatelessComponent {
  final bool selected;
  final String? label;
  final String? description;
  final String size;
  final String selectedColor;
  final bool disabled;

  const Radio({
    required this.selected,
    this.label,
    this.description,
    this.size = '20px',
    this.selectedColor = '#10B981',
    this.disabled = false,
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '12px',
        'cursor': disabled ? 'not-allowed' : 'pointer',
        'opacity': disabled ? '0.5' : '1',
      }),
      [
        // Radio circle
        div(
          styles: Styles(raw: {
            'width': size,
            'height': size,
            'border-radius': '50%',
            'background': 'transparent',
            'border': selected
                ? '2px solid $selectedColor'
                : '2px solid rgba(63, 63, 70, 0.8)',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'flex-shrink': '0',
            'transition': 'all 0.15s ease',
          }),
          [
            if (selected)
              div(
                styles: Styles(raw: {
                  'width': 'calc($size * 0.5)',
                  'height': 'calc($size * 0.5)',
                  'border-radius': '50%',
                  'background': selectedColor,
                }),
                [],
              ),
          ],
        ),
        // Label and description
        if (label != null || description != null)
          div(
            styles: Styles(raw: {
              'flex': '1',
            }),
            [
              if (label != null)
                span(
                  styles: Styles(raw: {
                    'font-size': '14px',
                    'font-weight': '500',
                    'color': '#FAFAFA',
                    'display': 'block',
                  }),
                  [text(label!)],
                ),
              if (description != null)
                span(
                  styles: Styles(raw: {
                    'font-size': '13px',
                    'color': '#A1A1AA',
                    'display': 'block',
                    'margin-top': '2px',
                  }),
                  [text(description!)],
                ),
            ],
          ),
      ],
    );
  }
}

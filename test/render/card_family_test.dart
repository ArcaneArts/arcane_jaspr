// Proves the M2 orphaned-card family (Feature/CTA/Testimonial) renders
// end-to-end under all three stylesheets.

import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr_neon/arcane_jaspr_neon.dart';
import 'package:arcane_jaspr_neubrutalism/arcane_jaspr_neubrutalism.dart';
import 'package:arcane_jaspr_shadcn/arcane_jaspr_shadcn.dart';
import 'package:jaspr_test/server_test.dart';

Future<String> _render(
  ServerTester tester,
  ArcaneStylesheet sheet,
  Widget child,
) async {
  tester.pumpComponent(ArcaneThemeProvider(stylesheet: sheet, child: child));
  final DocumentResponse res = await tester.request('/');
  expect(res.statusCode, 200, reason: res.body);
  return res.body;
}

void main() {
  for (final (String name, ArcaneStylesheet sheet, String prefix)
      in <(String, ArcaneStylesheet, String)>[
        ('shadcn', const ShadcnStylesheet(), 'arcane'),
        ('neon', const NeonStylesheet(), 'neon'),
        ('neubrutalism', const NeubrutalismStylesheet(), 'neubrutalism'),
      ]) {
    testServer('FeatureCard renders under $name', (ServerTester tester) async {
      final String html = await _render(
        tester,
        sheet,
        const FeatureCard(
          title: 'Blazing Fast',
          description: 'Sub-millisecond responses.',
          showCta: true,
        ),
      );
      expect(html.contains('$prefix-feature-card'), isTrue);
      expect(html.contains('Blazing Fast'), isTrue);
      expect(html.contains('Sub-millisecond responses.'), isTrue);
    });

    testServer('CtaCard renders under $name', (ServerTester tester) async {
      final String html = await _render(
        tester,
        sheet,
        const CtaCard(
          title: 'Request a Game',
          description: "Don't see it? Ask.",
          ctaText: 'Suggest',
        ),
      );
      expect(html.contains('$prefix-cta-card'), isTrue);
      expect(html.contains('Request a Game'), isTrue);
      expect(html.contains('Suggest'), isTrue);
    });

    testServer('TestimonialCard renders under $name', (
      ServerTester tester,
    ) async {
      final String html = await _render(
        tester,
        sheet,
        const TestimonialCard(
          quote: 'Best host ever.',
          authorName: 'Jane Doe',
          authorTitle: 'CTO',
          rating: 5,
          showAccentBorder: true,
        ),
      );
      expect(html.contains('$prefix-testimonial-card'), isTrue);
      expect(html.contains('Best host ever.'), isTrue);
      expect(html.contains('Jane Doe'), isTrue);
    });

    testServer('PricingCard renders under $name', (ServerTester tester) async {
      final String html = await _render(
        tester,
        sheet,
        const PricingCard(
          title: 'Pro',
          price: r'$29',
          buttonText: 'Subscribe',
          features: <String>['Fast', 'Reliable'],
        ),
      );
      expect(html.contains('$prefix-pricing-card'), isTrue);
      expect(html.contains('Pro'), isTrue);
      expect(html.contains(r'$29'), isTrue);
      expect(html.contains('Subscribe'), isTrue);
      expect(html.contains('Fast'), isTrue);
    });
  }
}

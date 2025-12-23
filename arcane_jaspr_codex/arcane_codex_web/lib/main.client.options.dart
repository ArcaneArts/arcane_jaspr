// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/client.dart';

import 'package:arcane_codex_web/components/interactive_demo.dart'
    deferred as _interactive_demo;

/// Default [ClientOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.client.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultClientOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ClientOptions get defaultClientOptions => ClientOptions(
  clients: {
    'interactive_demo': ClientLoader(
      (p) => _interactive_demo.InteractiveDemo(
        componentType: p['componentType'] as String,
      ),
      loader: _interactive_demo.loadLibrary,
    ),
  },
);

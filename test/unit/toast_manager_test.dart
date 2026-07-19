import 'dart:async';

import 'package:arcane_jaspr/component/dialog/toast_manager.dart';
import 'package:jaspr_test/jaspr_test.dart';

void main() {
  final ToastManager manager = ToastManager.instance;

  setUp(manager.dismissAll);
  tearDown(manager.dismissAll);

  test('timed toasts dismiss themselves', () async {
    final String id = manager.success('Saved', duration: 20);

    expect(manager.toasts.map((ToastData toast) => toast.id), contains(id));
    await Future<void>.delayed(const Duration(milliseconds: 80));
    expect(
      manager.toasts.map((ToastData toast) => toast.id),
      isNot(contains(id)),
    );
  });

  test('updating a loading toast starts its new dismiss timer', () async {
    final Completer<void> completer = Completer<void>();
    final String id = manager.promise<void>(
      completer.future,
      loading: 'Saving',
      success: (_) => 'Saved',
      error: (_) => 'Failed',
    );

    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(manager.toasts.map((ToastData toast) => toast.id), contains(id));

    completer.complete();
    await Future<void>.delayed(const Duration(milliseconds: 30));
    manager.update(id, (ToastData toast) => toast.copyWith(duration: 20));
    await Future<void>.delayed(const Duration(milliseconds: 80));

    expect(
      manager.toasts.map((ToastData toast) => toast.id),
      isNot(contains(id)),
    );
  });
}

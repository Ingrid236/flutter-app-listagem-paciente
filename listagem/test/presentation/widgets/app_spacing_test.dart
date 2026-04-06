import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listagem/presentation/widgets/app_spacing.dart';

void main() {
  test('AppSpacing constants should have correct values', () {
    expect(AppSpacing.xs, 4.0);
    expect(AppSpacing.sm, 8.0);
    expect(AppSpacing.md, 16.0);
    expect(AppSpacing.lg, 24.0);
    expect(AppSpacing.xl, 32.0);
  });

  testWidgets('AppSpacing static widgets should have correct sizes', (WidgetTester tester) async {
    const verticalMd = AppSpacing.verticalMd;
    expect(verticalMd is SizedBox, true);
    expect((verticalMd as SizedBox).height, 16.0);

    const horizontalLg = AppSpacing.horizontalLg;
    expect(horizontalLg is SizedBox, true);
    expect((horizontalLg as SizedBox).width, 24.0);
  });
}

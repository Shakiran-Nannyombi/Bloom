import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:bloom/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets('Teacher demo flow reaches dashboard and AI', (tester) async {
    await tester.pumpWidget(const BloomApp());
    await tester.pump();

    expect(find.text('Bloom'), findsWidgets);
    expect(find.text('Teacher Mode'), findsOneWidget);
    expect(find.text('Parent Mode'), findsOneWidget);

    await tester.ensureVisible(find.text('Teacher Mode'));
    await tester.tap(find.text('Teacher Mode'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Teacher Namuli'), findsOneWidget);
    expect(find.text('Understanding Your Cycle'), findsOneWidget);

    await tester.tap(find.text('AI Assist'));
    await tester.pumpAndSettle();

    expect(find.text('AI Co-Pilot'), findsOneWidget);
    expect(
      find.text('How do I explain menstruation simply to my class?'),
      findsOneWidget,
    );
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:kuis1/app.dart';

void main() {
  testWidgets('AppShell menampilkan bottom bar Produk dan Favorit',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Produk Hewan'), findsOneWidget);
    expect(find.text('Produk'), findsOneWidget);
    expect(find.text('Favorit'), findsOneWidget);
  });
}

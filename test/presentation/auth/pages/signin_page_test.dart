import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spotify_clone_tr/presentation/auth/pages/signin.dart';

void main() {
  // 1. setUpAll (isteğe bağlı)
  setUpAll(() {
    print('Test başladı');
  });

  // 2. setUp (her test öncesi çalışır)
  setUp(() {
    print('Yeni test başlıyor');
  });

  // 3. Testler
  testWidgets('SigninPage renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SigninPage()));

    // Örneğin, başlık widget'ını kontrol et
    expect(find.text('Oturum Aç'), findsOneWidget);
  });

  // Başka bir test
  testWidgets('SigninPage has email field', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SigninPage()));
    expect(find.byKey(Key('emailField')), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spotify_clone_tr/presentation/auth/pages/signin.dart';

void main() {
  // Tüm testlerden önce bir kez çalışır
  setUpAll(() {
    print('Test başladı');
  });

  // Her testten önce çalışır
  setUp(() {
    print('Yeni test başlıyor');
  });

  group('SigninPage Widget Tests', () {
    testWidgets('Signin button is rendered and displays correct text', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: SigninPage()));

      final signinButton = find.byKey(const Key('signinButton'));

      // Buton görünür mü?
      expect(signinButton, findsOneWidget);

      // Butonun içinde "Oturum Aç" yazıyor mu?
      expect(
        find.descendant(of: signinButton, matching: find.text('Oturum Aç')),
        findsOneWidget,
      );
    });

    testWidgets('SigninPage has email field', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SigninPage()));

      // Email alanı var mı?
      expect(find.byKey(const Key('emailField')), findsOneWidget);
    });
  });
}

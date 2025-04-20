import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spotify_clone_tr/presentation/auth/pages/signup.dart';

void main() {
  // Test başında yapılacaklar
  setUp(() {
    print('Yeni test başlıyor');
  });

  // Test widget'ını başlatma
  testWidgets('SignupPage has form fields and a signup button', (
    WidgetTester tester,
  ) async {
    // SignupPage widget'ını test etmek için MaterialApp içerisinde render et
    await tester.pumpWidget(
      MaterialApp(
        home: SignupPage(),
        navigatorObservers: [NavigatorObserver()],
      ),
    );

    // Form elemanlarının varlığını kontrol et
    expect(
      find.byKey(Key('signupFullNameField')),
      findsOneWidget,
    ); // Ad Soyad input
    expect(
      find.byKey(Key('signupEmailField')),
      findsOneWidget,
    ); // E-posta input
    expect(
      find.byKey(Key('signupPasswordField')),
      findsOneWidget,
    ); // Şifre input
    expect(
      find.byKey(Key('signupButton')),
      findsOneWidget,
    ); // Hesap Oluştur butonu

    // Buton üzerinde doğru yazıyı kontrol et
    final signupButton = find.byKey(Key('signupButton'));
    expect(
      find.descendant(of: signupButton, matching: find.text('Hesap Oluştur')),
      findsOneWidget,
    );

    // Ekranda "Kayıt Ol" metninin bulunduğunu kontrol et
    expect(find.text('Kayıt Ol'), findsOneWidget);

    // Şimdi formu doldurup butona tıklayalım
    await tester.enterText(find.byKey(Key('signupFullNameField')), 'Test User');
    await tester.enterText(
      find.byKey(Key('signupEmailField')),
      'testuser@example.com',
    );
    await tester.enterText(
      find.byKey(Key('signupPasswordField')),
      'password123',
    );

    // SignUp butonuna tıklayalım
    await tester.tap(find.byKey(Key('signupButton')));
    await tester.pump();
  });
}

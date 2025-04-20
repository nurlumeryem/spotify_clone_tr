import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone_tr/common/widgets/app_bar.dart';
import 'package:spotify_clone_tr/common/widgets/basic_app_button.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_vectors.dart';
import 'package:spotify_clone_tr/core/configs/theme/custom_text_field.dart';
import 'package:spotify_clone_tr/data/models/auth/create_user_req.dart';
import 'package:spotify_clone_tr/domain/usecases/signin_usecase.dart';
import 'package:spotify_clone_tr/presentation/auth/pages/signup.dart';

import 'package:spotify_clone_tr/service_locator.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Widget _registerText() {
    return const Text(
      'Oturum Aç',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }

  Widget _emailField(BuildContext context) {
    return CustomTextField(
      key: const Key('emailField'),
      controller: _email,
      hintText: 'E-posta Adresi',
    );
  }

  Widget _passwordField(BuildContext context) {
    return CustomTextField(
      key: const Key('passwordField'),
      controller: _password,
      hintText: 'Şifre',
    );
  }

  Widget _sigUpText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Üye Değil Misiniz? ',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          TextButton(
            onPressed: () {
              context.go('/signup');
            },
            child: const Text(
              'Hemen Kayıt Ol',
              style: TextStyle(color: Color(0xFF288CE9)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _sigUpText(context),
      appBar: BasicAppbar(
        title: SvgPicture.asset(AppVectors.logo, height: 40, width: 40),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            const SizedBox(height: 50),
            _emailField(context),
            const SizedBox(height: 20),
            _passwordField(context),
            const SizedBox(height: 20),
            BasicAppButton(
              key: const Key('signinButton'),
              onPressed: () async {
                var result = await sl<SigninUseCase>().call(
                  params: CreateUserReq(
                    email: _email.text.toString(),
                    password: _password.text.toString(),
                  ),
                );
                if (result.isSuccess) {
                  // Başarı durumunda home ekranına yönlendirelim
                  context.go('/home');
                } else {
                  // Hata durumunda hata mesajını gösterelim
                  var snackbar = SnackBar(
                    content: Text(result.error ?? "Bir hata oluştu."),
                    behavior: SnackBarBehavior.floating,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }
              },
              title: 'Oturum Aç',
              backgroundColor: const Color(0xFF42C83C),
              height: 73,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

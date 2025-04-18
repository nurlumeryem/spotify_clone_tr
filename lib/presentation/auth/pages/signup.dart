import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone_tr/common/widgets/app_bar.dart';
import 'package:spotify_clone_tr/common/widgets/basic_app_button.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_vectors.dart';
import 'package:spotify_clone_tr/core/configs/theme/custom_text_field.dart';
import 'package:spotify_clone_tr/data/models/auth/create_user_req.dart';
import 'package:spotify_clone_tr/domain/usecases/signup_usecase.dart';
import 'package:spotify_clone_tr/service_locator.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Widget _registerText() {
    return const Text(
      'Kayıt Ol',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField(BuildContext context) {
    return CustomTextField(controller: _fullName, hintText: 'Ad Soyad');
  }

  Widget _emailField(BuildContext context) {
    return CustomTextField(controller: _email, hintText: 'E-posta Adresi');
  }

  Widget _passwordField(BuildContext context) {
    return CustomTextField(controller: _password, hintText: 'Şifre');
  }

  Widget _siginText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Hesabınız var mı? ',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          TextButton(
            onPressed: () {
              context.go('/signin');
            },
            child: const Text(
              'Giriş Yap',
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
      bottomNavigationBar: _siginText(context),
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
            _fullNameField(context),
            const SizedBox(height: 20),
            _emailField(context),
            const SizedBox(height: 20),
            _passwordField(context),
            const SizedBox(height: 20),
            BasicAppButton(
              onPressed: () async {
                var result = await sl<SignupUseCase>().call(
                  params: CreateUserReq(
                    fullName: _fullName.text.toString(),
                    email: _email.text.toString(),
                    password: _password.text.toString(),
                  ),
                );
                if (result.isSuccess) {
                  // Başarı durumunda giriş sayfasına yönlendir
                  context.go('/signin');
                } else {
                  // Hata durumunda snackbar göster
                  var snackbar = SnackBar(
                    content: Text(result.error ?? "Bir hata oluştu."),
                    behavior: SnackBarBehavior.floating,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }
              },
              title: 'Hesap Oluştur',
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

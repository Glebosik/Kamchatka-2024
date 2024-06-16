import 'package:flutter/material.dart';
import 'package:kamchatka/gen/assets.gen.dart';
import 'package:kamchatka/gen/colors.gen.dart';
import 'package:kamchatka/src/auth/login/login_view.dart';
import 'package:kamchatka/src/auth/register/register_view.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: AuthPage());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                left: width * 0.15,
                bottom: 100,
                child: Assets.auth.background.svg(width: width * 0.7)),
            Center(
              child: Column(
                children: [
                  SizedBox(height: height * 0.01),
                  const Text('При поддержке'),
                  SizedBox(height: height * 0.01),
                  const Text('Правительства Камчатского края'),
                  SizedBox(height: height * 0.01),
                  Assets.auth.gerb.svg(height: 100),
                  SizedBox(height: height * 0.05),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Экотропы',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          Text(
                            'Камчатского края',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 26),
                          ),
                        ],
                      ),
                      Assets.auth.ski.svg(),
                    ],
                  ),
                  const Spacer(),
                  const _LoginButton(),
                  SizedBox(height: height * 0.02),
                  const _ForgotPasswordButton(),
                  const Spacer(),
                  const Text(
                    'Впервые у нас?',
                    style: TextStyle(color: ColorName.primary),
                  ),
                  const _SignUpButton(),
                  SizedBox(height: height * 0.05),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return TextButton(
      onPressed: () {}, //TODO: Восстановление пароля
      style: TextButton.styleFrom(fixedSize: Size(width * 0.9, height * 0.05)),
      child: const Text('Восстановить пароль'),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const RegisterPage()),
        );
      },
      style: TextButton.styleFrom(fixedSize: Size(width * 0.9, height * 0.05)),
      child: const Text('Зарегистрироваться'),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      child: const Text(
        'Войти',
      ),
    );
  }
}

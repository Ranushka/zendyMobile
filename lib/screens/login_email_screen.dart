import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy/helpers/helpers.dart';
import 'package:zendy/widgets/widgets.dart';

import 'package:zendy/controllers/controllers.dart';

class LoginEmailScreen extends StatelessWidget {
  final AuthController authCtrl = Get.find();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String _email = "";

  LoginEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 360),
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getLogoImg(140),
                const SizedBox(height: 32),
                _buildEmailForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailForm() {
    Color btnColor = Theme.of(Get.context!).primaryColor;

    return Obx(() {
      return SizedBox(
        width: 400,
        child: Column(
          children: [
            _buildBackButton(),
            const SizedBox(height: 16),
            // LinearProgressIndicator(),
            if (authCtrl.isLoading.value) const LinearProgressIndicator(),
            Container(
              child: TextField(
                style: Theme.of(Get.context!).textTheme.bodyMedium,
                autofocus: true,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ),
            Container(
              child: TextField(
                style: Theme.of(Get.context!).textTheme.bodyMedium,
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: TextButton(
                    onPressed: _passwordReset,
                    child: const TextBody('Forgot?'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildBtn(
              btnColor,
              "Login with Email",
              _loginWithEmailPressed,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _createAccountPressed,
              child: const TextBody('Dont have an account?'),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildBackButton() {
    return Row(
      // direction: Axis.horizontal,
      children: [
        Transform.translate(
          offset: const Offset(-16, 0),
          child: IconButton(
            splashRadius: 24,
            icon: const Icon(FontIcons.arrow_back),
            onPressed: () => Get.back(),
          ),
        ),
        Container(
          child: const Title1('Join with Email'),
        )
      ],
    );
  }

  void _loginWithEmailPressed() {
    var em = _emailController.text;
    var pw = _passwordController.text;

    print('The user wants to login with $em and $pw');
    authCtrl.signIn(em, pw);
  }

  void _createAccountPressed() {
    Get.toNamed('/signup');
  }

  void _passwordReset() {
    print("The user wants a password reset request sent to $_email");
  }
}

Widget _buildBtn(Color color, String text, void Function() onPress) {
  Color btnColor = color;

  return SizedBox(
    width: double.infinity,
    child: Column(
      children: [
        MaterialButton(
          height: 42,
          elevation: 0,
          minWidth: double.infinity,
          color: btnColor,
          splashColor: darken(btnColor, 0.15),
          highlightColor: darken(btnColor, 0.1),
          textColor: Colors.white,
          onPressed: onPress,
          child: BtnText(text),
        )
      ],
    ),
  );
}

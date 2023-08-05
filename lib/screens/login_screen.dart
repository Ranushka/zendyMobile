import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:webview_flutter/webview_flutter.dart';

import 'package:zendy/helpers/helpers.dart';
import 'package:zendy/widgets/widgets.dart';

import 'package:zendy/controllers/controllers.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authCtrl = Get.find();

  LoginScreen({super.key});

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
                const Title1('Sign in'),
                const SizedBox(height: 32),
                _buildUseEmail(),
                const SizedBox(height: 16),
                const Title4('Join with Social logins'),
                const SizedBox(height: 16),
                _buildFacebook(),
                _buildGoogle(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUseEmail() {
    Color btnColor = Theme.of(Get.context!).primaryColor;

    return _buildBtn(
      btnColor,
      "Continue with Email",
      () => Get.toNamed(Goto.loginEmail),
    );
  }

  Widget _buildFacebook() {
    Color btnColor = Color(int.parse('0xFF4267B2'));

    return _buildBtn(
      btnColor,
      "Login with facebook",
      _loginWithFacebookPressed,
    );
  }

  Widget _buildGoogle() {
    Color btnColor = Color(int.parse('0xFFde5246'));

    return _buildBtn(
      btnColor,
      "Login with Google",
      _loginWithFacebookPressed,
    );
  }

  void _loginWithFacebookPressed() {
    // WebView(
    //   initialUrl: 'https://api.staging-oa.zendy.io/auth/facebook/auth',
    //   javascriptMode: JavascriptMode.unrestricted,
    // );
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

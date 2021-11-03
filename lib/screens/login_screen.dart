import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/widgets/widgets.dart';

import 'package:zendy_app/controllers/controllers.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 360),
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getLogoImg(140),
                SizedBox(height: 32),
                Title1('Sign in to Zendy app'),
                SizedBox(height: 32),
                _buildUseEmail(),
                SizedBox(height: 16),
                Title4('Join with Social logins'),
                SizedBox(height: 16),
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
    Color _btnColor = Theme.of(Get.context).primaryColor;

    return _buildBtn(
      _btnColor,
      "Continue with Email",
      () => Get.toNamed(Goto.loginEmail),
    );
  }

  Widget _buildFacebook() {
    Color _btnColor = Color(int.parse('0xFF4267B2'));

    return _buildBtn(
      _btnColor,
      "Login with facebook",
      _loginWithFacebookPressed,
    );
  }

  Widget _buildGoogle() {
    Color _btnColor = Color(int.parse('0xFFde5246'));

    return _buildBtn(
      _btnColor,
      "Login with Google",
      _loginWithFacebookPressed,
    );
  }

  void _loginWithFacebookPressed() {
    WebView(
      initialUrl: 'https://api.staging-oa.zendy.io/auth/facebook/auth',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}

Widget _buildBtn(Color _color, String _text, Function _onPress) {
  Color btnColor = _color;

  return Container(
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
          child: BtnText(_text),
          onPressed: _onPress,
        )
      ],
    ),
  );
}

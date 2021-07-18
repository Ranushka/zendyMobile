import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/widgets/widgets.dart';
// import 'package:get/instance_manager.dart';

import 'package:zendy_app/controllers/controllers.dart';
// import 'package:zendy_app/widgets/product_tile.dart';

class SignInScreen extends StatelessWidget {
  // final LoginController productController = Get.put(LoginController());
  RxBool _usingEmail = false.obs;

  final AuthController authCtrl = Get.find();

  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final String _email = "";
  final String _password = "";

  @override
  Widget build(BuildContext context) {
    _toggleContinueEmail() {
      _usingEmail.value = !_usingEmail.value;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 360),
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo(),
                  SizedBox(height: 32),
                  if (!_usingEmail.value) _buildTitle('Sign in to Zendy app'),
                  if (!_usingEmail.value) SizedBox(height: 32),
                  if (!_usingEmail.value) _buildUseEmail(_toggleContinueEmail),
                  if (!_usingEmail.value) SizedBox(height: 16),
                  if (_usingEmail.value) _buildLoginsEmail(),
                  if (!_usingEmail.value) _buildLoginsSocial(context),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image(
      width: 140,
      image: AssetImage('assets/images/zendy_logo.png'),
    );
  }

  Widget _buildTitle(String _title) {
    return Container(
      child: Title1(_title),
    );
  }

  Widget _buildLoginsEmail() {
    Color _btnColor = Theme.of(Get.context).primaryColor;

    return Container(
      width: 400,
      child: Column(
        children: [
          _buildBackButton(),
          SizedBox(height: 16),
          Container(
            child: TextField(
              autofocus: true,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Email'),
            ),
          ),
          Container(
            child: TextField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: TextButton(
                  // padding: EdgeInsets.all(0),
                  child: Text('Forgot?'),
                  onPressed: _passwordReset,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          _buildBtn(
            _btnColor,
            "Login with Email",
            _loginWithEmailPressed,
          ),
          SizedBox(height: 16),
          TextButton(
            child: Text('Dont have an account?'),
            onPressed: _createAccountPressed,
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return Flex(
      direction: Axis.horizontal,
      children: [
        IconButton(
          splashRadius: 24,
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () => Get.back(),
        ),
        _buildTitle('Join with Email')
      ],
    );
  }

  Widget _buildLoginsSocial(context) {
    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          children: [Title4('Join with Social logins')],
        ),
        SizedBox(height: 16),
        _buildFacebook(),
        _buildGoogle(),
        _buildLinkedin(),
      ],
    );
  }

  Widget _buildUseEmail(_call) {
    Color _btnColor = Theme.of(Get.context).primaryColor;

    return _buildBtn(
      _btnColor,
      "Continue with Email",
      _call,
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

  Widget _buildLinkedin() {
    Color _btnColor = Color(int.parse('0xFF0e76a8'));

    return _buildBtn(
      _btnColor,
      "Login with LinkedIn",
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

  void _loginWithEmailPressed() {
    var _em = _emailController.text;
    var _pw = _passwordController.text;

    print('The user wants to login with $_em and $_pw');
    authCtrl.signIn(_em, _pw);
  }

  void _loginWithFacebookPressed() {
    WebView(
      initialUrl: 'https://api.staging-oa.zendy.io/auth/facebook/auth',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }

  void _createAccountPressed() {
    Get.toNamed('/signup');
  }

  void _passwordReset() {
    print("The user wants a password reset request sent to $_email");
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

// Widget _buildButtons() {
//   return Container(
//     width: double.infinity,
//     child: Column(
//       children: [
//         TextButton(
//           child: Text('Dont have an account?'),
//           onPressed: _createAccountPressed,
//         )
//       ],
//     ),
//   );
// }

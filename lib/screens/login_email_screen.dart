import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zendy_app/helpers/helpers.dart';
import 'package:zendy_app/widgets/widgets.dart';

import 'package:zendy_app/controllers/controllers.dart';

class LoginEmailScreen extends StatelessWidget {
  final AuthController authCtrl = Get.find();

  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final String _email = "";
  final String _password = "";

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
                _buildEmailForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailForm() {
    Color _btnColor = Theme.of(Get.context).primaryColor;

    return Obx(() {
      return Container(
        width: 400,
        child: Column(
          children: [
            _buildBackButton(),
            SizedBox(height: 16),
            // LinearProgressIndicator(),
            if (authCtrl.isLoading.value) LinearProgressIndicator(),
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
    });
  }

  Widget _buildBackButton() {
    return Row(
      // direction: Axis.horizontal,
      children: [
        Transform.translate(
          offset: Offset(-16, 0),
          child: IconButton(
            splashRadius: 24,
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () => Get.back(),
          ),
        ),
        Container(
          child: Title1('Join with Email'),
        )
      ],
    );
  }

  void _loginWithEmailPressed() {
    var _em = _emailController.text;
    var _pw = _passwordController.text;

    print('The user wants to login with $_em and $_pw');
    authCtrl.signIn(_em, _pw);
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/instance_manager.dart';

// import 'package:zendy_app/controllers/auth_controller.dart';
// import 'package:zendy_app/widgets/product_tile.dart';

class SignInScreen extends StatelessWidget {
  // final LoginController productController = Get.put(LoginController());

  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final String _email = "";
  final String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 360),
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTitle(),
              _buildTextFields(),
              _buildButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      width: double.infinity,
      child: Text(
        'Login',
        textScaleFactor: 2,
      ),
    );
  }

  Widget _buildTextFields() {
    return Container(
      width: 400,
      child: Column(
        children: [
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
        ],
      ),
    );
  }

  Widget _buildButtons(context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          MaterialButton(
            minWidth: double.infinity,
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            child: Text("Login"),
            onPressed: _loginPressed,
          ),
          TextButton(
            child: Text('Dont have an account?'),
            onPressed: _createAccountPressed,
          )
        ],
      ),
    );
  }

  void _loginPressed() {
    print('The user wants to login with $_email and $_password');
  }

  void _createAccountPressed() {
    Get.toNamed('/signup');
  }

  void _passwordReset() {
    print("The user wants a password reset request sent to $_email");
  }
}

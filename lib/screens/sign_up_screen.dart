import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zendy/widgets/typography.dart';
// import 'package:get/instance_manager.dart';

// import 'package:zendy/controllers/auth_controller.dart';
// import 'package:zendy/widgets/product_tile.dart';

class SignUpScreen extends StatelessWidget {
  // final LoginController productController = Get.put(LoginController());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String _email = "";
  final String _password = "";

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSkipButton(),
          Container(
            constraints: const BoxConstraints(maxWidth: 360),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTitle(),
                _buildTextFields(),
                _buildButtons(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const SizedBox(
      width: double.infinity,
      child: TextBody('Create account'),
    );
  }

  Widget _buildTextFields() {
    return SizedBox(
      width: 400,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            child: TextField(
              autofocus: true,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ),
          Container(
            child: TextField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
          ),
          Container(
            child: TextField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Confirm password'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildButtons(context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          MaterialButton(
            minWidth: double.infinity,
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: _loginPressed,
            child: const TextBody("Crate account"),
          ),
        ],
      ),
    );
  }

  Widget _buildSkipButton() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              label: const TextBody('Skip'),
              icon: const Icon(Icons.navigate_before_sharp),
              onPressed: _skipCreateAccountPressed,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _loginPressed() {
    print('The user wants to login with $_email and $_password');
  }

  void _skipCreateAccountPressed() {
    Get.toNamed('/');
  }

  void _passwordReset() {
    print("The user wants a password reset request sent to $_email");
  }
}

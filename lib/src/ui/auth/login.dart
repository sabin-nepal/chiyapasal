import 'package:chiyapasal/src/core/res/sizes.dart';
import 'package:chiyapasal/src/core/res/styles.dart';
import 'package:chiyapasal/src/notifier/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _showErrorDialog({String? message}) {
    message = message ?? "Email and Password Required";
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error On Login"),
            content: Text(message!),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email",
                    style: smallBoldText,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Password",
                    style: smallBoldText,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: () => _handleLogin(context),
                      child: const Text("Login"))
                ],
              )),
        ));
  }

  _handleLogin(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return _showErrorDialog();
    }
    try {
      await Provider.of<AuthNotifier>(context, listen: false)
          .signInWithEmailAndPasword(
              email: emailController.text, pasword: passwordController.text);
    } on PlatformException catch (e) {
      _showErrorDialog(message: e.message);
    }
  }
}

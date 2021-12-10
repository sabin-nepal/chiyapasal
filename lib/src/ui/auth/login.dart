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
  final _formData = {"email": "", "password": ""};

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
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (val) => _formData['email'] = val!,
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
                    obscureText: true,
                    onSaved: (val) => _formData['email'] = val!,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: () => _handleLogin, child: const Text("Login"))
                ],
              )),
        ));
  }

  _handleLogin() async {
    if (_formData['email'] == null || _formData['password'] == null) {
      _showErrorDialog();
    }
    try {
      await Provider.of<AuthNotifier>(context, listen: false)
          .signInWithEmailAndPasword(
              email: _formData['email']!, pasword: _formData['password']!);
    } on PlatformException catch (e) {
      _showErrorDialog(message: e.message);
    }
  }
}

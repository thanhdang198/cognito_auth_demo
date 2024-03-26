import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:ekycdemo/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/input_field.dart';
import '../http/aws_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool isLoading = false;
  bool showPassword = false;
  CognitoUserSession? session;
  @override
  void initState() {
    emailController = TextEditingController();
    // TextEditingController(text: 'dangtrongthanh1998@gmail.com');
    passwordController = TextEditingController();
    // TextEditingController(text: 'Thanh@1998');
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Cognito auth')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(children: [
            InputField(
                controller: emailController,
                isPassword: false,
                labelTxt: 'Email',
                icon: Icons.person),
            const SizedBox(height: 20),
            InputField(
                controller: passwordController,
                isPassword: !showPassword,
                labelTxt: 'Password',
                suffix: InkWell(
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    child: showPassword
                        ? Icon(
                            Icons.no_encryption_outlined,
                            color: primaryColor,
                          )
                        : Icon(
                            Icons.lock_outline,
                            color: primaryColor,
                          )),
                icon: Icons.lock),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () =>
                        login(emailController.text, passwordController.text),
                child: isLoading
                    ? const CupertinoActivityIndicator()
                    : const Text('Login')),
            session != null
                ? Expanded(
                    child: SingleChildScrollView(
                    child: Column(
                      children: [
                        rowWidget(
                            'accessToken.payload: ${session!.accessToken.payload!}'),
                        const Divider(indent: 20, endIndent: 20, thickness: 3),
                        rowWidget(
                            'jwtAccessToken: ${session!.accessToken.jwtToken!}'),
                        const Divider(indent: 20, endIndent: 20, thickness: 3),
                        rowWidget(
                            'TokenUse: ${session!.accessToken.getTokenUse()!}'),
                        const Divider(indent: 20, endIndent: 20, thickness: 3),
                        rowWidget(
                            'idToken.jwtToken: ${session!.idToken.jwtToken!}'),
                        const Divider(indent: 20, endIndent: 20, thickness: 3),
                        rowWidget(
                            'refreshToken.token: ${session!.refreshToken?.token!}'),
                      ],
                    ),
                  ))
                : const SizedBox.shrink()
          ]),
        ),
      ),
    );
  }

  login(String email, String password) async {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      isLoading = true;
    });
    var res = await AWSServices().createInitialRecord(email, password);
    setState(() {
      isLoading = false;
    });
    if (!mounted) return;
    if (res != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Login success')));
      setState(() {
        session = res;
      });
    } else {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: const Text('Login failed'),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'))
                ],
              ));
    }
  }

  copyToClipBoard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  rowWidget(String text) {
    return Row(
      children: [
        Expanded(
          child: Text(text),
        ),
        InkWell(
          child: Icon(
            Icons.copy,
            color: primaryColor,
          ),
          onTap: () {
            copyToClipBoard(text);
          },
        )
      ],
    );
  }
}

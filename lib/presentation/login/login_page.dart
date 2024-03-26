import 'package:amazon_cognito_identity_dart_2/cognito.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/alert_dialog.dart';
import '../../components/copyable_text_widget.dart';
import '../../components/input_field.dart';
import '../../components/show_snack_bar.dart';
import '../../http/aws_services.dart';
import 'widgets/toggle_password_icon.dart';

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
    passwordController = TextEditingController();

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
      onTap: () => unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Cognito auth')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(children: [
            InputField(
                controller: emailController,
                isPassword: false,
                labelText: 'Email',
                prefix: Icons.person),
            const SizedBox(height: 20),
            InputField(
                controller: passwordController,
                isPassword: !showPassword,
                labelText: 'Password',
                suffix: TogglePasswordIcon(
                  isShowPassword: showPassword,
                  onChangeStatus: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
                prefix: Icons.lock),
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
                        CopyableTextWidget(
                            text:
                                'accessToken.payload: ${session!.accessToken.payload!}'),
                        const Divider(indent: 20, endIndent: 20, thickness: 3),
                        CopyableTextWidget(
                            text:
                                'jwtAccessToken: ${session!.accessToken.jwtToken!}'),
                        const Divider(indent: 20, endIndent: 20, thickness: 3),
                        CopyableTextWidget(
                            text:
                                'TokenUse: ${session!.accessToken.getTokenUse()!}'),
                        const Divider(indent: 20, endIndent: 20, thickness: 3),
                        CopyableTextWidget(
                            text:
                                'idToken.jwtToken: ${session!.idToken.jwtToken!}'),
                        const Divider(indent: 20, endIndent: 20, thickness: 3),
                        CopyableTextWidget(
                            text:
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

  void login(String email, String password) async {
    unfocus();
    var res = await AWSServices().createInitialRecord(email, password);

    if (!mounted) return;
    updateLoadingStatus(false);
    res.fold((failure) {
      /// Handle message with failure code here
      showAlertDialog(context, title: 'Login failed', message: failure);
    }, (r) {
      showSnackBar(context, 'Login success');
      setState(() {
        session = r;
      });
    });
  }

  void unfocus() {
    FocusScope.of(context).unfocus();
  }

  void updateLoadingStatus(bool isShowLoading) {
    setState(() => isLoading = isShowLoading);
  }
}

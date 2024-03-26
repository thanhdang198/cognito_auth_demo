import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';

class AWSServices {
  final userPool = CognitoUserPool(
    'eu-west-2_yOqR4zy73',
    '2k210jlg2jlak0sdtrmps3gb2k',
  );

  Future<CognitoUserSession?> createInitialRecord(email, password) async {
    debugPrint('Authenticating User...');
    final cognitoUser = CognitoUser(email, userPool);
    final authDetails = AuthenticationDetails(
      username: email,
      password: password,
    );

    CognitoUserSession? session;
    try {
      // final userAttributes = [
      //   AttributeArg(name: 'first_name', value: 'Thanh'),
      //   AttributeArg(name: 'last_name', value: 'Wong'),
      // ];

      // var data;
      // try {
      //   data = await userPool.signUp(
      //     email,
      //     password,
      //     userAttributes: userAttributes,
      //   );
      // } catch (e) {
      //   print(e);
      // }

      session = await cognitoUser.authenticateUser(authDetails);
      debugPrint('Login Success...');
      return session;
    } on CognitoUserNewPasswordRequiredException catch (e) {
      debugPrint('CognitoUserNewPasswordRequiredException $e');
    } on CognitoUserMfaRequiredException catch (e) {
      debugPrint('CognitoUserMfaRequiredException $e');
    } on CognitoUserSelectMfaTypeException catch (e) {
      debugPrint('CognitoUserMfaRequiredException $e');
    } on CognitoUserMfaSetupException catch (e) {
      debugPrint('CognitoUserMfaSetupException $e');
    } on CognitoUserTotpRequiredException catch (e) {
      debugPrint('CognitoUserTotpRequiredException $e');
    } on CognitoUserCustomChallengeException catch (e) {
      debugPrint('CognitoUserCustomChallengeException $e');
    } on CognitoUserConfirmationNecessaryException catch (e) {
      debugPrint('CognitoUserConfirmationNecessaryException $e');
    } on CognitoClientException catch (e) {
      debugPrint('CognitoClientException $e');
    } catch (e) {
      print(e);
    }
    return null;
  }
}

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:dartz/dartz.dart';
import 'package:ekycdemo/singleton/app_context.dart';

class AWSServices {
  final userPool = CognitoUserPool(
    AppContext().getPoolId(),
    AppContext().getClientId(),
  );

  Future<Either<String, CognitoUserSession?>> createInitialRecord(
      email, password) async {
    final cognitoUser = CognitoUser(email, userPool);
    final authDetails = AuthenticationDetails(
      username: email,
      password: password,
    );

    CognitoUserSession? session;
    try {
      session = await cognitoUser.authenticateUser(authDetails);
      return Right(session);
    } on CognitoUserNewPasswordRequiredException catch (e) {
      return Left('CognitoUserNewPasswordRequiredException $e');
    } on CognitoUserMfaRequiredException catch (e) {
      return Left('CognitoUserMfaRequiredException $e');
    } on CognitoUserSelectMfaTypeException catch (e) {
      return Left('CognitoUserMfaRequiredException $e');
    } on CognitoUserMfaSetupException catch (e) {
      return Left('CognitoUserMfaSetupException $e');
    } on CognitoUserTotpRequiredException catch (e) {
      return Left('CognitoUserTotpRequiredException $e');
    } on CognitoUserCustomChallengeException catch (e) {
      return Left('CognitoUserCustomChallengeException $e');
    } on CognitoUserConfirmationNecessaryException catch (e) {
      return Left('CognitoUserConfirmationNecessaryException $e');
    } on CognitoClientException catch (e) {
      return Left('CognitoClientException $e');
    } catch (e) {
      return Left(e.toString());
    }
  }
}

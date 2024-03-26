import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppContext {
  static final AppContext _singleton = AppContext._internal();
  String? _userPoolId;
  String? _clientId;
  factory AppContext() {
    return _singleton;
  }
  String getPoolId() {
    return _userPoolId ?? '';
  }

  String getClientId() {
    return _clientId ?? '';
  }

  Future<void> initDotEnv() async {
    dotenv.env['userPoolId'];
    dotenv.env['clientId'];
  }

  AppContext._internal();
}

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../model/api_token.dart';
import '../model/applicant.dart';
import '../model/workflow.dart';

class OnfidoApi {
  OnfidoApi._();

  static final instance = OnfidoApi._();

  final String _baseUrl = "https://api.onfido.com";

  String _apiToken = dotenv.get("API_TOKEN");

  Future<void> setCustomApiToken(String customApiToken) async {
    _apiToken = customApiToken;
  }

  Future<Map<String, String>> getHeaders() async {
    return {
      "Authorization": "Token token=$_apiToken",
      "Accept": "application/json",
      "Content-Type": "application/json"
    };
  }

  Future<String> getWorkflowRunId(String applicantId, String workflowId) async {
    if (workflowId.isEmpty) {
      throw Exception(
          'Missing workflow id, please check your .env file or enter it manually');
    }

    final body = jsonEncode(
      {"applicant_id": applicantId, "workflow_id": workflowId},
    );

    final response = await http.post(Uri.parse("$_baseUrl/v3.5/workflow_runs"),
        headers: await getHeaders(), body: body);

    if (response.statusCode == 201) {
      return Workflow.fromJson(jsonDecode(response.body)).id!;
    } else {
      throw Exception('Failed to create workflow run id');
    }
  }

  Future<Applicant> createApplicant(
      String name, String surname, String email) async {
    final body = jsonEncode({
      "application_id": "com.onfido.onfidoFlutterExample",
      "first_name": name,
      "last_name": surname,
      "email": email
    });

    final response = await http.post(Uri.parse("$_baseUrl/v3/applicants"),
        headers: await getHeaders(), body: body);

    if (response.statusCode == 201) {
      return Applicant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create applicant');
    }
  }

  Future<String> createSdkToken(String applicantId) async {
    final body = jsonEncode({
      "application_id": "com.onfido.onfidoFlutterExample",
      "applicant_id": applicantId
    });

    final response = await http.post(Uri.parse("$_baseUrl/v3/sdk_token"),
        headers: await getHeaders(), body: body);

    if (response.statusCode == 200) {
      return ApiToken.fromJson(jsonDecode(response.body)).token!;
    } else {
      throw Exception('Failed to create api token');
    }
  }
}

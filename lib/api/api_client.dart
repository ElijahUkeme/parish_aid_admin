import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:parish_aid_admin/constants/app_url_constants.dart';

class ApiClient {
  late String token;

  static Map<String, String> header = <String, String>{
    'Authorization': 'Bearer: ${AppUrlConstant.TOKEN}',
    'content-type': 'application/json',
    'api-key': AppUrlConstant.API_KEY,
    'Accept': 'application/json'
  };
  static updateHeader(String token) {
    header = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
      'api-key': AppUrlConstant.API_KEY,
    };
  }

  static Future<Map<String, String>> getHeadersFromApClient(
      {bool? jsonRequest, bool tokenized = true}) async {
    if (jsonRequest != null && jsonRequest) {
      return {
        'Content-type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer',
        'Accept': 'application/json'
      };
    } else if (!tokenized) {
      return {
        'Accept': 'application/json',
        'api-key': AppUrlConstant.API_KEY,
      };
    }
    final tokenizedHeader = {
      HttpHeaders.authorizationHeader: 'Bearer',
      'Accept': 'application/json',
      'api-key': AppUrlConstant.API_KEY,
    };
    return tokenizedHeader;
  }

  static Future<Response> postData(String endpoint, dynamic body) async {
    var url = Uri.parse(AppUrlConstant.BASE_URL + endpoint);
    try {
      Response response =
          await post(url, body: json.encode(body), headers: header);
      print("The post response returns ${response.body}");
      return response;
    } catch (e) {
      print(e.toString());
      return Response(e.toString(), 1);
    }
  }
}

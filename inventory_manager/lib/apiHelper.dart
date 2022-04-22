// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:inventory_manager/main.dart';
import 'package:inventory_manager/utils/customException.dart';
import 'package:http/http.dart' as http;

String domainUrl = 'http://localhost:8080';

class ApiHelper {
  // static Future<dynamic> getRequest(
  //     BuildContext context, String endpoint) async {
  //   try {
  //     final _response = await http.get(
  //       Uri.parse("${domainUrl}$endpoint"),
  //       headers: {'Authorization': 'Bearer $token'},
  //     );
  //     if (_response.statusCode == 200) {
  //       final jsonResponseData = jsonDecode(_response.body);
  //       return jsonResponseData;
  //     } else {
  //       throw CustomException(messsage: "Bad Network State");
  //     }
  //   } on HttpException catch (e) {
  //     throw CustomException(messsage: e.message);
  //   } catch (ex) {
  //     throw CustomException(messsage: ex.toString());
  //   }
  // }

  static Future<dynamic> getRequest(String endpoint) async {
    try {
      final _response = await http.get(Uri.parse("$domainUrl/$endpoint"),
          // headers: {"content-type": "application/json"},
          headers: {
            "Accept": "application/json",
            "Access-Control-Allow-Origin": "*"
          });
      if (_response.statusCode == 200) {
        logger.v("Status : Success 200");
        final jsonResponseData = jsonDecode(_response.body);
        return jsonResponseData;
      } else {
        throw const CustomException(messsage: "Bad Network State");
      }
    } on HttpException catch (e) {
      throw CustomException(messsage: e.message);
    } catch (ex) {
      throw CustomException(messsage: ex.toString());
    }
  }

  // static Future<dynamic> postRequest(BuildContext context, String endpoint,
  //     {Map? body}) async {
  //   final String? token = context.read(userCredentialProvider).token;
  //   try {
  //     final _response = await http.post(
  //       Uri.parse("${domainUrl}$endpoint"),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: json.encode(body),
  //     );
  //     if (_response.statusCode == 200) {
  //       final jsonResponseData = jsonDecode(_response.body);
  //       return jsonResponseData;
  //     } else {
  //       throw CustomException(messsage: "Bad Network State");
  //     }
  //   } on HttpException catch (e) {
  //     throw CustomException(messsage: e.message);
  //   } catch (ex) {
  //     throw CustomException(messsage: ex.toString());
  //   }
  // }

  // static Future<bool?> putRequest(
  //     BuildContext context, String endpoint, Map? body) async {
  //   final String? token = context.read(userCredentialProvider).token;
  //   try {
  //     final _response = await http.put(
  //       Uri.parse("${domainUrl}$endpoint"),
  //       headers: {"content-type": "application/json"},
  //       body: json.encode(
  //         body,
  //       ),
  //     );
  //     if (_response.statusCode == 200) {
  //       return true;
  //     } else {
  //       throw CustomException(messsage: "Bad Network State");
  //     }
  //   } on HttpException catch (e) {
  //     throw CustomException(messsage: e.message);
  //   } catch (ex) {
  //     throw CustomException(messsage: ex.toString());
  //   }
  // }
}

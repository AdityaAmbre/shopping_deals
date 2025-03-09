import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_deals/util/logger.dart';

class Api {
  Api();

  /// API Call - HTTP GET
  Future<Map<String, dynamic>?> apiCallHttpGet(String url, {Map<String, String>? headersList}) async {
    final Map<String, dynamic>? data;

    // Host URL
    Logger.log("Host URL:", url);
    final Uri hostUrl = Uri.parse(url);

    // Headers
    final Map<String, String>? headers = headersList;
    Logger.log("Headers:", headers.toString());

    try {
      // API Call
      final response = await http.get(hostUrl, headers: headers);

      // Handle Response
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        Logger.log("Response Success: ", "Data: ${data.toString()}");
        return data;
      } else {
        Logger.log("Response Failure: ", "Status Code: ${response.statusCode}");
        return null;
      }
    } on SocketException catch (e) {
      Logger.log("SocketException: ", e.message);
      rethrow;
    } catch (e) {
      Logger.log("Exception: ", e.toString());
      rethrow;
    }
  }
}
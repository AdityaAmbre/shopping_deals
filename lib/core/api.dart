import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_deals/util/logger.dart';

class Api {
  Api();

  /// API Call - HTTP GET
  Future<Map<String, dynamic>?> apiCallHttpGet({required String baseUrl, required int perPage, required int pageNumber, required String fields, Map<String, String>? headersList}) async {
    final Map<String, dynamic>? data;

    // Host URL
    Logger.log("Base URL:", baseUrl);
    final Uri hostUrl = Uri.parse(baseUrl).replace(
      queryParameters: {
        "per_page": perPage.toString(),
        "page": pageNumber.toString(),
        "fields": fields.toString()
      },
    );
    Logger.log("Host URL:", hostUrl.toString());

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
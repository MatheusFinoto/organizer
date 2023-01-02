import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
// import '/src/stores/base_store.dart';

// const String devUrl = 'https://dev.api.allthentic.imobpower.com';
const String devUrl = '192.168.0.179:30712';
// const String devUrl = '192.168.3.7:3000';

class ApiBaseHelper {
  final String _baseUrl = devUrl;
  // final BaseStore baseStore = GetIt.I<BaseStore>();
  var client = http.Client();

  final Map<String, String> header = {
    // "Accept": "application/json",
    // "Content-Type": "application/json",
  };

  Future<http.Response> get(
      {required String endpoint, Map<String, String>? queryParams}) async {
    http.Response response;
    try {
      Uri url = Uri.parse('http://$_baseUrl$endpoint');

      response = await client.get(url, headers: header);
    } on TimeoutException {
      throw http.ClientException;
    } on SocketException {
      throw http.ClientException;
    }
    return response;
  }

  Future<http.Response> post(
      String endpoint, String body, Map<String, String> header) async {
    http.Response response;

    try {
      Uri url = Uri(scheme: 'https', host: devUrl, path: endpoint);
      response = await client.post(url, body: body, headers: header);
      return response;
    } on SocketException {
      throw http.Response;
    } catch (e) {
      throw http.Response;
    }
  }

  Future<http.Response> put(
      String endpoint, String body, Map<String, String> header) async {
    http.Response response;

    try {
      var url = Uri.https(_baseUrl, endpoint);

      response = await http
          .put(
        url,
        headers: header,
        body: body,
      )
          .timeout(const Duration(seconds: 120), onTimeout: () {
        throw TimeoutException('put timeout exceeded');
      });
    } on SocketException {
      throw http.ClientException;
    }
    return response;
  }

  // Future<dynamic> delete(String endpoint) async {
  //   var responseJson;

  //   try {
  //     var url = Uri.parse('$_baseUrl$endpoint');

  //     final response = await http
  //         .delete(
  //       url,
  //       headers: baseStore.getHeader(),
  //     )
  //         .timeout(Duration(seconds: 120), onTimeout: () {
  //       throw TimeoutException('put timeout exceeded');
  //     });

  //     responseJson = jsonDecode(response.body);
  //   } on SocketException {
  //     throw FetchDataException('No Internet connection');
  //   }
  //   return responseJson;
  // }

}

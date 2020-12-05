import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class HTTPClient {
  Future<Map<String, dynamic>> postJSONRequest({String url, Map data}) async {
    final String jsonRequest = json.encode(data);

    final String response = await postRequest(url: url, data: jsonRequest);

    return json.decode(response) as Map<String, dynamic>;
  }

  Future<String> postRequest({String url, String data}) async {
    final HttpClient client = HttpClient();

    try {
      final HttpClientRequest request = await client.postUrl(Uri.parse(url));
      debugPrint('url ${url}');
      debugPrint('request ${data}');
      request.headers.set('Content-type', 'application/json; charset=utf-8');
      request.write(data);
      final HttpClientResponse response = await request.close();
      final String sResponse = await response.transform(utf8.decoder).join();
      debugPrint('response ${sResponse}');

      return sResponse;
    } catch (e) {
      debugPrint('error=>');
      debugPrint('e ${e}');
      return json.encode({'status': 'failed', 'data': ''});
    }
  }
}

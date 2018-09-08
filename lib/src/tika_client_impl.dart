import 'dart:async';

import 'package:http_client/http_client.dart';
import 'package:tika_client/tika_client.dart';

class TikaClientImpl implements TikaClient {
  final String _url;
  final Client _client;

  TikaClientImpl(String url, Client client)
      : _url = url.endsWith('/') ? url.substring(0, url.length - 1) : url,
        _client = client;

  @override
  Future<String> parseBufferAsHtmlText(List<int> buffer) async {
    final rq = new Request('PUT', '$_url/tika',
        headers: {'Accept': 'text/html'}, body: buffer);
    final rs = await _client.send(rq);
    return await rs.readAsString();
  }
}

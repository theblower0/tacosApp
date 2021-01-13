import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tacos_app/models/product.dart';
import 'package:tacos_app/models/response.dart';
import 'package:tacos_app/screens/admin/admin_options/upload_image.dart';

class Network {
  static String _url = "http://192.168.0.8/tacos-app/public/";
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'))['token'];
  }

  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http.get(fullUrl, headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/jason',
        //'api_token': '$token'
      };

  uploadImage(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  Future<GetResponse> createProduct(data) async {
    final response = await http.post('$_url/menu/addProduct',
        headers: _setHeaders(), body: jsonEncode(data));
    if (response.statusCode == 200) {
      final String responseString = response.body;

      return getResponseFromJson(responseString);
    } else {
      return null;
    }
  }

  Future<GetResponse> updateProduct(data) async {
    final response = await http.post('$_url/menu/updateProduct',
        headers: _setHeaders(), body: jsonEncode(data));
    if (response.statusCode == 200) {
      final String responseString = response.body;

      return getResponseFromJson(responseString);
    } else {
      return null;
    }
  }
}

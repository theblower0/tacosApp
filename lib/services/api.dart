import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tacos_app/models/response.dart';

class Network {
  static String _url = "https://taquemaster.000webhostapp.com";
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

  Future<GetResponse> deleteProduct(data) async {
    final response = await http.post('$_url/menu/deleteProduct',
        headers: _setHeaders(), body: jsonEncode(data));
    if (response.statusCode == 200) {
      final String responseString = response.body;

      return getResponseFromJson(responseString);
    } else {
      return null;
    }
  }

  Future<GetResponse> deleteOrder(data) async {
    final response = await http.post('$_url/orders/deleteOrder',
        headers: _setHeaders(), body: jsonEncode(data));
    if (response.statusCode == 200) {
      final String responseString = response.body;

      return getResponseFromJson(responseString);
    } else {
      return null;
    }
  }

  Future<GetResponse> addOrderBackup(data) async {
    final response = await http.post('$_url/orderBackup/addOrderBackup',
        headers: _setHeaders(), body: jsonEncode(data));
    if (response.statusCode == 200) {
      final String responseString = response.body;

      return getResponseFromJson(responseString);
    } else {
      return null;
    }
  }

  Future<GetResponse> createOrder(data) async {
    final response = await http.post('$_url/orders/addOrder',
        headers: _setHeaders(), body: jsonEncode(data));
    if (response.statusCode == 200) {
      final String responseString = response.body;

      return getResponseFromJson(responseString);
    } else {
      return null;
    }
  }

  addDetailOrder(data) async {
    return await http.post('$_url/detailOrder/addDetailOrder',
        headers: _setHeaders(), body: jsonEncode(data));
  }

  getID() async {
    return await http.get(
      '$_url/orders/getId',
    );
  }
}

import 'package:http/http.dart' as http;
import 'package:tacos_app/models/orders_data.dart';

class LocationRemoteDataSource {
  static const String url =
      "https://taquemaster.000webhostapp.com/orders/viewOrdersWithDetail";
  static Future<List<OrdersData>> getLocations() async {
    print('En el getLocations');

    try {
      final response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('dentro del if');
        print(response.body);
        print('en el response body');
        final List<OrdersData> orders = ordersDataFromJson(response.body);
        //final List<Location> locations = new List<Location>();
        print(orders.length);
        return orders;
      } else {
        return List<OrdersData>();
      }
    } catch (e) {
      return List<OrdersData>();
    }
  }
}

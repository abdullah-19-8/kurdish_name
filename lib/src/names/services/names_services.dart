import 'package:flutter_api/src/Names/Models/models.dart';
import 'package:flutter_api/src/Names/Models/get_set_data.dart';
import 'package:http/http.dart' as http;

class NamesServices {
  Future<KurdishName> fetchListNames() async {
    Uri namesUri = Uri(
        scheme: "https",
        host: "kurdishName.com",
        path: "api",
        queryParameters: {
          "limit": Values.LimitV,
          "gender": Values.GenderV,
          "sort": Values.SortV,
          "offset": "0"
        });

    http.Response response =
        await http.get(namesUri).catchError((err) => print(err.message.toString()));
    KurdishName jsNames = KurdishName.fromJson(response.body);
    return jsNames;
  }
}

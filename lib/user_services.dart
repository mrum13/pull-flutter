import 'dart:convert';

import 'package:pull_to_refresh_app/user_model.dart';
import 'package:http/http.dart' as http;

class UserServices {

  Future<List<DataListUser>> getDataUser({required String page}) async {
    //API from https://dummyapi.io/
    //app-id : you can get with sign into dummyapi.io

    var url = 'https://dummyapi.io/data/v1/user?limit=7&page=$page';
    var header = {
      'Accept': 'application/json',
      'app-id': '6456fe9a51ec60c0da2221fe'
    };

    var response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    print(page);

    var data = jsonDecode(response.body);

    try {
      List allUser = json.decode(response.body)['data'];
        List<DataListUser> allNameUser = [];

        for (var item in allUser) {
          allNameUser.add(DataListUser.fromJson(item));
        }

        return allNameUser;
    } catch (e) {
      rethrow;
    }

  }
}
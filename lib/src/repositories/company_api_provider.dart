import 'dart:convert';

import 'package:flutter_app/src/models/company_info_model.dart';
import 'package:http/http.dart';

class CompanyApiProvider {
  Client client = Client();

  Future<CompanyInfo> fetchCompanyInfo() async {
    final response =
        await client.get("https://flutter-bar.api.mocked.io/company");
    if (response.statusCode == 200) {
      return CompanyInfo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load action list.');
    }
  }
}

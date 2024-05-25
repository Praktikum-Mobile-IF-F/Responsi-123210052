import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:responsi/models/kopi.dart';

class KopiService {
  static const String baseUrl = 'https://fake-coffee-api.vercel.app/api';

  Future<List<Coffee>?> fetchCoffee() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        final List<Coffee> kopiList = jsonResponse.map((item) => Coffee.fromJson(item)).toList();
        return kopiList;
      } else {
        print('Failed to load jobs: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching jobs: $e');
      return null;
    }
  }
}
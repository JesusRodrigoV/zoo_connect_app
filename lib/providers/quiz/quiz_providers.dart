import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final sessionTokenProvider = FutureProvider.autoDispose<String?>((ref) async {
  final tokenUrl = 'https://opentdb.com/api_token.php?command=request';
  try {
    final response = await http.get(Uri.parse(tokenUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['response_code'] == 0) {
        return data['token'];
      }
    }
  } catch (e) {
    print('Error al obtener el token de sesión: $e');
  }
  return null;
});

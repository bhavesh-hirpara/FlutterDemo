import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'todos_screen.dart';

class NetworkUtil {
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = JsonDecoder();

  Future<dynamic> get(String url) {
    return http.get(url).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw Exception('Error while feching data');
      }

      return _decoder.convert(response.body);
    });
  }

  Future<dynamic> post(String url, { Map headers, body, encoding }) {
    return http.post(url, headers: headers, body: body, encoding: encoding)
        .then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw Exception('Error while feching data');
      }

      return _decoder.convert(response.body);
    });
  }

  Future<dynamic> uploadImage(String url, File image, { Map headers, body, encoding }) {

    return null;
  }

}

class ApiClient {
  NetworkUtil _networkUtil = new NetworkUtil();

  static const BASE_URL = 'https://jsonplaceholder.typicode.com/';
  static const GET_TODO = BASE_URL + 'todos';

  Future<Todo> fetchTodo(int id) async {
    return await _networkUtil.get('$GET_TODO/$id').then((dynamic response) {
      return Todo.fromJson(response);
    });
  }

  Future<List<Todo>> fetchTodos() async {
    return await _networkUtil.get(GET_TODO).then((dynamic response) {
      Iterable list = response;
      return list.map((model) => Todo.fromJson(model)).toList();
    });
  }

}
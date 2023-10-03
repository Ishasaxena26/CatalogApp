// import 'dart:convert';
// import 'api.dart';
// //import 'package:flutter_catalog/pages/modelss.dart';
// import 'package:flutter/material.dart';
// import '/models/catalog.dart';
// import 'package:http/http.dart' as http;

// class CatalogProvider with ChangeNotifier {
//   List<Item> _items = [];

//   List<Item> get items {
//     return [..._items];
//   }

//   fetchTasks() async {
//     // static const String baseUrl = 'http://127.0.0.1:8000/catalog/';
//     // final response = await http.get(Uri.parse(baseUrl + 'cataloglist/'));
//     final url = 'http://127.0.0.1:8000/catalog/cataloglist/?format=json';
//     final response = await http.get(Uri.parse(api));
//     if (response.statusCode == 200) {
//       var data = json.decode(response.body) as List;
//       _items = data.map<Item>((json) => Item.fromMap(json)).toList();
//     }
//   }
// }
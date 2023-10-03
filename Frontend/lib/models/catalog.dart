// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CatalogModel {
  static List<Item> items = [];

  get get=>null;
  //get items by id
  Item getById(int id) =>
      items.firstWhere((element) => element.id == id, orElse: null);

//get item by position
  Item getByPosition(int pos) => items[pos];
}

class Item {
  final int id;
  final String name;
  final String desc;
  final num price;
  final String color;
  final String image;

//below entire code is written by the dart class generator extension
  Item({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.color,
    required this.image,
  });

//constructor: to decode....we have made class from map
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as int,
    // id: int.parse(map['id']),
      name: map['name'] as String,
      desc: map['desc'] as String,
     // price: map['price'] as num,
      price: double.parse(map['price']), // Convert the price from string to doubles
      color: map['color'] as String,
      image: map['image'] as String,
    );
  }
// /*
//   //to encode: making map from class:
//   toMap() => {
//         "id": id,
//         "name": name,
//         "desc": desc,
//         "price": price,
//         "color": color,
//         "image": image
//       };*/

  Item copyWith({
    int? id,
    String? name,
    String? desc,
    num? price,
    String? color,
    String? image,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      price: price ?? this.price,
      color: color ?? this.color,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'desc': desc,
      'price': price,
      'color': color,
      'image': image,
    };
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Item(id: $id, name: $name, desc: $desc, price: $price, color: $color, image: $image)';
  }

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.desc == desc &&
        other.price == price &&
        other.color == color &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        desc.hashCode ^
        price.hashCode ^
        color.hashCode ^
        image.hashCode;
  }
}


// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import '/models/catalog.dart';
// import 'package:http/http.dart' as http;

// class CatalogModel {
  /*
  //singleton class creation .....with this only one object will be made and any changes will be applied in that object only
  static final catModel = CatalogModel._internal();
  CatalogModel._internal();
  factory CatalogModel() => catModel;
  */

//   static List<Item> items = [];

//   get get => null;

// //get items by id
//   Item getById(int id) =>
//       items.firstWhere((element) => element.id == id, orElse: null);

// //get item by position
//   Item getByPosition(int pos) => items[pos];
// }

// class Item {
//   final int id;
//   final String name;
//   final String desc;
//   final num price;
//   final String color;
//   final String image;

// //below entire code is written by the dart class generator extension
//   Item({
//     required this.id,
//     required this.name,
//     required this.desc,
//     required this.price,
//     required this.color,
//     required this.image,
//   });

// //constructor: to decode....we have made class from map
//   factory Item.fromMap(Map<String, dynamic> map) {
//     return Item(
//       id: map['id'] as int,
//       name: map['name'] as String,
//       desc: map['desc'] as String,
//       price: map['price'] as num,
//       color: map['color'] as String,
//       image: map['image'] as String,
//     );
//   }
// /*
//   //to encode: making map from class:
//   toMap() => {
//         "id": id,
//         "name": name,
//         "desc": desc,
//         "price": price,
//         "color": color,
//         "image": image
//       };*/

//   Item copyWith({
//     int? id,
//     String? name,
//     String? desc,
//     num? price,
//     String? color,
//     String? image,
//   }) {
//     return Item(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       desc: desc ?? this.desc,
//       price: price ?? this.price,
//       color: color ?? this.color,
//       image: image ?? this.image,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'name': name,
//       'desc': desc,
//       'price': price,
//       'color': color,
//       'image': image,
//     };
//   }

//   String toJson() => json.encode(toMap());

//   factory Item.fromJson(String source) =>
//       Item.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'Item(id: $id, name: $name, desc: $desc, price: $price, color: $color, image: $image)';
//   }

//   @override
//   bool operator ==(covariant Item other) {
//     if (identical(this, other)) return true;

//     return other.id == id &&
//         other.name == name &&
//         other.desc == desc &&
//         other.price == price &&
//         other.color == color &&
//         other.image == image;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         name.hashCode ^
//         desc.hashCode ^
//         price.hashCode ^
//         color.hashCode ^
//         image.hashCode;
//   }
// }

// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;

// class Item {
//   final int id;
//   final String name;
//   final String desc;
//   final double price;
//   final String colour;
//   final String image;


//   Item({
//     required this.id,
//     required this.name,
//     required this.desc,
//     required this.price,
//     required this.colour,
//     required this.image,
//   });

//   // Map<String, dynamic> toMap() {
//   //   return {
//   //     'id': id,
//   //     'name': name,
//   //     'description': desc,
//   //     'price': price,
//   //     'colour': colour,
//   //     'image': image,
//   //   };
//   // }

//   // factory Item.fromMap(Map<String, dynamic> json) {
//   //   return Item(
//   //     id: json['id'],
//   //     name: json['name'],
//   //     desc: json['description'],
//   //     price: json['price'],
//   //     colour: json['colour'],
//   //     image: json['image'],
//   //   );
//   }
// }

// // class CatalogService {
// //   static const String baseUrl = 'http://127.0.0.1:8000/catalog/';

// //   static Future<List<Item>> fetchCatalogItems() async {
// //     final response =
// //         await http.get(Uri.parse(baseUrl + 'cataloglist?format=json/'));

// //     if (response.statusCode == 200) {
// //       final List<dynamic> jsonData = jsonDecode(response.body);

// //       List<Item> catalogItems = [];
// //       for (var itemData in jsonData) {
// //         Item item = Item.fromMap(itemData);
// //         catalogItems.add(item);
// //       }
// //       return catalogItems;
// //     } else {
// //       throw Exception('Failed to load catalog items');
// //     }
//     // return jsonData.map((item) => Item.fromMap(item)).toList();
//     // }
//     // else {
//     // throw Exception('Failed to load catalog items');
//   //}

//   static Future<Item> createCatalogItem({
//     required String name,
//     required String desc,
//     required double price,
//     required String colour,
//     required String image,
//     required String token,
//   }) async {
//     final response = await http.post(
//       Uri.parse(baseUrl + 'create/'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//       body: jsonEncode({
//         'name': name,
//         'description': desc,
//         'price': price,
//         'colour': colour,
//         'image': image,
//       }),
//     );

//     if (response.statusCode == 201) {
//       return Item.fromMap(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to create catalog item');
//     }
//   }

//   static Future<Item> updateCatalogItem({
//     required int id,
//     required String name,
//     required String desc,
//     required double price,
//     required String colour,
//     required String image,
//     required String token,
//   }) async {
//     final response = await http.put(
//       Uri.parse(baseUrl + 'update/$id/'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//       body: jsonEncode({
//         'name': name,
//         'description': desc,
//         'price': price,
//         'colour': colour,
//         'image': image,
//       }),
//     );

//     if (response.statusCode == 200) {
//       return Item.fromMap(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to update catalog item');
//     }
//   }

//   static Future<void> deleteCatalogItem({
//     required int id,
//     required String token,
//   }) async {
//     final response = await http.delete(
//       Uri.parse(baseUrl + 'delete/$id/'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );

//     if (response.statusCode != 204) {
//       throw Exception('Failed to delete catalog item');
//     }
//   }
// }
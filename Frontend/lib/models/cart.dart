import 'package:flutter_catalog/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

import '../core/store.dart';

class CartModel {
  /*
  //singleton class creation .....with this only one object will be made and any changes will be applied in that object only
  static final cartModel = CartModel._internal();
  CartModel._internal();
  factory CartModel() => cartModel;
  */

  //catalog field
  late CatalogModel _catalog;

  //Collection of IDs -store Idds of each item
  final List<int> _itemIds = [];
  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    assert(newCatalog != null);
    _catalog = newCatalog;
  }

  //get items in the cart
  List<Item> get items => _itemIds.map((id) => _catalog.getById(id)).toList();

  //get total price
  num get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

/*
  //add items to cart
  void add(Item item) {
    _itemIds.add(item.id);
  }
  */
/*
  //remove items from cart
  void remove(Item item) {
    _itemIds.remove(item.id);
  }*/
}

class AddMutation extends VxMutation<MyStore> {
  final Item item;

  AddMutation(this.item);

  @override
  perform() {
    // TODO: implement perform
    store!.cart._itemIds.add(item.id);
  }
}

class RemoveMutation extends VxMutation<MyStore> {
  final Item item;

  RemoveMutation(this.item);

  @override
  perform() {
    // TODO: implement perform
    store!.cart._itemIds.remove(item.id);
  }
}
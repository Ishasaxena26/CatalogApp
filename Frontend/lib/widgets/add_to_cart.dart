import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

import '../core/store.dart';
import '../models/cart.dart';
import '../models/catalog.dart';

class AddToCart extends StatelessWidget {
  final Item catalog;
  AddToCart({
    super.key,
    required this.catalog,
  });

  @override
  Widget build(BuildContext context) {
    VxState.watch(
      context,
      on: [AddMutation, RemoveMutation],
    );

    final CartModel _cart = (VxState.store as MyStore).cart;
    //final CatalogModel _catalog = (VxState.store as MyStore).catalog;

    bool isInCart = _cart.items.contains(catalog) ?? false;
    return ElevatedButton(
      onPressed: () {
        if (!isInCart) {
          // _cart.catalog = _catalog;
          //_cart.add(catalog);
          //setState(() {});
          AddMutation(catalog);
        }
      },
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            MyTheme.darkBluishColor,
          ),
          shape: MaterialStateProperty.all(StadiumBorder())),
      // child: isInCart ? Icon(Icons.done) : "Add to cart".text.make(),
      child: isInCart ? Icon(Icons.done) : Icon(CupertinoIcons.cart_badge_plus),
    );
  }
}


//substitute code
    /*return VxBuilder(
        mutations: {AddMutation},
        builder: (context, , _) {
          final CartModel _cart = (VxState.store as MyStore).cart;
          final CatalogModel _catalog = (VxState.store as MyStore).catalog;

          bool isInCart = _cart.items.contains(catalog) ?? false;
          return ElevatedButton(
            onPressed: () {
              if (!isInCart) {
                AddMutation(catalog);
              }
            },
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  MyTheme.darkBluishColor,
                ),
                shape: MaterialStateProperty.all(StadiumBorder())),
            // child: isInCart ? Icon(Icons.done) : "Add to cart".text.make(),
            child: isInCart
                ? Icon(Icons.done)
                : Icon(CupertinoIcons.cart_badge_plus),
          );
        });
  }
}*/
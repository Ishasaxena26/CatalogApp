import 'package:flutter/material.dart';
import 'package:flutter_catalog/models/catalog.dart';

class ItemWidget extends StatelessWidget {
  final Item item; //Item is a class

  const ItemWidget({Key? key, required this.item}) //key becomes optional
      : assert(item != null),
        super(
            key:
                key); //assert helps in determining that the value we are passing should not be null

  @override
  Widget build(BuildContext context) {
    return Card(
        //card provides a specific rectangular space to each item ...gives good look and feel
        child: ListTile(
            onTap: () {
              print(
                  "Tapped on ${this.item}"); //print statement for debugging purpose...can remove
            },
            leading:
                Image.network(item.image), //leading generally contains images
            title: Text(item.name),
            subtitle: Text(item.desc),
            trailing: Text("\$${item.price}",
                textScaleFactor: 1.5,
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ))));
  }
}

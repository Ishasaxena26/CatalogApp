import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/widgets/drawer.dart';
import '../core/store.dart';
import '../models/cart.dart';
import '../utils/routes.dart';
import '../widgets/add_to_cart.dart';
import '../widgets/item_widget.dart';
import "package:velocity_x/velocity_x.dart";
import "package:http/http.dart" as http;

import '../widgets/themes.dart';
import 'home_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

final url="http://10.0.2.2:8000/catalog/cataloglist/";

  @override
  void initState() {
    //called before build method
//here we will get the data and pass that data directly to build method
    super.initState();
    loadData(); //userDefined method
    printImageUrls(); // Add this line to print image URLs
  }

  //defining the userdefined method
  /*loadData() async {
    await Future.delayed(Duration(seconds: 2));

    //GETTING data from json:
    //imported services.dart for rootBundle
   // var catalogJson = await rootBundle.loadString(
   //     "assests/files/catalog.json"); //this files takes time so we have to await it
    //rootBundle represents the bundle of assets that are packaged with the Flutter application. It provides access to the resources, such as images, fonts, and other files, included in the assets folder of the application.
    //he loadString() method is called on the rootBundle object to load the contents of a file as a string

final response=await http.get(Uri.parse(url));
final catalogJson=response.body;
    //DECODING DATA :import dart:convert provides a json encoder decoder facility
    final  decodeData = jsonDecode(
        catalogJson); //converts string to Map-json format having key value
    var productsData = decodeData[
        "products"]; //getting only product section form decoded map using [] operator
    if (productsData != null && productsData is List<dynamic>) {
      //List<Item> list= ...use this or below one
      CatalogModel.items = List.from(productsData)
          .map<Item>((item) => Item.fromMap((item)))
          .toList(); //we already have a mapping written for Items
    }
    setState(
        () {}); //if you dont do this build method will not be called again and you cannot see updated list of items
  }
  */
 
 loadData() async {
  try {
    // Fetch data from the backend API using http.get()
    final response = await http.get(Uri.parse(url));

    // Check if the API call was successful
    if (response.statusCode == 200) {
      // Parse the JSON data from the response body
      final catalogJson = response.body;
      print(catalogJson);
      final decodeData = jsonDecode(catalogJson);
      

      // Check if the response is a List<dynamic>
      if (decodeData is List<dynamic>) {
        // Convert the list of items to List<Item> and update CatalogModel.items
        CatalogModel.items = decodeData
            .map<Item>((item) => Item.fromMap(item))
            .toList();

        // Call setState to rebuild the UI with the updated data
        setState(() {});
      } else {
        // Handle the case where the response is not a list
        print("Invalid data format received from the API.");
      }
    } else {
      // Handle the case where the API call failed
      print("Failed to fetch data from the API. Status code: ${response.statusCode}");
    }
  } catch (e) {
    // Handle any exceptions that occurred during the API call
    print("Error while fetching data: $e");
  }
}

void printImageUrls() {
  print("Image URLs:");
  CatalogModel.items.forEach((item) {
    print(item.image);
  });
}

@override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
        //Scaffold widget has a head body and a footer likle in html
        backgroundColor: Theme.of(context).canvasColor,
        floatingActionButton: VxBuilder(
          mutations: {AddMutation, RemoveMutation},
          builder: (context,_, __) => FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, MyRoutes.cartRoute),
            // backgroundColor: MyTheme.darkBluishColor,
            backgroundColor: Theme.of(context).buttonTheme.colorScheme?.primary,
            child: Icon(
              CupertinoIcons.cart,
              color: Colors.white,
            ),
          ).badge(
              color: Vx.red500,
              size: 20,
              count: _cart.items.length,
              textStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
        ),
        body: SafeArea(
          //safearea leaves the top most that is where the battery etc is mentioned and bottom most space
          child: Container(
            padding: Vx.m24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CatalogHeader(),
                if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                  CatalogList().py16().expand()
                else
                  CircularProgressIndicator().centered().expand(),
              ],
            ),
          ),
        ));
  }
}





 

class CatalogHeader extends StatelessWidget {
  const CatalogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, //content shld start from left side
      children: [
        "Catalog App".text.xl4.bold.color(MyTheme.darkBluishColor).make(),
        "Trending products".text.xl.color(MyTheme.darkBluishColor).make(),
      ],
    );
  }
}

class CatalogList extends StatelessWidget {
  const CatalogList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        //shrinkWrap: true, //for scrolling
        scrollDirection: Axis.vertical,
        itemCount: CatalogModel.items.length,
        itemBuilder: (context, index) {
          //final catalog = CatalogModel.getByPosition(index);
          final catalog = CatalogModel.items[index];
          //return CatalogItem(catalog: catalog);
          return InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeDetailPage(
                          catalog: catalog,
                        ))),
            child: CatalogItem(catalog: catalog),
          );
        });
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;

  const CatalogItem({Key? key, required this.catalog})
      : assert(catalog != null),
        super(key: key);

@override
  Widget build(BuildContext context) {
    return VxBox(
        child: Row(
      children: [
        Hero(
          tag: Key(catalog.id.toString()),
          child: CatalogImage(imageUrl: catalog.image),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              catalog.name.text.lg.color(MyTheme.darkBluishColor).bold.make(),
              catalog.desc.text.textStyle(context.captionStyle).make(),
              10.heightBox,
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                buttonPadding: EdgeInsets.zero,
                children: [
                  "\$${catalog.price}".text.bold.xl.make(),
                  AddToCart(catalog: catalog)
                ],
              ).pOnly(right: 8.0)
            ],
          ),
        )
      ],
    )).color(context.cardColor).roundedLg.square(150).make().py16();
  }
}
  
class CatalogImage extends StatelessWidget {
  final String imageUrl;
  const CatalogImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
    ).box.rounded.p8.color(MyTheme.creamColor).make().p16().w40(context);
  }
}


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_catalog/models/cart.dart';

// import 'dart:convert';
// import 'package:flutter_catalog/models/catalog.dart';

// import "package:velocity_x/velocity_x.dart";

// import '../api/auth/api.dart';
// import '../core/store.dart';
// import '../utils/routes.dart';
// import '../widgets/add_to_cart.dart';
// import '../widgets/themes.dart';
// import 'home_detail_page.dart';
// import 'package:http/http.dart' as http;

// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {

// List<Item> myitems =[];
// bool isloading = true;
// void fetchData()async {
//   try{
//     http.Response response= await http.get(Uri.parse(api));
//     var data= json.decode(response.body);
//     data.forEach((item) {  
//       Item i = Item(
//       id: item['id'],
//       name: item['name'],
//       desc:item ['desc'],
//       price: item['price'],
//       color:item ['colour'],
//       image:item ['image'],
//       );
//       myitems.add(i);
//     }) ;
//     print(myitems.length);
//     setState(() {
//       isloading = false;
//     }
//     );
//     // print(data.runtimeType);
//     // print(response.body.runtimeType);
//   }
//   catch(e)
//   {
//     print("Error is $e");
//   }
// }
//   @override
//   void initState() {
//     fetchData();


//     //called before build method
// //here we will get the data and pass that data directly to build method
//     super.initState();
//     loadData(); //userDefined method
//   }

//   // //defining the userdefined method
//   // loadData() async {
//   //   await Future.delayed(Duration(seconds: 2));

//   //   //GETTING data from json:
//   //   //imported services.dart for rootBundle
//   //   var catalogJson = await rootBundle.loadString(
//   //       "assests/files/catalog.json"); //this files takes time so we have to await it
//   //   //rootBundle represents the bundle of assets that are packaged with the Flutter application. It provides access to the resources, such as images, fonts, and other files, included in the assets folder of the application.
//   //   //he loadString() method is called on the rootBundle object to load the contents of a file as a string

//   //   //DECODING DATA :import dart:convert provides a json encoder decoder facility
//   //   var decodeData = jsonDecode(
//   //       catalogJson); //converts string to Map-json format having key value
//   //   var productsData = decodeData[
//   //       "products"]; //getting only product section form decoded map using [] operator
//   //   if (productsData != null && productsData is List<dynamic>) {
//   //     //List<Item> list= ...use this or below one
//   //     CatalogModel.items = List.from(productsData)
//   //         .map<Item>((item) => Item.fromMap((item)))
//   //         .toList(); //we already have a mapping written for Items
//   //   }
//   //   setState(
//   //       () {}); //if you dont do this build method will not be called again and you cannot see updated list of items
//   // }


// loadData() async {
//     try {
//       // Fetch data from the backend API using CatalogService
//       List<Item> items = await CatalogService.fetchCatalogItems();
//       CatalogModel.items =
//           items.map<Item>((item) => Item.fromMap(item.toMap())).toList();
//       // CatalogModel.items = items;
//       print(CatalogModel.items); // Add this line to check if data is present
//       setState(() {});
//     } catch (e) {
//       // Handle error
//     }
//   }


//   @override
//   Widget build(BuildContext context) {
//     final _cart = (VxState.store as MyStore).cart;
//     return Scaffold(
//         //Scaffold widget has a head body and a footer likle in html
//         backgroundColor: Theme.of(context).canvasColor,
//         floatingActionButton: VxBuilder(
//           mutations: {AddMutation, RemoveMutation},
//           builder: (context, _, __) => FloatingActionButton(
//             onPressed: () => Navigator.pushNamed(context, MyRoutes.cartRoute),
//             // backgroundColor: MyTheme.darkBluishColor,
//             backgroundColor: Theme.of(context).buttonTheme.colorScheme?.primary,
//             child: Icon(
//               CupertinoIcons.cart,
//               color: Colors.white,
//             ),
//           ).badge(
//               color: Vx.red500,
//               size: 20,
//               count: _cart.items.length,
//               textStyle: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               )),
//         ),
//         body: SafeArea(
//           //safearea leaves the top most that is where the battery etc is mentioned and bottom most space
//           child: Container(
//             padding: Vx.m24,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CatalogHeader(),
//                 if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
//                   CatalogList().py16().expand()
//                 else
//                   CircularProgressIndicator().centered().expand(),
//               ],
//             ),
//           ),
//         ));
//   }
// }

// class CatalogHeader extends StatelessWidget {
//   const CatalogHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment:
//           CrossAxisAlignment.start, //content shld start from left side
//       children: [
//         "Catalog App".text.xl4.bold.color(MyTheme.darkBluishColor).make(),
//         //"Catalog App".text.xl4.bold.color()).make(),
//         "Trending products".text.xl.color(MyTheme.darkBluishColor).make(),
//       ],
//     );
//   }
// }

// class CatalogList extends StatelessWidget {
//   const CatalogList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         shrinkWrap: true, //for scrolling
//         itemCount: CatalogModel.items.length,
//         itemBuilder: (context, index) {
//           //final catalog = CatalogModel.getByPosition(index);
//           final catalog = CatalogModel.items[index];
//           //return CatalogItem(catalog: catalog);
//           return InkWell(
//             onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => HomeDetailPage(
//                           catalog: catalog,
//                         ))),
//             child: CatalogItem(catalog: catalog),
//           );
//         });
//   }
// }

// class CatalogItem extends StatelessWidget {
//   final Item catalog;

//   const CatalogItem({Key? key, required this.catalog})
//       : assert(catalog != null),
//         super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return VxBox(
//         child: Row(
//       children: [
//         Hero(
//           tag: Key(catalog.id.toString()),
//           child: CatalogImage(image: catalog.image),
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               catalog.name.text.lg.color(MyTheme.darkBluishColor).bold.make(),
//               catalog.desc.text.textStyle(context.captionStyle).make(),
//               10.heightBox,
//               ButtonBar(
//                 alignment: MainAxisAlignment.spaceBetween,
//                 buttonPadding: EdgeInsets.zero,
//                 children: [
//                   "\$${catalog.price}".text.bold.xl.make(),
//                   AddToCart(catalog: catalog)
//                 ],
//               ).pOnly(right: 8.0)
//             ],
//           ),
//         )
//       ],
//     )).color(context.cardColor).roundedLg.square(150).make().py16();
//   }
// }

// class CatalogImage extends StatelessWidget {
//   final String image;
//   const CatalogImage({Key? key, required this.image}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Image.network(
//       image,
//     ).box.rounded.p8.color(context.canvasColor).make().p16().w40(context);
//   }
// }


// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_catalog/pages/catalog_container.dart';
// import 'package:velocity_x/velocity_x.dart';

// import '../api/auth/api.dart';
// import 'package:http/http.dart'as http;

// import '../core/store.dart';
// import '../models/cart.dart';
// import '../models/items.dart';
// import '../utils/routes.dart';
// import '../widgets/themes.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {

// List<Item> myitems =[];
// bool isloading = true;
// void fetchData()async {
//   try{
//     http.Response response= await http.get(Uri.parse(api));
//     var data= json.decode(response.body);
//     data.forEach((item) {  
//       Item i = Item(
//       id: item['id'],
//       name: item['name'],
//       desc:item ['desc'],
//       price: item['price'],
//       color:item ['colour'],
//       image:item ['image'],
//       );
//       myitems.add(i);
//     }) ;
//     print(myitems.length);
//     setState(() {
//       isloading = false;
//     }
//     );
//     // print(data.runtimeType);
//     // print(response.body.runtimeType);
//   }
//   catch(e)
//   {
//     print("Error is $e");
//   }
// }

// @override
//   void initState() {
//     // TODO: implement initState
// fetchData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//   final _cart = (VxState.store as MyStore).cart;
//     return Scaffold(
//         //Scaffold widget has a head body and a footer likle in html
//         backgroundColor: Theme.of(context).canvasColor,
//         floatingActionButton: VxBuilder(
//           mutations: {AddMutation, RemoveMutation},
//           builder: (context, _,__) => FloatingActionButton(
//             onPressed: () => Navigator.pushNamed(context, MyRoutes.cartRoute),
//             // backgroundColor: MyTheme.darkBluishColor,
//             backgroundColor: Theme.of(context).buttonTheme.colorScheme?.primary,
//             child: Icon(
//               CupertinoIcons.cart,
//               color: Colors.white,
//             ),
//           ).badge(
//               color: Vx.red500,
//               size: 20,
//               count: _cart.items.length,
//               textStyle: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               )),
//         ),
//         body: SafeArea(
//           //safearea leaves the top most that is where the battery etc is mentioned and bottom most space
//           child: Container(
//             padding: Vx.m24,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CatalogHeader(),
//                 isloading? CircularProgressIndicator(): 
//                 ListView(
//                   children: myitems.map((e){
//                     return CatalogContainer(id: e.id, name: e.name, desc: e.desc, price: e.price, color: e.color, image: e.image);
//                   }).toList(),
//                 )
//                 // if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
//                   // CatalogList().py16().expand()
//                 // else
//                   // CircularProgressIndicator().centered().expand(),
//               ],
//             ),
//           ),
//         ));
//   }
// }

// class CatalogHeader extends StatelessWidget {
//   const CatalogHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment:
//           CrossAxisAlignment.start, //content shld start from left side
//       children: [
//         "Catalog App".text.xl4.bold.color(MyTheme.darkBluishColor).make(),
//         //"Catalog App".text.xl4.bold.color()).make(),
//         "Trending products".text.xl.color(MyTheme.darkBluishColor).make(),
//       ],
//     );
//   }
// }

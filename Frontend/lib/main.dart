import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_catalog/pages/cart_page.dart';
import 'package:flutter_catalog/pages/home_page.dart';
import 'package:flutter_catalog/pages/login_page.dart';
import 'package:flutter_catalog/pages/register_page.dart';
import 'package:flutter_catalog/widgets/themes.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'api/auth/auth_api.dart';
import 'constant.dart';
import 'core/store.dart';
import 'models/user_cubit.dart';
import 'models/user_models.dart';
 void main() //entry point of flutter application
 async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
   runApp(VxState(store: MyStore(), child: MyApp()));
 }

 class MyApp extends StatelessWidget {
  @override
     Widget build(BuildContext context) {
//     //all the UI related work is done in  build

  return  BlocProvider(
      create: (context) {
        return UserCubit(User());},
  child:MaterialApp(
       //MaterialApp is a widget to create root level UI of the application.
       //home: HomePage(), SEE routes
       themeMode: ThemeMode.light,
       theme:
           MyTheme.lightTheme(context), //made Mytheme class in themes.dart file
       darkTheme: MyTheme.darkTheme(context), //calling the functions
       debugShowCheckedModeBanner: false,
       //with the help of this we can show can page as the first page of the app
      /* home: FutureBuilder(
              future: Hive.openBox(tokenBox),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var box = snapshot.data;
                  var token = box!.get("token");
                  if (token != null) {
                    return FutureBuilder<User?>(
                        future: getUser(token),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data != null) {
                              return LoginPage();
                            } else {
                              return LoginPage();
                            }
                          } else {
                            return LoginPage();
                          }
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                } else {
                  return LoginPage();
                }
              }),*/
              home: const SplashScreen(),

              

          routes: {
            //"/": (context) =>
            //  LoginPage(), //this is the object.we can also write new LoginPage()
            MyRoutes.homeRoute: (context) => HomePage(),
            MyRoutes.loginRoute: (context) => LoginPage(),
            MyRoutes.registerRoute: (context) => RegisterPage(),
            MyRoutes.cartRoute: (context) => CartPage(),
          },
        ));
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column
      (children: [
        Expanded(child: 
        Image.asset("assests/images/catalog.jpg",
        ),
        ),
        
        //const Text('Catalog App',style: TextStyle(fontSize:40, fontWeight: FontWeight.bold, color: Colors.white))
      ],
      ), 
      backgroundColor: Colors.black,
      splashIconSize: 250,
      nextScreen: FutureBuilder(
              future: Hive.openBox(tokenBox),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var box = snapshot.data;
                  var token = box!.get("token");
                  if (token != null) {
                    return FutureBuilder<User?>(
                        future: getUser(token),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data != null) {
                              return LoginPage();
                            } else {
                              return LoginPage();
                            }
                          } else {
                            return LoginPage();
                          }
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                } else {
                  return LoginPage();
                }
              }),);
  }
}
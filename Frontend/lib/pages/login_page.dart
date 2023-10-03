
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_catalog/api/auth/auth_api.dart';
import 'package:flutter_catalog/pages/register_page.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/user_cubit.dart';
import '../models/user_models.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  String name = '';
  bool changeButton = false;
  //with the help of this we can refresh the entire page
  //underscore sign before the class name denotes it is private i.e it cannot be accessed outside this file

  TextEditingController? controller;

  final _formKey = GlobalKey<FormState>();
  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(
          Duration(seconds: 1)); //wait for 1 second then move to homeRoute page
      await Navigator.pushNamed(context, MyRoutes.homeRoute);
      setState(() {
        //when user goes/clicks back again login text will appear on the button
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: context.canvasColor,
        child: SingleChildScrollView(
            //for small screen we can scroll the page down otherwise content will be cut
            child: Form(
                key: _formKey,
                child: Column(children: [
                  //a list-we can add many things in it
                  Image.asset(
                    "assests/images/hey.png",
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    //creates empty space between two widgets
                    height: 20.0, //gives space between image and text
                  ),
                  // Text("Welcome $name",
                  Text("Welcome $name",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Padding(
                      //Method2:used padding instaed of sizedBox to give the spacing between username and password
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 32.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: "Enter email",
                              labelText: "Email",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email cannot be empty';
                              }
                              return null; //else null will be returned if validateed
                            },
                            //onChanged: (value) {
                            //onchanged denotes that whenever we make changes to the textfield then callback i.e (value) will invoke
                            // setState(() {
                            //   name = value;
                            // });
                            //setState works only in case of stateful widget not in stateless widget.This calls the 'build' method again.
                            //so the use of this piece of code is that whenever we enter something in username it will appear along with the Welcome text
                            // },
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Enter password",
                              labelText: "Password",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password cannot be empty';
                              } else if (value.length < 6) {
                                return 'Password cannot be so small';
                              }
                              return null; //else null will be returned if validateed
                            },
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Material(
                            //Inkwell should be wrapped in Material
                            color: Colors.deepPurple,
                            //      borderRadius:
                            //       BorderRadius.circular(changeButton ? 50 : 8),
                            child: InkWell(
                              //widgets are made clickable with inkwell
                              //for login button
                              //onTap: () => moveToHome(context),
                              onTap: () async {
                                var authRes = await userAuth(
                                    emailController.text,
                                    passwordController.text);
                                if (authRes.runtimeType == String) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Container(
                                            alignment: Alignment.center,
                                            height: 200,
                                            width: 250,
                                            decoration: BoxDecoration(),
                                            child: Text(authRes)),
                                      );
                                    },
                                  );
                                } else if (authRes.runtimeType == User) {
                                  User user = authRes;
                                  context.read<UserCubit>().emit(user);
                                  moveToHome(context);
                                }
                              },

                              child: AnimatedContainer(
                                duration: Duration(seconds: 1),
                                width: changeButton
                                    ? 50
                                    : 150, //conditional statement...if changebutton is true then width changes to  50 else 150 ..this will happen with an animation
                                height: 50,
                                alignment: Alignment.center,
                                child:
                                    changeButton //conditional statement that when button is clicked show the icon otherwise text will be displayed
                                        ? Icon(
                                            Icons.done,
                                            color: Colors.white,
                                          )
                                        : Text(
                                            "Login",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                /* shape: changeButton
                              ? BoxShape.circle
                              : BoxShape.rectangle,*/
                                /* borderRadius:
                                BorderRadius.circular(changeButton ? 50 : 8),*/ //this property should be in Material
                              ),
                            ),
                          ),

                          /* ElevatedButton(
                      child: Text("Login"),
                      style: TextButton.styleFrom(minimumSize: Size(150, 40)),
                      onPressed: () {
                        Navigator.pushNamed(
                            context,
                            MyRoutes
                                .homeRoute); //with the help of this statement when we press on the login button we will be directed to home page
                      }, //function to be invoked
                    )*/
                          /* Container(
                            margin: EdgeInsets.only(
                              top: 30,
                              bottom: 74,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [*/
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()),
                              );
                            },
                            child: Text(
                              "Don't have an account? Sign Up",
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ))
                ]))));
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_catalog/utils/routes.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   String name = '';
//   bool changeButton = false;
//   //with the help of this we can refresh the entire page
//   //underscore sign before the class name denotes it is private i.e it cannot be accessed outside this file

//   final _formKey = GlobalKey<FormState>();
//   moveToHome(BuildContext context) async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         changeButton = true;
//       });
//       await Future.delayed(
//           Duration(seconds: 1)); //wait for 1 second then move to homeRoute page
//       await Navigator.pushNamed(context, MyRoutes.homeRoute);
//       setState(() {
//         //when user goes/clicks back again login text will appear on the button
//         changeButton = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//         color: Colors.white,
//         child: SingleChildScrollView(
//             //for small screen we can scroll the page down otherwise content will be cut
//             child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     //a list-we can add many things in it
//                     Image.asset(
//                       "assests/images/hey.png",
//                       fit: BoxFit.cover,
//                     ),
//                     SizedBox(
//                       //creates empty space between two widgets
//                       height: 20.0, //gives space between image and text
//                     ),
//                     Text("Welcome $name",
//                         style: TextStyle(
//                             fontSize: 22, fontWeight: FontWeight.bold)),
//                     Padding(
//                         //Method2:used padding instaed of sizedBox to give the spacing between username and password
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 16.0, horizontal: 32.0),
//                         child: Column(
//                           children: [
//                             TextFormField(
//                               decoration: InputDecoration(
//                                 hintText: "Enter username",
//                                 labelText: "Username",
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Username cannot be empty';
//                                 }
//                                 return null; //else null will be returned if validateed
//                               },
//                               onChanged: (value) {
//                                 //onchanged denotes that whenever we make changes to the textfield then callback i.e (value) will invoke
//                                 setState(() {
//                                   name = value;
//                                 });
//                                 //setState works only in case of stateful widget not in stateless widget.This calls the 'build' method again.
//                                 //so the use of this piece of code is that whenever we enter something in username it will appear along with the Welcome text
//                               },
//                             ),
//                             TextFormField(
//                               obscureText: true,
//                               decoration: InputDecoration(
//                                 hintText: "Enter password",
//                                 labelText: "Password",
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Password cannot be empty';
//                                 } else if (value.length < 6) {
//                                   return 'Password cannot be so small';
//                                 }
//                                 return null; //else null will be returned if validateed
//                               },
//                             ),
//                             SizedBox(
//                               height: 40.0,
//                             ),
//                             Material(
//                               //Inkwell should be wrapped in Material
//                               color: Colors.deepPurple,
//                               borderRadius:
//                                   BorderRadius.circular(changeButton ? 50 : 8),
//                               child: InkWell(
//                                 //widgets are made clickable with inkwell
//                                 //for login button
//                                 onTap: () => moveToHome(context),
//                                 child: AnimatedContainer(
//                                   duration: Duration(seconds: 1),
//                                   width: changeButton
//                                       ? 50
//                                       : 150, //conditional statement...if changebutton is true then width changes to  50 else 150 ..this will happen with an animation
//                                   height: 50,
//                                   alignment: Alignment.center,
//                                   child:
//                                       changeButton //conditional statement that when button is clicked show the icon otherwise text will be displayed
//                                           ? Icon(
//                                               Icons.done,
//                                               color: Colors.white,
//                                             )
//                                           : Text(
//                                               "Login",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 18),
//                                             ),
//                                              ),
//                               ),
//                             ),

//                             /* ElevatedButton(
//                       child: Text("Login"),
//                       style: TextButton.styleFrom(minimumSize: Size(150, 40)),
//                       onPressed: () {
//                         Navigator.pushNamed(
//                             context,
//                             MyRoutes
//                                 .homeRoute); //with the help of this statement when we press on the login button we will be directed to home page
//                       }, //function to be invoked
//                     )*/
//                           ],
//                         ))
//                   ],
//                 ))));
//   }
// }
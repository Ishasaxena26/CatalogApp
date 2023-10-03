import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_catalog/api/auth/auth_api.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/user_cubit.dart';
import '../models/user_models.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

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

  TextEditingController? controller;
  final _formKey = GlobalKey<FormState>();
  bool changeButton = false;
  String _password = '';
  //String _confirmPassword = '';

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(Duration(seconds: 1));

      ///wait for 1 second then move to loginRoute page
      await Navigator.pushNamed(context, MyRoutes.loginRoute);
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
        //color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold, height: 3),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nicknameController,
                          decoration: InputDecoration(
                            hintText: "Enter nickname",
                            labelText: "Nickname",
                          ),
                        ),
                        //SizedBox(height: 10),
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
                        ),
                        SizedBox(height: 10),
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
                            onChanged: (value) {
                              _password = value;
                            }),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: confirmpasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Re enter password",
                            labelText: "Confirm Password",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password cannot be empty';
                            } else if (value.length < 6) {
                              return 'Password cannot be so small';
                            } else if (value != _password) {
                              return 'Passwords do not match';
                            }
                            return null; //else null will be returned if validateed
                          },
                          // onChanged: ((value) {
                          // _confirmPassword = value;
                          // }
                          //),
                        ),
                        SizedBox(height: 20),
                        Material(
                          color: Colors.deepPurple,
                          borderRadius:
                              BorderRadius.circular(changeButton ? 50 : 8),
                          child: InkWell(
                            onTap: () async {
                              var authRes = await registerUser(
                                  emailController.text,
                                  nicknameController.text,
                                  passwordController.value.text,
                                  confirmpasswordController.value.text);
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
                            /* child: Container(
                                  height: 60,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                )))*/

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
                                          "Register",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}






// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_catalog/api/auth/auth_api.dart';
// import 'package:flutter_catalog/utils/routes.dart';
// import 'package:velocity_x/velocity_x.dart';

// import '../models/user_cubit.dart';
// import '../models/user_models.dart';

// class RegisterPage extends StatefulWidget {
//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   TextEditingController nicknameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmpasswordController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();
//   bool changeButton = false;
//   String _password = '';

//   void _moveToLogin(BuildContext context) async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         changeButton = true;
//       });

//       await Future.delayed(Duration(seconds: 1));

//       // Replace MyRoutes.homeRoute with your actual home route
//       await Navigator.pushNamed(context, MyRoutes.loginRoute);

//       setState(() {
//         changeButton = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: context.canvasColor,
//       child: Center(
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 Text(
//                   "Sign Up",
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                     height: 3,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 16.0,
//                     horizontal: 32.0,
//                   ),
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         controller: nicknameController,
//                         decoration: InputDecoration(
//                           hintText: "Enter nickname",
//                           labelText: "Nickname",
//                         ),
//                       ),
//                       TextFormField(
//                         controller: emailController,
//                         decoration: InputDecoration(
//                           hintText: "Enter email",
//                           labelText: "Email",
//                         ),
//                         validator: (value) {
//                           if (value?.isEmpty ?? true) {
//                             return 'Email cannot be empty';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 10),
//                       TextFormField(
//                         controller: passwordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           hintText: "Enter password",
//                           labelText: "Password",
//                         ),
//                         validator: (value) {
//                           if (value?.isEmpty ?? true) {
//                             return 'Password cannot be empty';
//                           } else if (value!.length < 6) {
//                             return 'Password cannot be so small';
//                           }
//                           return null;
//                         },
//                         onChanged: (value) {
//                           _password = value;
//                         },
//                       ),
//                       SizedBox(height: 10),
//                       TextFormField(
//                         controller: confirmpasswordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           hintText: "Re-enter password",
//                           labelText: "Confirm Password",
//                         ),
//                         validator: (value) {
//                           if (value?.isEmpty ?? true) {
//                             return 'Password cannot be empty';
//                           } else if (value!.length < 6) {
//                             return 'Password cannot be so small';
//                           } else if (value.trim() != _password.trim()) {
//                             return 'Passwords do not match';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       Material(
//                         color: Colors.deepPurple,
//                         borderRadius: BorderRadius.circular(changeButton ? 50 : 8),
//                         child: InkWell(
//                           onTap: () async {
//                             setState(() {
//                               changeButton = true;
//                             });

//                             var authRes = await registerUser(
//                               emailController.text,
//                               nicknameController.text,
//                               passwordController.text,
//                               confirmpasswordController.text,
//                             );

//                             if (authRes.runtimeType == String) {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return Dialog(
//                                     child: Container(
//                                       alignment: Alignment.center,
//                                       height: 200,
//                                       width: 250,
//                                       decoration: BoxDecoration(),
//                                       child: Text(authRes),
//                                     ),
//                                   );
//                                 },
//                               );
//                             } else if (authRes.runtimeType == User) {
//                               User user = authRes;
//                               context.read<UserCubit>().emit(user);
//                               _moveToLogin(context);
//                             }

//                             setState(() {
//                               changeButton = false;
//                             });
//                           },
//                           child: AnimatedContainer(
//                             duration: Duration(seconds: 1),
//                             width: changeButton ? 50 : 150,
//                             height: 50,
//                             alignment: Alignment.center,
//                             child: changeButton
//                                 ? Icon(
//                                     Icons.done,
//                                     color: Colors.white,
//                                   )
//                                 : Text(
//                                     "Register",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18,
//                                     ),
//                                   ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

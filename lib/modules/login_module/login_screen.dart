import 'package:e_commerce_app/component/component.dart';
import 'package:e_commerce_app/component/constant.dart';
import 'package:e_commerce_app/modules/admin/admin_screen.dart';
import 'package:e_commerce_app/modules/home/home_screen.dart';
import 'package:e_commerce_app/modules/signup_module/sign_up_screen.dart';
import 'package:e_commerce_app/providers/admin_mode.dart';
import 'package:e_commerce_app/providers/modal_hud.dart';
import 'package:e_commerce_app/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email, password;
  final auth = Auth();
  final String adminPassword = 'admin1234';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final modalHud = Provider.of<ModalHud>(context);
    final adminMode = Provider.of<AdminMode>(context);
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: modalHud.isLoading,
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Container(
                  height: height * 0.2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                          'assets/images/icon.png',
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Text(
                          'Buy it',
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              customTextField(
                hint: 'Enter your email',
                icon: Icons.email,
                onClick: (value) {
                  email = value;
                },
                validate: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter your email';
                  }
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              customTextField(
                hint: 'Enter your password',
                icon: Icons.lock,
                onClick: (value) {
                  password = value;
                },
                validate: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter your password';
                  }
                },
                isPassword: true,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 120,
                ),
                child: customButton(
                    text: 'login',
                    function: () async {
                      validate(context);
                    }),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: width * 0.01,
                  ),
                  TextButton(
                    onPressed: () =>
                        navigateTo(context: context, widget: SignUpScreen()),
                    child: Text(
                      'Sign Up'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        adminMode.changeAdminMode(true);
                      },
                      child: Text(
                        'I\'m an admin.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: adminMode.isAdmin ? kMainColor : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        adminMode.changeAdminMode(false);
                      },
                      child: Text(
                        'I\'m a user.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: adminMode.isAdmin ? Colors.white : kMainColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validate(BuildContext context) async {
    final modalHud = Provider.of<ModalHud>(context,listen: false);
    final adminMode = Provider.of<AdminMode>(context,listen: false);
    modalHud.changeIsLoading(true);
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (adminMode.isAdmin) {
        if (password == adminPassword) {
          try {
           await auth.signIn(email: email, password: password);
            modalHud.changeIsLoading(false);
            navigateAndRemove(context: context, widget: AdminScreen());
          } catch (e) {
            modalHud.changeIsLoading(false);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.message)));
          }
        } else {
          modalHud.changeIsLoading(false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Something went wrong !',
              ),
            ),
          );
        }
      } else {
        try {
        await  auth.signIn(email: email, password: password);
          modalHud.changeIsLoading(false);
          navigateAndRemove(context: context, widget: HomeScreen());
        } catch (e) {
          modalHud.changeIsLoading(false);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
        }
      }
    }
    modalHud.changeIsLoading(false);
  }
}

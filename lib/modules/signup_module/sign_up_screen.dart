import 'package:e_commerce_app/component/component.dart';
import 'package:e_commerce_app/component/constant.dart';
import 'package:e_commerce_app/modules/home/home_screen.dart';
import 'package:e_commerce_app/modules/login_module/login_screen.dart';
import 'package:e_commerce_app/providers/modal_hud.dart';
import 'package:e_commerce_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email, password;
  final auth = Auth();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final modalHud = Provider.of<ModalHud>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
      ),
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: modalHud.isLoading,
        child: Form(
          key: formKey,
          child: ListView(
            physics: BouncingScrollPhysics(),
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
                hint: 'Enter your name',
                icon: Icons.person,
                validate: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter your name';
                  }
                },
              ),
              SizedBox(
                height: height * 0.02,
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
                validate: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter your password';
                  }
                },
                onClick: (value) {
                  password = value;
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
                child: Builder(
                  builder: (context) => customButton(
                      text: 'sign up',
                      function: () async {
                        if (formKey.currentState.validate()) {
                          try {
                            modalHud.changeIsLoading(true);
                            formKey.currentState.save();
                            await auth.signUp(
                                email: email.trim(), password: password.trim());
                            modalHud.changeIsLoading(false);
                            navigateAndRemove(
                                context: context, widget: HomeScreen());
                          } catch (e) {
                            modalHud.changeIsLoading(false);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(e.message),
                            ));
                          }
                        }
                        modalHud.changeIsLoading(false);
                      }),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: width * 0.01,
                  ),
                  TextButton(
                    onPressed: () => navigateAndRemove(
                        context: context, widget: LoginScreen()),
                    child: Text(
                      'login'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
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
}

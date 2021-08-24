import 'package:e_commerce_app/component/component.dart';
import 'package:e_commerce_app/component/constant.dart';
import 'package:e_commerce_app/modules/login_module/login_screen.dart';
import 'package:e_commerce_app/services/auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: () async {
          await auth.auth.signOut();
          navigateAndRemove(context: context, widget: LoginScreen());
        },
        child: Text(
          'Sign out',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kMainColor,
          ),
        ),
      ),
    );
  }
}

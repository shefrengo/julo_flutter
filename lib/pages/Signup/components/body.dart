import 'package:flutter/material.dart';
import 'package:julo/components/already_have_an_account_acheck.dart';
import 'package:julo/components/rounded_button.dart';
import 'package:julo/components/rounded_input_field.dart';
import 'package:julo/components/rounded_password_field.dart';
import 'package:julo/pages/Login/login_screen.dart';
import 'package:julo/pages/Signup/components/social_icon.dart';

import 'background.dart';
import 'or_divider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

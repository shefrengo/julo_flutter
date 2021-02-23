import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:julo/components/already_have_an_account_acheck.dart';
import 'package:julo/components/rounded_button.dart';
import 'package:julo/components/rounded_input_field.dart';
import 'package:julo/components/rounded_password_field.dart';
import 'package:julo/firebase/authentication_service.dart';

import 'package:julo/pages/Signup/signup_screen.dart';

import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController emailControlloer = new TextEditingController();

    TextEditingController passwordControlloer = new TextEditingController();
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RoundedInputField(
              controller: emailControlloer,
              inputType: TextInputType.emailAddress,
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              controller: passwordControlloer,
            
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                String email = emailControlloer.text.trim();
                String password = passwordControlloer.text.trim();
                checkSignInConditions(email, password);
                context.read<AuthenticationService>().signIn(email, password);

                /*   Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RootApp();
                    },
                  ),
                );**/
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void checkSignInConditions(String email, String password) {
    if (email.isEmpty) {
      print("empty");
      return;
    }
    if (password.isEmpty) {
      print("empty");
      return;
    }
    if (password.length < 6) {
      print("too short");
      return;
    }
  }
}

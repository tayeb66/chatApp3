import 'package:chatapp3/controllers/authController.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginPage'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: TextFormField(
                controller: emailController,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter UserName',
                  contentPadding: EdgeInsets.only(left: 10.0),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  contentPadding: EdgeInsets.only(left: 10.0),
                ),
              ),
            ),
            SizedBox(height: 10,),

            ElevatedButton(
              style: TextButton.styleFrom(
                  minimumSize: Size(200, 50),
                  shape: StadiumBorder()
              ),
              onPressed: () async{
                SharedPreferences preferences = await SharedPreferences.getInstance();
                if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                  authController.register(context, emailController.text, passwordController.text);
                }else{
                  authController.showError(context, 'Field must be not empty');
                }
                preferences.setString('email', emailController.text);

              },
              child: Text('SignUp',textScaleFactor: 1.2,),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Have an account ?'),
                TextButton(onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }, child: Text('Login'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minimal_chat_app/services/auth/auth_service.dart';
import 'package:minimal_chat_app/components/my_button.dart';
import 'package:minimal_chat_app/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  final void Function()? onTap;
  RegisterPage({super.key,required this.onTap});

  void register(BuildContext context){
    // get auth service
    final _auth = AuthService();
    // passwords match -> create user
    if (_passwordController.text == _confirmPwController.text){
      try {
        _auth.signUpWithEmailPassword(_emailController.text, _passwordController.text);
      }catch (e){
        showDialog(context: context, builder: (context) => AlertDialog(
        title: Text(e.toString()),
      ));
      }
    }
    // passwords dont match -> tell user to fix
    else{
      showDialog(context: context, builder: (context) =>const AlertDialog(
        title: Text("Passwords don't match!"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
              ),
            const SizedBox(height: 50,),  
            //welcome back message
            Text("Let's create an account for you",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
              ),
            ),
            const SizedBox(height: 25,),

            //email textfield
            MyTextField(hintText: "Email",obscureText: false, controller: _emailController,focusNode: null,),
            const SizedBox(height: 10,),

            //pw textfield
            MyTextField(hintText: "Password",obscureText: true, controller: _passwordController,focusNode: null,),
            const SizedBox(height: 10,),

            //confirm pw textfield
            MyTextField(hintText: "Confirm Password",obscureText: true, controller: _confirmPwController,focusNode: null,),
            const SizedBox(height: 25,),

            //login button
            MyButton(text: "Register", onTap: ()=> register(context),),
            const SizedBox(height: 25,),

            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? ", style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                GestureDetector(onTap: onTap,child: Text("Login now", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),)),
              ],
            ),
          ],
          ),
      ),
    );
  }
}
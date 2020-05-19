import 'package:flutter/material.dart';
import 'package:flash_chat/components/roundedButton.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String id='RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  final _auth =FirebaseAuth.instance;
  bool showspinner=false;
  String email;
  String password;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black
                ),
                  onChanged: (value) {
                email=value;
                  //Do something with the user input.
                },
                decoration: ktextFieldDecoration.copyWith(
                  hintText: 'Enter your Email.',
              ),),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                  style: TextStyle(
                    color: Colors.black
                  ),
                onChanged: (value) {
                  password=value;
                },
                decoration: ktextFieldDecoration.copyWith(
                  hintText: 'Enter your Password.',

                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.blueAccent,
                title: 'Registration',
                onPressed: ()async{
//                print(email);
//                print(password);
                setState(() {
                  showspinner=true;
                });
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if(newUser!=null)
                    {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                  setState(() {
                    showspinner=false;
                  });
                }catch(e)
                  {print(e);}
                },


              )
            ],
          ),
        ),
      ),
    );
  }
}

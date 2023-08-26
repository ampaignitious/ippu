import 'package:flutter/material.dart';
import 'package:ippu/Screens/DefaultScreen.dart';
import 'package:ippu/Screens/HomeScreen.dart';
import 'package:ippu/Screens/IppuTermsOfUse.dart';
import 'package:ippu/Widgets/AuthenticationWidgets/LoginScreen.dart';
import 'package:ippu/Widgets/AuthenticationWidgets/RegisterScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isPasswordVisible = false;

  final List<String> _accountTypes = ['ccpp', 'student', 'corporate'];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform registration logic here
      // For demonstration purposes, we print the values
      print('Email: $_email');
      print('Password: $_password');
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return DefaultScreen();
      }));

    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(height: size.height*0.07,),
         Text("Login Page",style: GoogleFonts.montserrat(
          fontSize: size.height*0.047, color:Colors.blue, fontWeight: FontWeight.bold, letterSpacing: 1)
         ),
         SizedBox(height: size.height*0.040),
         Container(
          height: size.height*0.19,
          width: size.width*0.4,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/image8.png")),
          ),
         ),
         SizedBox(height: size.height*0.029),
         Text("Sign in to continue to IPPU Membership App", style: GoogleFonts.lato(
          color:Color.fromARGB(255, 42, 129, 201).withOpacity(0.7),
         ),),
          SizedBox(height: size.height*0.006,),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // You can add more validation here if needed
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                    SizedBox(height: size.height*0.028),
                    TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                obscureText: !_isPasswordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  // You can add more validation here if needed
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
                   SizedBox(height: size.height*0.034),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 50, 155, 132), // Change button color to green
                        padding: EdgeInsets.all(size.height * 0.028),
                      ),
                      onPressed: _submitForm,
                      child: Text('Sign In'),
                    ),
                    SizedBox(height: size.height*0.026),
        Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: size.width*0.08),
            child: Text("Don't have an account ?", style: GoogleFonts.lato(
              fontSize: size.height*0.022, color: Colors.black,
            ),),
          ),
          InkWell(
            onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                  return RegisterScreen();
                }));},
            child: Padding(
              padding: EdgeInsets.only(left: size.width*0.015),
              child: Text("SignUp", style: GoogleFonts.montserrat(
                fontSize: size.height*0.022, color: Color.fromARGB(255, 42, 129, 201), fontWeight: FontWeight.bold
              ),),
            ),
          ),
        ],
        ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
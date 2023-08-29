import 'package:flutter/material.dart';
import 'package:ippu/Screens/DefaultScreen.dart';
import 'package:ippu/Screens/IppuTermsOfUse.dart';
import 'package:ippu/Widgets/AuthenticationWidgets/LoginScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _username = '';
  String _password = '';
  String _confirmPassword = '';
  bool _agreedToTerms = false;
  bool _isPasswordVisible = false;

  final List<String> _accountTypes = ['cpp', 'student', 'corporate'];
 String _selectedValue = 'Please select account type';
  TextEditingController _textEditingController = TextEditingController();
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform registration logic here
      // For demonstration purposes, we print the values
      print('Email: $_email');
      print('Username: $_username');
      print('Password: $_password');
      print('Confirm Password: $_confirmPassword');
      print('Selected usertype ${_selectedValue}');
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height*0.07,),
           Text("Create account",style: GoogleFonts.montserrat(
            fontSize: size.height*0.047, color:Color.fromARGB(255, 42, 129, 201), fontWeight: FontWeight.bold, letterSpacing: 1
           ),), 
            Text("Get your free IPPU account now. ", style: GoogleFonts.lato(
              color:Color.fromARGB(255, 42, 129, 201).withOpacity(0.6),
            ),),
            SizedBox(height: size.height*0.006,),
            Container(
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
                    SizedBox(height: size.height*0.018),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        // You can add more validation here if needed
                        return null;
                      },
                      onSaved: (value) {
                        _username = value!;
                      },
                    ),
                    SizedBox(height: size.height*0.018),
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
             SizedBox(height: size.height*0.018),
                    TextFormField(
        decoration: InputDecoration(
          labelText: 'Confirm Password',
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
        return 'Please confirm your password';
          }
          if (value != _password) {
        return 'Passwords do not match';
          }
          return null;
        },
        onSaved: (value) {
          _confirmPassword = value!;
        },
      ),
             SizedBox(height: size.height*0.018),
            //  
       DropdownButtonFormField<String>(
              value: _selectedValue,
              onChanged: (newValue) {
                setState(() {
                  _selectedValue = newValue!;
                });
              },
              items: ['Please select account type', 'CPP (200,000)', 'Affiliates (110,000)', 'Student (20,000)', 'Graduate (150,000)','Felllow (250,000)','Corporate (600,000)','General Memeber (1,000,000)']
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Account Type',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),  
            // 
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Checkbox(
        value: _agreedToTerms,
        onChanged: (bool? value) {
          setState(() {
            _agreedToTerms = value!;
          });
        },
          ),
          Padding(
        padding: EdgeInsets.only(left: size.width*0.04),
        child: Text("By registering you agree", style: GoogleFonts.lato(
          fontSize: size.height*0.015, color: Colors.black, fontWeight: FontWeight.bold
        ),),
          ),
          InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return IppuTermsOfUse();
          }));
        },
        child: Padding(
          padding: EdgeInsets.only(left: size.width*0.015),
          child: Text("IPPU Terms of use", style: TextStyle(fontSize: size.height*0.015, color:Color.fromARGB(255, 42, 129, 201), fontWeight: FontWeight.bold),),
        ),
          ),
        ],
      ),
            SizedBox(height: size.height*0.004),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary:  Color.fromARGB(255, 42, 129, 201), // Change button color to green
                padding: EdgeInsets.all(size.height * 0.028),
              ),
              onPressed: _submitForm,
              child: Text('Register'),
            ),
                    SizedBox(height: size.height*0.026),
          Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
            padding: EdgeInsets.only(left: size.width*0.08),
            child: Text("Already have an account ?", style: GoogleFonts.lato(
              fontSize: size.height*0.022, color: Colors.black,
            ),),
            ),
            InkWell(
            onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                  return LoginScreen();
                }));},
            child: Padding(
              padding: EdgeInsets.only(left: size.width*0.015),
              child: Text("SignIn", style: GoogleFonts.montserrat(
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
          ],
        ),
      ),
    );
  }
}
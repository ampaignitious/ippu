import 'package:flutter/material.dart';
import 'package:ippu/Util/PhoneNumberFormatter%20.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ippu/Widgets/AuthenticationWidgets/DigitCode.dart';
import 'package:ippu/controllers/auth_controller.dart';

class PhoneAuthLogin extends StatefulWidget {
  const PhoneAuthLogin({super.key});

  @override
  State<PhoneAuthLogin> createState() => _WelcomeState();
}

class _WelcomeState extends State<PhoneAuthLogin> {
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;
  var OTPCode;

  TextEditingController phoneNumber = TextEditingController(text: '+256');
  TextEditingController otp = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "LOGIN",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue, // Set app bar background color
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Center(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center content vertically
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center content horizontally
              children: [
                const SizedBox(height: 20),
                //Enter 6 digit code sent to your phone
                const Text(
                  "Enter phone number registered with IPPU Membership APP(eg. +256 700 000 000)",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center, // Center text
                ),
                const SizedBox(height: 20),
                inputTextField("Phone Number", phoneNumber, context),
                const SizedBox(height: 20),
                SendOTPButton("NEXT"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget SendOTPButton(String text) => ElevatedButton(
        onPressed: () async {
          //get the phone number and remove all spaces
          String formattedPhoneNumber = phoneNumber.text.replaceAll(' ', '');
          phoneAuthentication(formattedPhoneNumber);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Colors.blue), // Set button background color to blue
        ),
        child: Text(
          text,
          style:
              const TextStyle(color: Colors.white), // Set text color to white
        ),
      );

  Widget inputTextField(String labelText,
          TextEditingController textEditingController, BuildContext context) =>
      Padding(
        padding: const EdgeInsets.all(2.00),
        child: SizedBox(
            child: TextFormField(
          controller: textEditingController,
          inputFormatters: [PhoneNumberFormatter()],
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone number.';
            }
            // You can add more validation here if needed
            return null;
          },
          onSaved: (value) {},
        )),
      );

  void phoneAuthentication(String phoneNo) async {
    //check if phone number is valid
    var isPhoneValid = await checkPhoneNumber(phoneNo);
    if (isPhoneValid) {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) async {
          //get the otp code
          OTPCode = credential.smsCode;

        },
        verificationFailed: (e) {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar('Error', 'The provided phone number is not valid.');
          } else {
            Get.snackbar('Error', 'Something went wrong. Try again');
          }
        },
        codeSent: (verificationId, resendToken) async {
          this.verificationId.value = verificationId;

          //Navigate Digitcode screen()
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            //save the fcm token to the database
            return Digitcode(phoneNumber: phoneNo, auth:_auth, verificationId: verificationId, OTPCode: OTPCode);
          }));
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        },
      );
    } else {
      Get.snackbar('Error', 'Phone number not registered. Please register');
    }
  }

  Future<bool> checkPhoneNumber(String phone) async {
    AuthController authController = AuthController();

    final response = await authController.checkPhoneNumber(phone);
    print("checking phone number: $response");
    //check if response status is success
    if (response['status'] == 'success') {
      return true;
    } else {
      return false;
    }
  }
}

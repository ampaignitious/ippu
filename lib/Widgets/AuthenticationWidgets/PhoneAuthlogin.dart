import 'package:flutter/material.dart';
import 'package:ippu/Util/PhoneAuthFirebase.dart';

class PhoneAuthLogin extends StatefulWidget {
  const PhoneAuthLogin({Key? key}) : super(key: key);

  @override
  State<PhoneAuthLogin> createState() => _WelcomeState();
}

class _WelcomeState extends State<PhoneAuthLogin> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController otp = TextEditingController();
  bool visible = false;
  var temp;

  @override
  void dispose() {
    phoneNumber.dispose();
    otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOGIN"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputTextField("Phone Number", phoneNumber, context),
            visible ? inputTextField("OTP", otp, context) : const SizedBox(),
            !visible ? SendOTPButton("Send OTP") : SubmitOTPButton("LOGIN"),
          ],
        ),
      ),
    );
  }

  Widget SendOTPButton(String text) => ElevatedButton(
        onPressed: () async {
          setState(() {
            visible = !visible;
          });
          AuthenticationRepository().phoneAuthentication(phoneNumber.text);
        },
        child: Text(text),
      );

  Widget SubmitOTPButton(String text) => ElevatedButton(
        onPressed: () => AuthenticationRepository().verifyOTP(temp),
        child: Text(text),
      );

  Widget inputTextField(String labelText,
          TextEditingController textEditingController, BuildContext context) =>
      Padding(
        padding: const EdgeInsets.all(10.00),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: TextFormField(
            obscureText: labelText == "OTP" ? true : false,
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: labelText,
              hintStyle: const TextStyle(color: Colors.blue),
              filled: true,
              fillColor: Colors.blue[100],
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(5.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(5.5),
              ),
            ),
          ),
        ),
      );
}

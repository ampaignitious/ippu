import 'package:flutter/material.dart';

class IppuTermsOfUse extends StatefulWidget {
  const IppuTermsOfUse({super.key});

  @override
  State<IppuTermsOfUse> createState() => _IppuTermsOfUseState();
}

class _IppuTermsOfUseState extends State<IppuTermsOfUse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IPPU Terms of use",),
        backgroundColor: Color.fromARGB(255, 50, 155, 132),
        elevation: 0,
      ),
    );
  }
}
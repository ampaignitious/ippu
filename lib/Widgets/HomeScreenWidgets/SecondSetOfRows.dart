import 'package:flutter/material.dart';

class SecondSetOfRows extends StatefulWidget {
  const SecondSetOfRows({super.key});

  @override
  State<SecondSetOfRows> createState() => _SecondSetOfRowsState();
}

class _SecondSetOfRowsState extends State<SecondSetOfRows> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: size.height*0.14,
                            width: size.width*0.35,
                            decoration: BoxDecoration(
                              color: Colors.lightGreen
                            ),
                          ),
                          Container(
                            height: size.height*0.14,
                            width: size.width*0.35,
                            decoration: BoxDecoration(
                              color: Colors.lightGreen
                            ),
                          ),
                          
                        ],
                      )
                      ;
  }
}
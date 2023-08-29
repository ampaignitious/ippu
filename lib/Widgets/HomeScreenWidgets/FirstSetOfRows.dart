import 'package:flutter/material.dart';

class FirstSetOfRows extends StatefulWidget {
  const FirstSetOfRows({super.key});

  @override
  State<FirstSetOfRows> createState() => _FirstSetOfRowsState();
}

class _FirstSetOfRowsState extends State<FirstSetOfRows> {
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
                              //  borderRadius: BorderRadius.circular(10),
                               shape: BoxShape.circle,
                              color: Colors.lightGreen
                            ),
                          ),
                          
                        ],
                      )
                      ;
  }
}
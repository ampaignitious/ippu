import 'package:flutter/material.dart';

import 'SecondSplashScreen.dart';

class FirstSplashScreen extends StatefulWidget {
  const FirstSplashScreen({super.key});

  @override
  State<FirstSplashScreen> createState() => _FirstSplashScreenState();
}

class _FirstSplashScreenState extends State<FirstSplashScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: size.height*0.015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(''),
                Padding(
                  padding: EdgeInsets.only(right: size.width*0.05),
                  child: Text("skip", style: TextStyle(fontSize: size.height*0.025, color: Colors.blue, fontWeight: FontWeight.bold),),
                )
              ],
            ),
            SizedBox(
              height: size.height*0.088,
            ),
            Container(
              height: size.height*0.35,
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/image4.png")),
              ),
            ),
              SizedBox(
              height: size.height*0.048,
            ),
            Text("Discovery about IPPU", style: TextStyle(fontSize: size.height*0.044, fontWeight: FontWeight.bold,color: Colors.lightBlue),),
            SizedBox(
              height: size.height*0.015,
            ),
            Padding(
              padding: EdgeInsets.only(right: size.width*0.05, left: size.width*0.06),
              child: Text("An application developed to bring together both the public and provate sector procument and supply chain professionals in Uganda.", style: TextStyle(fontSize: size.height
              *0.016),),
            ),
            SizedBox(
              height: size.height*0.055,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: size.width*0.048),
                      height: size.height*0.052,
                      width: size.width*0.062,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: size.width*0.04),
                      height: size.height*0.052,
                      width: size.width*0.062,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: size.width*0.04),
                      height: size.height*0.052,
                      width: size.width*0.062,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                       color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                  return SecondSplashScreen();
                }));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: size.width*0.04),
                    height: size.height*0.08,
                    width: size.width*0.16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Icon(Icons.arrow_forward, color: Colors.white, size: size.height*0.04,),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      );
  }
}
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';
class Image_Slider extends StatefulWidget {
  const Image_Slider({super.key});

  @override
  State<Image_Slider> createState() => _Image_SliderState();
}

class _Image_SliderState extends State<Image_Slider> {
  
  
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
      final cpdimageLink = Provider.of<UserProvider>(context).getLinkImage;
    return   Container(
              width: size.width*0.7,
              height: size.height*0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.grey,
                  blurRadius: 0.2,
                  blurStyle:BlurStyle.normal,)
                ],
                color: Colors.white,
                // image: DecorationImage(
                //   fit: BoxFit.contain,
                //   image: AssetImage('assets/image2.png'))
              ),
              child: CarouselSlider(
  options: CarouselOptions(
    height: size.height*0.4,
    autoPlay: true,
      autoPlayInterval: Duration(seconds: 5),
      autoPlayAnimationDuration: Duration(milliseconds: 1400),),
  items: [
    {"image":"assets/image2.png",
    "Description":"Upcoming CPDS"},
    {"image":"assets/image3.png",
    "Description":"Upcoming Events"},
    {"image":"assets/image1.png",
    "Description":"Communication"},].map((i) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0),

          child: Column(
            children: [
      Padding(
        padding: EdgeInsets.only(
          top: size.height*0.012,
        ),
        child: Text(
          "Upcoming Cpds",
          style: GoogleFonts.roboto(
            fontSize: size.height * 0.02,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            color: Color.fromARGB(255, 7, 63, 109),
          ),
        
        ),
      ),
      Divider(),
      Container(
        width: size.width*0.7,
              height: size.height*0.25,
                  decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(i['image'].toString())),
          ),
      ),
              Center(
                child: Padding(
                  padding:   EdgeInsets.only(
                    top: size.height*0.03,
                  ),
                  child: Text(i['Description'].toString()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }).toList(),
),
            );
          
  }
}
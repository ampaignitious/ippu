import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/attendedCpdListHorizontalView.dart';
import 'package:ippu/Widgets/HomeScreenWidgets/ImageSlider.dart/image_slider.dart';
import 'package:ippu/Widgets/chartsWidget/AppColors.dart';
import 'package:ippu/Widgets/chartsWidget/firstPieChart.dart';
import 'package:ippu/Widgets/chartsWidget/indicator.dart';

class FirstSetOfRows extends StatefulWidget {
  const FirstSetOfRows({super.key});

  @override
  State<FirstSetOfRows> createState() => _FirstSetOfRowsState();
}

class _FirstSetOfRowsState extends State<FirstSetOfRows> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left:size.width*0.4,),
          child: Text("App points summary", style: GoogleFonts.lato(
            fontSize:size.height*0.02,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),),
        ),
        Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: size.height*0.26,
                    width: size.width*0.95,
                    child: Row(
                      children: [
                        PieChartSample2(),
                      Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Indicator(
                          color: Colors.lightBlue,
                          text: 'Events points',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Indicator(
                          color: AppColors.contentColorGreen,
                          text: 'All User points',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Indicator(
                          color: AppColors.contentColorPurple,
                          text: 'Cpd points',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                    
                      ],
                    ),
                  ),
                  
                ],
              ),
        SizedBox(
          height: size.height*0.016,
        ),

        // container displaying the upcoming cpds in a horizontal 
        Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: size.width * 0.06,
                          top: size.height * 0.02,
                          right: size.width * 0.06,
                        ),
                        child: Column(
                          children: [
                            Divider(),
                            Container(
                              height: size.height*0.4,
                              width: size.width*0.9,
                              child: Image_Slider()),
                          ],
                        ),
                      ),
                    ])
        // 
      ],
    )
          ;
  }
}
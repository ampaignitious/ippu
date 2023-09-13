import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/attendedCpdListHorizontalView.dart';
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
            fontSize:size.height*0.02
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
        Container(
            margin: EdgeInsets.symmetric(
              horizontal: size.height * 0.009,
            ),
            height: size.height * 0.39,
            width: size.width * 0.90,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  offset: Offset(0.8, 1.0),
                  blurRadius: 4.0,
                  spreadRadius: 0.2,
                ),
              ],
            ),
            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: size.width * 0.06,
                                  top: size.height * 0.02,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Upcoming Cpds",
                                      style: GoogleFonts.roboto(
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal,
                                        color: Color.fromARGB(255, 7, 63, 109),
                                      ),
                                    
                                    ),
                                    Divider(),
                                    Container(
                                      height: size.height*0.30,
                                      width: size.width*0.8,
                                      child: attendedCpdListHorizontalView()),
                                  ],
                                ),
                              ),
                            ])
        )
        // 
      ],
    )
          ;
  }
}
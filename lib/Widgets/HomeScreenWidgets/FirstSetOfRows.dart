import 'package:flutter/material.dart';
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
    return Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: size.height*0.26,
                width: size.width*0.88,
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
                      color: Colors.yellow,
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
          )
          ;
  }
}
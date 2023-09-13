import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ippu/Widgets/chartsWidget/AppColors.dart';
import 'package:ippu/controllers/auth_controller.dart';
import 'package:ippu/models/UserProvider.dart';
import 'package:provider/provider.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;
  @override
    void initState() {
    super.initState();
    fetchData();
  }
    int totalCpdPoints =0;
  Future<void> fetchData() async {
    try {
      AuthController authController = AuthController();
      final cpds = await authController.getCpds();
      final events = await authController.getEvents();
      final communications = await authController.getAllCommunications();
      final eventPoints = await authController.getEvents();
       int totalEventPoints = 0; // Initialize the total event points

    // Calculate total event points
    for (final event in events) {
      final points = event['points'] as int;
      totalEventPoints += points;
    }
     Provider.of<UserProvider>(context, listen: false).totalNumberOfPointsFromEvents(totalEventPoints);
    for (final cpd in cpds) {
      print(int.tryParse(cpd['points']) );
      final points = int.tryParse(cpd['points']) ;
      totalCpdPoints += points!;
    }
    Provider.of<UserProvider>(context, listen:false).totalNumberOfPointsFromCpd(totalCpdPoints);

    } catch (e) {
      // Handle any errors here
      print('Error fetching data: $e');
    }
  }

  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    final userData = Provider.of<UserProvider>(context).user;
    final sizeHeight = Provider.of<UserProvider>(context).EventsPoints;
    final pointsFromCpd  = Provider.of<UserProvider>(context).CpdPoints;
    final points = userData?.points;
    return AspectRatio(
      aspectRatio: 1.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(sizeHeight!, points!, totalCpdPoints ),
                ),
              ),
            ),
          ),
       const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(int eventsPoints, String totalUserPoints , int cpdPoint) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      final int defaultpoints = 10;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.contentColorBlue,
            value: ((eventsPoints.toDouble())==0)? defaultpoints.toDouble():eventsPoints.toDouble(),
            title: '${eventsPoints} ',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.contentColorGreen,
            value: 40,
            title: '${totalUserPoints} ',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.contentColorPurple,
            value: 15,
            title: '${cpdPoint}',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
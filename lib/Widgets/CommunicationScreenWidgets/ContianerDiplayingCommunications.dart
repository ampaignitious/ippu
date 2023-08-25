import 'package:flutter/material.dart';
import 'package:ippu/Widgets/CpdsScreenWidgets/CpdsSingleEventDisplay.dart';


class ContainerDisplayingCommunications extends StatefulWidget {
  const ContainerDisplayingCommunications({super.key});

  @override
  State<ContainerDisplayingCommunications> createState() => _ContainerDisplayingCommunicationsState();
}

class _ContainerDisplayingCommunicationsState extends State<ContainerDisplayingCommunications> with TickerProviderStateMixin {
  // i will search and see how to print a two dimension array so that i can the two
  List communications = [
  "1. To receive, consider and if approved, adopt the Company’s audited Financial Statements for the year ended 31 December 2020, together",
  "2. The automaker has deepened its analysis and taken part in several responsible sourcing initiatives as it works to comply with a new German",
  "3. Malawi : New Malawi Economic Update Calls for Urgent Action to Address Macroeconomic Imbalances and Increase Energy Access, MalawiMalawi :"
  ];
 List communicationsheadings=[
"Notice of the 2021 Annual General Meeting Ordinary Business",
"Volkswagen overhauls human rights due diligence in materials supply chain",
"Malawi : New Malawi Economic Update Calls for Urgent Action to Address Macroeconomic Imbalances and Increase Energy Access, Malawi",
 ];
  @override
  Widget build(BuildContext context) {
final size = MediaQuery.of(context).size;
   return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: communications.length,
      itemBuilder: (context,index){
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(right:size.height*0.009, left:size.height*0.009),
              height: size.height*0.25,
              width: size.width*0.95,
              decoration: BoxDecoration(
                color: Colors.white,
              boxShadow: [
                  BoxShadow(color: Colors.grey,
                  offset: Offset(0.8, 0.4),
                  blurRadius: 0.4,
                  spreadRadius: 0.8,
                  ),
                BoxShadow(color: Colors.grey,
                  offset: Offset(0.2, 0.8),
                  blurRadius: 0.2,
                  spreadRadius: 0.8,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: size.width*0.02, top: size.height*0.02),
                    child: Text("${communicationsheadings[index]}", style: TextStyle(color:Color.fromARGB(255, 42, 129, 201)),)),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.only(left: size.width*0.066, top: size.height*0.008, right: size.width*0.04,),
                    child: Text("${communications[index]}", textAlign: TextAlign.justify,),
                  )
                ],
              ),
            ),
            SizedBox(height:size.height*0.03)
          ],
        );
      }
    );
  }
}
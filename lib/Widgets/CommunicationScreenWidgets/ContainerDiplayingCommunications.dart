import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ippu/Widgets/CommunicationScreenWidgets/SingleCommunicationDisplayScreen.dart';

class ContainerDisplayingCommunications extends StatefulWidget {
  const ContainerDisplayingCommunications({super.key});

  @override
  State<ContainerDisplayingCommunications> createState() => _ContainerDisplayingCommunicationsState();
}

class _ContainerDisplayingCommunicationsState extends State<ContainerDisplayingCommunications> with TickerProviderStateMixin {
  // i will search and see how to print a two dimension array so that i can the two
  List communications = [
  "1. To receive, consider and if approved, adopt the Company’s audited Financial Statements for the year ended 31 December 2020, together.",
  "2. The automaker has deepened its analysis and taken part in several responsible sourcing initiatives as it works to comply with a new German",
  "3. Malawi : New Malawi Economic Update Calls for Urgent Action to Address Macroeconomic Imbalances and Increase Energy Access, MalawiMalawi :",
  "4. Malawi : New Malawi Economic Update Calls for Urgent Action to Address Macroeconomic Imbalances and Increase Energy Access, MalawiMalawi :",

  ];
 List communicationsheadings=[
"Notice of the 2021 Annual General Meeting Ordinary Business",
"Volkswagen overhauls human rights due diligence in materials supply chain",
"Malawi : New Malawi Economic Update Calls for Urgent Action to Address Macroeconomic Imbalances and Increase Energy Access, Malawi",
 "Notice of the 2021 Annual General Meeting Ordinary Business",
 ];
 int maxWords = 20;
  @override

    // 
    final ScrollController _scrollController = ScrollController();

  void _scrollToTop() {
    _scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollVisibility);
  }

  void _updateScrollVisibility() {
    setState(() {
      _showBackToTopButton = _scrollController.offset > _scrollController.position.maxScrollExtent / 2;
    });
  }
  // 
  Widget build(BuildContext context) {
final size = MediaQuery.of(context).size;
   return Scaffold( 
            floatingActionButton: Visibility(
        visible: _showBackToTopButton,
        child: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 42, 129, 201),
          onPressed: _scrollToTop,
          child: Icon(
            Icons.arrow_upward,
            color: Colors.white,
          ),
          shape: CircleBorder(),
        ),
      ),
    body:ListView.builder(
    controller: _scrollController,
      scrollDirection: Axis.vertical,
      itemCount: communications.length,
      itemBuilder: (context,index){
        return InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return SingleCommunicationDisplayScreen(communicationbody: communications[index], communicationtitle: communicationsheadings[index],);
            }));
          },
          child: Column(
            children: [
               SizedBox(height: size.height*0.008,),
              Container(
                margin: EdgeInsets.only(right:size.height*0.009, left:size.height*0.009),
                height: size.height*0.32,
                width: size.width*0.95,
                decoration: BoxDecoration(
                  color: Colors.white,
                boxShadow: [
              BoxShadow(
          color: Colors.grey.withOpacity(0.5), // Adjust shadow color and opacity
          offset: Offset(0.8, 1.0), // Adjust the shadow offset
          blurRadius: 4.0, // Adjust the blur radius
          spreadRadius: 0.2, // Adjust the spread radius
              ),
        
            ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: size.width*0.02, top: size.height*0.02),
                      child: Text("${communicationsheadings[index]}", style: GoogleFonts.roboto(
                  fontSize: size.height*0.02,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  color: Color.fromARGB(255, 7, 63, 109),
                ),)),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(left: size.width*0.066, top: size.height*0.008, right: size.width*0.04, bottom: size.height*0.008,),
                      child: Text(
                        shortenText("${communications[index]}", maxWords),
                        ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.08),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        // 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Date", style: GoogleFonts.lato(
                                color:Colors.green,
                                fontWeight: FontWeight.bold
                              ),),
                              Text("July 4, 2023, 12:00 am", style: GoogleFonts.roboto(
                                fontSize:size.height*0.016,
                              ),)
                            ],
                          ),
                        // 
                        Column(
                          children: [
                            Icon(Icons.read_more),
                            Text("read more", style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                            ),),
                          ],
                        )
                        ],
                      ),
                    ),
                    SizedBox(height:size.height*0.008)
                  ],
                ),
              ),
              SizedBox(height:size.height*0.03)
            ],
          ),
        );
      }
    ));
  }
  
  String shortenText(String text, int maxLength) {
    List<String> words = text.split(' ');
    if (words.length <= maxLength) {
      return text;
    } else {
      return words.sublist(0, maxLength).join(' ') + '...';
    }
  }
} 

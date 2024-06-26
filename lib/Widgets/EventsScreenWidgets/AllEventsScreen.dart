import 'package:flutter/material.dart';
import 'package:ippu/Widgets/EventsScreenWidgets/ContainerDisplayingEvents.dart';

class AllEventsScreen extends StatefulWidget {
  const AllEventsScreen({super.key});

  @override
  State<AllEventsScreen> createState() => _AllEventsScreenState();
}

class _AllEventsScreenState extends State<AllEventsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.002,
          ),
          // this container has the container that returns the CPds
          Container(
              height: size.height * 0.75,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                  // color: Colors.blue,
                  ),
              child: const ContainerDisplayingEvents()),
        ],
      ),
    );
  }
}

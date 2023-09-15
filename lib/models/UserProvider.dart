import 'package:flutter/material.dart';
import 'package:ippu/models/UserData.dart';

class UserProvider extends ChangeNotifier {
  UserData? _user;

  UserData? get user => _user;
  // cpds
  int? totalCPDS =0;
  int? get CPDS => totalCPDS;
  // 

  // events
  int? totalEvents =0;
  int? get Events => totalEvents;
  // 
   // points from events
  int? PointsFromEvents =0;
  int? get EventsPoints => PointsFromEvents;
  // 
  // 
  String? eventsLinkImage;
  String? get getLinkImage => eventsLinkImage;
  // 

  // points from cpds
  int? PointsFromCpd =0;
  int? get CpdPoints => PointsFromCpd;
  // 
  // events
  int? totalCommunications =0;
  int? get communications => totalCommunications;
  // 
    // events
  int? attendedCpds =0;
  int? get attendedCpd => attendedCpds;
  // 
  void setUser(UserData userData) {
    _user = userData;
    notifyListeners();
  }
  // fetching total number of cpds
  void totalNumberOfCPDS(int cpds){
    totalCPDS = cpds;
    notifyListeners();
  }
  // fetching total number of attended cpds
  void totalNumberOfAttendedCpds(int attended){
    attendedCpds = attended;
  }
  // fetching total number of communications
  void totalNumberOfCommunications(int communication){
    totalCommunications = communication;
    notifyListeners();
  }
  // fetching total number of events


  // fetching total number of events
  void totalNumberOfEvents(int event){
    totalEvents = event;
    notifyListeners();
  }
  // fetching total number of events
    void totalNumberOfPointsFromEvents(int eventPoints){
    PointsFromEvents =eventPoints;
  }
 
    // fetching total number of events
    void totalNumberOfPointsFromCpd(int eventPoints){
    PointsFromCpd =eventPoints;
  }
   
    void setLinkImage(String eventPoints){
    eventsLinkImage =eventPoints;
  }

}

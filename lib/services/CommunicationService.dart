import 'dart:convert';
import 'package:ippu/services/ApiService.dart';

class CommunicationService {
  final ApiService apiService;

  CommunicationService(this.apiService);

  Future<Map<String, int>> getCountOfReadAndUnreadCommunications(int userId) async {
    try {
      final response = await apiService.fetchData('communications/$userId');
      final Map<String, dynamic> jsonResponse = json.decode(response);
      final List<dynamic> communications = jsonResponse['data'];
      
      print('data: $communications');

      final counts = {'readCount': 0, 'unreadCount': 0, 'totalCommunications': 0};

      for (final communication in communications) {
        if (communication['status']==true) {
          counts['readCount'] = counts['readCount']! + 1;
        } else {
          counts['unreadCount']= counts['unreadCount']! + 1;
        }
      }

      counts['totalCommunications'] = communications.length;

      print('counts: $counts');

      return counts;
    } catch (error) {
      // Handle the error (e.g., log it or throw a custom exception)
      print('Error fetching communications: $error');
      return {'readCount': 0, 'unreadCount': 0, 'totalCommunications': 0};
    }
  }
}

import 'package:get/get.dart';

class historyController extends GetxController {
  var historyItems = <Map<String, dynamic>>[].obs;

  void addToHistory(List<Map<String, dynamic>> items) {
    historyItems.addAll(items);
  }

  void clearHistory() {
    historyItems.clear();
  }
}
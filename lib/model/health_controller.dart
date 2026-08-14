import 'package:get/get.dart';

class HealthController extends GetxController {
  List<Map<String, String>> healthList = [];

  String selectedDate = '';

  int selectedIndex = -1;

  // 날짜 저장
  void setDate(String date) {
    selectedDate = date;
    update();
  }

  // 건강 기록 추가
  void addHealthRecord(
    String date,
    String title,
    String content,
  ) {
    healthList.add({
      'date': date,
      'title': title,
      'content': content,
    });

    update();
  }

  // 건강 기록 선택
  void selectHealth(int index) {
    selectedIndex = index;
    update();
  }
}

import 'package:get/get.dart';

class VaccinationController extends GetxController {
  List<Map<String, String>> vaccinationList = [];

  String selectedDate = '';
  bool isCompleted = false;

  void setDate(String date) {
    selectedDate = date;
    update();
  }

  void setCompleted(bool val) {
    isCompleted = val;
    update();
  }

  void addVaccination(String name, String date, bool completed) {
    vaccinationList.add({
      'name': name,
      'date': date,
      'completed': completed ? '완료' : '예정',
    });
    update();
  }
}

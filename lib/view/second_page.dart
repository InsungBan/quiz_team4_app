import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gps_map_app/model/health_controller.dart';

class SecondPage extends StatelessWidget {
  SecondPage({super.key});

  final HealthController controller =
      Get.find<HealthController>();

  final TextEditingController titleController =
      TextEditingController();

  final TextEditingController contentController =
      TextEditingController();

  // 날짜 선택
  Future<void> selectDate(
    BuildContext context,
  ) async {
    DateTime? pickedDate =
        await showDatePicker(
      context: context,

      initialDate: DateTime.now(),

      firstDate: DateTime(2020),

      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      String date =
          '${pickedDate.year}년 '
          '${pickedDate.month}월 '
          '${pickedDate.day}일';

      controller.setDate(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xfffdf8fc),

      appBar: AppBar(
        title: const Text(
          '검사 일정 추가',
        ),

        backgroundColor:
            Colors.cyan,

        foregroundColor:
            Colors.white,

        centerTitle: true,
      ),

      body: GetBuilder<HealthController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding:
                const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                const Text(
                  '검사 일정 추가',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // 검사 날짜
                const Text(
                  '검사 날짜',
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                InkWell(
                  onTap: () {
                    selectDate(context);
                  },

                  child: Container(
                    width:
                        double.infinity,

                    padding:
                        const EdgeInsets.all(
                      15,
                    ),

                    decoration:
                        BoxDecoration(
                      color: Colors.white,

                      border:
                          Border.all(
                        color: Colors.grey,
                      ),

                      borderRadius:
                          BorderRadius
                              .circular(
                        8,
                      ),
                    ),

                    child: Row(
                      children: [
                        const Icon(
                          Icons
                              .calendar_month,
                          color:
                              Colors.cyan,
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        Text(
                          controller
                                  .selectedDate
                                  .isEmpty
                              ? '날짜를 선택하세요'
                              : controller
                                  .selectedDate,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // 검사명
                const Text(
                  '검사명',
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                TextField(
                  controller:
                      titleController,

                  decoration:
                      InputDecoration(
                    hintText:
                        '예: 혈액 검사',

                    prefixIcon:
                        const Icon(
                      Icons.search,
                    ),

                    filled: true,

                    fillColor:
                        Colors.white,

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        8,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // 검사 내용
                const Text(
                  '검사 내용',
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                TextField(
                  controller:
                      contentController,

                  maxLines: 4,

                  decoration:
                      InputDecoration(
                    hintText:
                        '검사 내용을 입력해주세요.',

                    filled: true,

                    fillColor:
                        Colors.white,

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        8,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                // 검사 일정 추가
                SizedBox(
                  width:
                      double.infinity,

                  height: 50,

                  child:
                      ElevatedButton(
                    onPressed: () {
                      // 날짜 확인
                      if (controller
                          .selectedDate
                          .isEmpty) {
                        Get.snackbar(
                          '알림',
                          '검사 날짜를 선택해주세요.',
                        );

                        return;
                      }

                      // 검사명 확인
                      if (titleController
                          .text
                          .isEmpty) {
                        Get.snackbar(
                          '알림',
                          '검사명을 입력해주세요.',
                        );

                        return;
                      }

                      // 건강 기록 추가
                      controller
                          .addHealthRecord(
                        controller
                            .selectedDate,

                        titleController
                            .text,

                        contentController
                            .text,
                      );

                      // Home으로 돌아가기
                      Get.back();
                    },

                    style:
                        ElevatedButton
                            .styleFrom(
                      backgroundColor:
                          Colors
                              .cyan,

                      foregroundColor:
                          Colors.white,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          8,
                        ),
                      ),
                    ),

                    child:
                        const Text(
                      '검사 일정 추가',
                      style:
                          TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

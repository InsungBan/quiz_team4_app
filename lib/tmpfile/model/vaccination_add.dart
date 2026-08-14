import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'model/vaccination_controller.dart';

class VaccinationAdd
    extends StatelessWidget {
  VaccinationAdd({super.key});

  final VaccinationController
      controller =
      Get.find<VaccinationController>();

  final TextEditingController
      nameController =
      TextEditingController();

  // 날짜 선택
  void selectDate(
    BuildContext context,
  ) {
    DateTime selectedDate =
        DateTime.now();

    if (controller.selectedDate
        .isNotEmpty) {
      List<String> dateList =
          controller.selectedDate
              .split('-');

      selectedDate = DateTime(
        int.parse(dateList[0]),
        int.parse(dateList[1]),
        int.parse(dateList[2]),
      );
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 350,

          color: Colors.white,

          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.all(10),

                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      },

                      child: const Text(
                        '취소',
                      ),
                    ),

                    const Text(
                      '날짜 선택',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        String date =
                            '${selectedDate.year}-'
                            '${selectedDate.month.toString().padLeft(2, '0')}-'
                            '${selectedDate.day.toString().padLeft(2, '0')}';

                        controller
                            .setDate(date);

                        Navigator.pop(
                          context,
                        );
                      },

                      child: const Text(
                        '확인',
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child:
                    CupertinoDatePicker(
                  mode:
                      CupertinoDatePickerMode
                          .date,

                  initialDateTime:
                      selectedDate,

                  minimumDate:
                      DateTime(2020),

                  maximumDate:
                      DateTime(2030),

                  onDateTimeChanged:
                      (date) {
                    selectedDate =
                        date;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          const Color(0xfffff8fc),

      appBar: AppBar(
        title: const Text(
          '예방접종 기록 추가',
        ),

        backgroundColor:
            Colors.cyan,

        foregroundColor:
            Colors.white,

        centerTitle: true,
      ),

      body: GetBuilder<
          VaccinationController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding:
                const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                const Text(
                  '예방접종 기록',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                // 접종명
                const Text(
                  '접종명',
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
                      nameController,

                  decoration:
                      InputDecoration(
                    hintText:
                        '예: 독감 예방접종',

                    filled: true,

                    fillColor:
                        Colors.white,

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        10,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // 접종 날짜
                const Text(
                  '접종 날짜',
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
                    selectDate(
                      context,
                    );
                  },

                  child: Container(
                    width:
                        double.infinity,

                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 15,
                      vertical: 18,
                    ),

                    decoration:
                        BoxDecoration(
                      color:
                          Colors.white,

                      border:
                          Border.all(
                        color:
                            Colors.grey,
                      ),

                      borderRadius:
                          BorderRadius
                              .circular(
                        10,
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

                        Expanded(
                          child: Text(
                            controller
                                    .selectedDate
                                    .isEmpty
                                ? '날짜를 선택하세요'
                                : controller
                                    .selectedDate,
                          ),
                        ),

                        const Icon(
                          Icons
                              .keyboard_arrow_down,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // 접종 상태
                const Text(
                  '접종 상태',
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                GestureDetector(
                  onTap: () {
                    controller
                        .setCompleted(
                      !controller
                          .isCompleted,
                    );
                  },

                  child: Container(
                    width:
                        double.infinity,

                    height: 55,

                    decoration:
                        BoxDecoration(
                      color: controller
                              .isCompleted
                          ? Colors.cyan
                          : Colors.grey[300],

                      borderRadius:
                          BorderRadius
                              .circular(
                        10,
                      ),
                    ),

                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,

                      children: [
                        Icon(
                          controller
                                  .isCompleted
                              ? Icons
                                  .check_circle
                              : Icons
                                  .radio_button_unchecked,

                          color:
                              controller
                                      .isCompleted
                                  ? Colors.white
                                  : Colors.black,
                        ),

                        const SizedBox(
                          width: 8,
                        ),

                        Text(
                          controller
                                  .isCompleted
                              ? '접종 완료'
                              : '접종 예정',

                          style: TextStyle(
                            color: controller
                                    .isCompleted
                                ? Colors.white
                                : Colors.black,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                // 추가 버튼
                SizedBox(
                  width:
                      double.infinity,

                  height: 55,

                  child:
                      ElevatedButton(
                    onPressed: () {
                      if (nameController
                          .text
                          .isEmpty) {
                        Get.snackbar(
                          '알림',
                          '접종명을 입력해주세요.',
                        );

                        return;
                      }

                      if (controller
                          .selectedDate
                          .isEmpty) {
                        Get.snackbar(
                          '알림',
                          '접종 날짜를 선택해주세요.',
                        );

                        return;
                      }

                      controller
                          .addVaccination(
                        nameController
                            .text,

                        controller
                            .selectedDate,

                        controller
                            .isCompleted,
                      );

                      Get.back();
                    },

                    style:
                        ElevatedButton
                            .styleFrom(
                      backgroundColor:
                          Colors.cyan,

                      foregroundColor:
                          Colors.white,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          10,
                        ),
                      ),
                    ),

                    child:
                        const Text(
                      '접종 기록 추가',
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
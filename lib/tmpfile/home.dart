import 'package:asdasd_asdasd_app/second_page.dart';
import 'package:asdasd_asdasd_app/model/health_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HealthController controller = Get.put(
    HealthController(),
  );

  // 시간 선택
  Future<void> selectTime(
    BuildContext context,
    int index,
  ) async {
    TimeOfDay? pickedTime =
        await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      String hour =
          pickedTime.hour.toString().padLeft(2, '0');

      String minute =
          pickedTime.minute.toString().padLeft(2, '0');

      controller.healthList[index]['time'] =
          '$hour:$minute';

      controller.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xfffdf8fc),

      appBar: AppBar(
        title: const Text(
          '건강 기록',
        ),

        centerTitle: true,

        backgroundColor:
            Colors.greenAccent,

        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => SecondPage(),
              );
            },

            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),

      body: GetBuilder<HealthController>(
        builder: (controller) {
          // 기록이 없을 때
          if (controller.healthList.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [
                  Text(
                    '검사 결과 분석',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  Text(
                    '등록된 건강 검진 기록이 없습니다.',
                  ),
                ],
              ),
            );
          }

          // 기록이 있을 때
          return ListView.builder(
            padding:
                const EdgeInsets.all(15),

            itemCount:
                controller.healthList.length,

            itemBuilder:
                (context, index) {
              final data =
                  controller.healthList[index];

              bool isSelected =
                  controller.selectedIndex ==
                      index;

              return GestureDetector(
                onTap: () {
                  controller.selectHealth(
                    index,
                  );
                },

                child: Container(
                  margin:
                      const EdgeInsets.only(
                    bottom: 15,
                  ),

                  padding:
                      const EdgeInsets.all(12),

                  decoration:
                      BoxDecoration(
                    color: Colors.white,

                    border: Border.all(
                      color: isSelected
                          ? Colors.black
                          : Colors.red,

                      width:
                          isSelected ? 2 : 1,
                    ),

                    borderRadius:
                        BorderRadius.circular(
                      12,
                    ),
                  ),

                  child: Row(
                    children: [
                      // 왼쪽 선택 아이콘
                      Icon(
                        isSelected
                            ? Icons
                                .radio_button_checked
                            : Icons
                                .radio_button_unchecked,

                        color:
                            Colors.red,

                        size: 20,
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      // 가운데 내용
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [
                            Text(
                              data['title'] ??
                                  '',

                              style:
                                  const TextStyle(
                                fontSize: 15,
                                fontWeight:
                                    FontWeight.bold,
                                color:
                                    Colors.cyan,
                              ),
                            ),

                            const SizedBox(
                              height: 5,
                            ),

                            Text(
                              data['content'] ??
                                  '',

                              style:
                                  const TextStyle(
                                fontSize: 12,
                              ),
                            ),

                            const SizedBox(
                              height: 5,
                            ),

                            Text(
                              data['date'] ??
                                  '',

                              style:
                                  const TextStyle(
                                fontSize: 10,
                                color:
                                    Colors.pink,
                              ),
                            ),

                            // 선택한 시간
                            if (data['time'] !=
                                null)
                              Text(
                                '검사 시간: ${data['time']}',
                                style:
                                    const TextStyle(
                                  fontSize: 11,
                                  color:
                                      Colors.black,
                                ),
                              ),
                          ],
                        ),
                      ),

                      // 오른쪽 시계 아이콘
                      IconButton(
                        onPressed: () {
                          selectTime(
                            context,
                            index,
                          );
                        },

                        icon: const Icon(
                          Icons
                              .access_time_outlined,

                          color:
                              Colors.purple,

                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
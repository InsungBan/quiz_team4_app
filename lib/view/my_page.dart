import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'vaccination_add.dart';
import '../model/vaccination_controller.dart';

class MyPage extends StatelessWidget {
  MyPage({super.key});

  final VaccinationController controller =
      Get.put(
    VaccinationController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text(
          'Medical Calendar',
        ),

        centerTitle: true,

        backgroundColor:
            Colors.cyan,

        foregroundColor:
            Colors.white,

        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => VaccinationAdd(),
              );
            },

            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),

      body: GetBuilder<
          VaccinationController>(
        builder: (controller) {
          return Padding(
            padding:
                const EdgeInsets.all(15),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                const Text(
                  'Vaccinations',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                const Text(
                  'Immunisation history',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                const Row(
                  children: [
                    Expanded(
                      child: Text(''),
                    ),

                    Text('Y'),

                    SizedBox(
                      width: 20,
                    ),

                    Text('M'),

                    SizedBox(
                      width: 20,
                    ),

                    Text('D'),
                  ],
                ),

                const Divider(),

                // 예방접종 기록이 없을 때
                if (controller
                    .vaccinationList
                    .isEmpty)
                  const Padding(
                    padding:
                        EdgeInsets.all(10),

                    child: Text(
                      '등록된 예방접종 기록이 없습니다.',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),

                // 예방접종 기록
                ...List.generate(
                  controller
                      .vaccinationList
                      .length,

                  (index) {
                    final data =
                        controller
                            .vaccinationList[
                                index];

                    return Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        vertical: 12,
                      ),

                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              data['name'] ??
                                  '',
                            ),
                          ),

                          Text(
                            data['date'] ??
                                '',
                          ),

                          const SizedBox(
                            width: 10,
                          ),

                          Text(
                            data['completed'] ??
                                '',
                            style: TextStyle(
                              color: data[
                                          'completed'] ==
                                      '완료'
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(
                  height: 20,
                ),

                const Text(
                  'Next Immunisations due',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                const Row(
                  children: [
                    Expanded(
                      child: Text(''),
                    ),

                    Text('Y'),

                    SizedBox(
                      width: 20,
                    ),

                    Text('M'),

                    SizedBox(
                      width: 20,
                    ),

                    Text('D'),
                  ],
                ),

                const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}

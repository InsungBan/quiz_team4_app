import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gps_map_app/view/gps.dart';
import 'package:gps_map_app/view/register.dart';
import 'package:gps_map_app/view/set_record.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late TextEditingController userIdController;
  late TextEditingController userPwController;
  final box = GetStorage();                             // GetStrage 생성
  List<Map<String, String>> userIdList = [
    {'userId': 'pikachu', 'password': 'pikapika'},
    {'userId': 'jaebbang', 'password': '1234'},
  ];

  @override
  void initState() {
    super.initState();
    userIdController = TextEditingController();
    userPwController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24),
          )
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Specialties',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Find Your Doctor',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.to(Gps());
                  },
                  icon: Icon(
                    Icons.location_on,
                    size: 35,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                IconButton(
                  onPressed: () {
                    Get.to(Register(userIdList: userIdList));
                  }, 
                  icon: Icon(
                    Icons.new_label,
                    size: 35,
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
        toolbarHeight: 120,
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0,15,20,15),
        child: Container(
          width: 400,
          height: 200,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 255, 251),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.cyan,
              width: 2.0,
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30,0,30,0),
                child: TextField(
                  controller: userIdController,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30,0,30,0),
                child: TextField(
                  controller: userPwController,
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if(userIdController.text.trim().isEmpty || userPwController.text.trim().isEmpty) {
                    errorSnackBar();
                  } else {
                    checkData();
                  }
                }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  foregroundColor: Colors.white,
                ),
                child: Text('Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Functions
  // ID와 비밀번호 입력 여부 확인 후 경고 메시지 출력
  void errorSnackBar() {
    Get.snackbar(
      '경고',
      'ID와 비밀번호를 입력하세요',
      duration: Duration(seconds: 1),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }

  // ID와 비밀번호 일치 여부 확인 후 경고 메시지 출력
  void checkSnackBar() {
    Get.defaultDialog(
      title: '비밀번호 불일치', 
      titleStyle: TextStyle(
        fontSize: 20,
      ),
      middleText: '',
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          }, 
          child: Text('Exit'),)
      ], 
    );
  }

  void checkId(){
      Get.defaultDialog(
        title: '존재하지 않는 유저',
        titleStyle: TextStyle(
          fontSize: 20,
        ),
        middleText: '',
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            }, 
            child: Text('Exit'),)
        ], 
      );
  }

  // ID 중복 체크 및 비밀번호 확인 체크 후 회원가입 처리
  void checkData() {
    if(userIdController.text.trim().isEmpty || userPwController.text.trim().isEmpty) {
      errorSnackBar();
    } 
    else {
      bool userFound = false;
      bool userIdfound = false;
      for (var user in userIdList) {
        if(userIdController.text.trim() == user['userId']){
          userIdfound=true;
        }
      }
      for (var user in userIdList) {
        if (userIdController.text.trim() == user['userId'] && userPwController.text.trim() == user['password']) {
          userFound = true;
          userIdController.text='';
          userPwController.text='';
          Get.to(SetRecord());
          // _showDialog();
          break;
        }
      }
      if (!userIdfound) {
        checkId();
      }else if(!userFound){
        checkSnackBar();
      }
    }
  }

  // 로그인 성공 시 다이얼로그 표시
  // void _showDialog() {
  //   Get.defaultDialog(
  //     title: '로그인 완료',
  //     middleText: '환영합니다 ${userIdController.text.trim()}님!',
  //     barrierDismissible: false,
  //     backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
  //     actions: [
  //       TextButton(
  //         onPressed: () {
  //           box.write('p_userId', userIdEditingController.text.trim());
  //           userIdEditingController.text = "";
  //           passwordEditingController.text = "";
  //           Navigator.of(context).pop();
  //           Get.to(
  //             Generation(),
  //             transition: Transition.circularReveal,
  //             duration: Duration(seconds: 2)
  //           );
  //         },
  //         child: Text('OK'),
  //       ),
  //     ]
  //   );
  // }
}
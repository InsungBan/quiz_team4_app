import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quiz_team4_app/view/gps.dart';
import 'package:quiz_team4_app/view/register.dart';
import 'package:quiz_team4_app/view/set_record.dart';

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
  String? loggedInUser;
  double? loggedUserWeight;
  double? loggedUserHeight;
  String? loggedUserBlood;
  List<Map<String, String>> userIdList = [
    {'userId': 'pikachu', 'password': 'pikapika'},
    {'userId': 'jaebbang', 'password': '1234'},
  ];

  @override
  void initState() {
    super.initState();
    userIdController = TextEditingController();
    userPwController = TextEditingController();
    // 읽어온 로그인 정보가 있으면 보여주기
    loggedInUser = box.read('p_userId');
    if (loggedInUser != null) {
      _loadUserData(loggedInUser!);
    }
    // 저장된 사용자 목록 로드
    final List? stored = box.read('users');
    if (stored != null) {
      try {
        userIdList = List<Map<String, String>>.from(stored.map((e) => Map<String, String>.from(e)));
      } catch (_) {
        // ignore parsing errors
      }
    }
  }

  void _loadUserData(String userId) {
    final weight = box.read('user_${userId}_weight');
    final height = box.read('user_${userId}_height');
    final blood = box.read('user_${userId}_blood');
    // Debug: print raw stored values
    debugPrint('Loaded storage for $userId -> weight: $weight, height: $height, blood: $blood');
    setState(() {
      loggedUserWeight = (weight is num) ? weight.toDouble() : null;
      loggedUserHeight = (height is num) ? height.toDouble() : null;
      loggedUserBlood = (blood is String) ? blood : null;
    });
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
                    Get.to(Register(userIdList: userIdList))?.then((result) {
                          if (result == true) {
                            // 새로 저장된 사용자 목록이 있으면 로드
                            final List? stored = box.read('users');
                            if (stored != null) {
                              try {
                                userIdList = List<Map<String, String>>.from(stored.map((e) => Map<String, String>.from(e)));
                              } catch (_) {}
                            }
                            // 자동 로그인으로 설정된 사용자 정보 로드
                            loggedInUser = box.read('p_userId');
                            if (loggedInUser != null) {
                              _loadUserData(loggedInUser!);
                            }
                            setState(() {});
                          }
                        });
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
          height: 300,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 255, 251),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.cyan,
              width: 2.0,
            )
          ),
          child: loggedInUser != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_circle,
                          size: 30,
                          color: Colors.cyan,
                        ),
                        Text(
                          '  ${box.read('p_user')}님 환영합니다!',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.cyan),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Divider(
                      color: Colors.cyan,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    const SizedBox(height: 12),
                    // 사용자 데이터 표시
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text('키', style: TextStyle(color: Colors.grey)),
                              Text(
                                loggedUserHeight != null ? '${loggedUserHeight!.toStringAsFixed(0)} cm' : '-',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text('몸무게', style: TextStyle(color: Colors.grey)),
                              Text(
                                loggedUserWeight != null ? '${loggedUserWeight!.toStringAsFixed(0)} kg' : '-',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text('혈액형', style: TextStyle(color: Colors.grey)),
                              Text(
                                loggedUserBlood ?? '-',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    const SizedBox(height: 100),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.cyan,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      onPressed: () {
                        // 로그아웃
                        box.remove('p_userId');
                        setState(() {
                          loggedInUser = null;
                          loggedUserWeight = null;
                          loggedUserHeight = null;
                          loggedUserBlood = null;
                        });
                      },
                      child: const Text('로그아웃'),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30,0,30,0),
                      child: TextField(
                        controller: userIdController,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30,0,30,0),
                      child: TextField(
                        controller: userPwController,
                        obscureText: true,
                      ),
                    ),
                    SizedBox(
                      height: 30,
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
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
  void checkData() async {
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
            // 로그인 상태 저장
            box.write('p_userId', userIdController.text.trim());
            setState(() {
              loggedInUser = userIdController.text.trim();
            });
            userIdController.text='';
            userPwController.text='';
            // 프로필 입력 화면으로 이동 후 돌아오면 사용자 데이터 로드
            await Get.to(SetRecord());
            if (loggedInUser != null) {
              _loadUserData(loggedInUser!);
            }
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
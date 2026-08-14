import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quiz_team4_app/view/set_record.dart';

class Register extends StatefulWidget {
  final List<Map<String,String>> userIdList;
  const Register({super.key, required this.userIdList});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Property
  late TextEditingController nameController;
  late TextEditingController idController;
  late TextEditingController pwController;
  late TextEditingController rePwController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    idController = TextEditingController();
    pwController = TextEditingController();
    rePwController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: '사용할 이름을 입력하세요',
                ),
              ),
              TextField(
                controller: idController,
                decoration: InputDecoration(
                  labelText: '사용할 ID를 입력하세요',
                ),
              ),
              TextField(
                controller: pwController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '사용할 비밀번호를 입력하세요',
                ),
              ),
              TextField(
                controller: rePwController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '비밀번호를 재확인하세요',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                if (nameController.text.trim().isEmpty||
                    idController.text.trim().isEmpty ||
                    pwController.text.trim().isEmpty ||
                    rePwController.text.trim().isEmpty) {
                  errorSnackBar();
                } else {
                  checkData();
                }

                }, 
                child: Text('가입하기'),
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
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      duration: Duration(seconds: 1),
    );
  }

  // ID 중복 체크 및 비밀번호 확인 체크 후 회원가입 처리
  void checkData() {
    if(pwController.text.trim() != rePwController.text.trim()) {
      Get.snackbar(
        '경고',
        '비밀번호가 일치하지 않습니다.',
        duration: Duration(seconds: 1),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      );
    } else if (widget.userIdList.any((user) => user['userId'] == idController.text.trim())) {
      Get.snackbar(
        '경고',
        '이미 존재하는 아이디입니다.',
        duration: Duration(seconds: 1),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      );
    } else {
      final newUser = {
        'userId': idController.text.trim(),
        'password': pwController.text.trim(),
        'name': nameController.text.trim(),
      };
      Get.defaultDialog(
        title: '확인',
        middleText: '정말 ${idController.text.trim()}로 가입하시겠습니까?',
        backgroundColor: Colors.white,
        barrierDismissible: false,
        actions: [
          TextButton(
            onPressed: () async {
              final box = GetStorage();
              final List stored = box.read('users') ?? [];
              stored.add(newUser);
              box.write('users', stored);
              // 자동 로그인 처리
              box.write('p_userId', newUser['userId']);
              box.write('p_user', newUser['name']);
              // 닫기 (다이얼로그)
              Get.back();
              initTextField();

              // 프로필 설정으로 이동하고 완료되면 가입 화면을 닫아 Home으로 돌아감
              await Get.to(SetRecord(), arguments: newUser);
              Navigator.of(context).pop(true);
            },
            child: Text('예'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('아니오'),
          ),
        ],
      );
    }
  }

  // 텍스트필드 초기화 함수
  void initTextField(){
    nameController.text='';
    idController.text='';
    pwController.text='';
    rePwController.text='';
  }
}
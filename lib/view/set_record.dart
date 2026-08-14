import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SetRecord extends StatefulWidget {
  const SetRecord({super.key});

  @override
  State<SetRecord> createState() => _SetRecordState();
}

class _SetRecordState extends State<SetRecord> {
  // Property
  late bool maleState;
  late Color maleBackColor;
  late Color maleForeColor;
  late bool femaleState;
  late Color femaleBackColor;
  late Color femaleForeColor;
  late bool otherState;
  late Color otherBackColor;
  late Color otherForeColor;
  late double oldValue;
  late double weightValue;
  late double heightValue;
  late List<String> bloodList;
  late int selectedBlood;

  @override
  void initState() {
    super.initState();
    maleState=true;
    maleBackColor=Colors.cyan;
    maleForeColor=Colors.white;
    femaleState=false;
    femaleBackColor=Colors.white;
    femaleForeColor=Colors.cyan;
    otherState=false;
    otherBackColor=Colors.white;
    otherForeColor=Colors.cyan;
    oldValue = 0;
    weightValue=0;
    heightValue=0;
    bloodList=[
      'A+',
      'A-',
      'B+',
      'B-',
      'O+',
      'O-',
      'AB+',
      'AB-',
    ];
    selectedBlood=0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('+ Set Record'),
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'What is your gender',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      checkButton(0);
                    }, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: maleBackColor,
                      foregroundColor: maleForeColor,
                    ),
                    child: Text('Male'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      checkButton(1);
                    }, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: femaleBackColor,
                      foregroundColor: femaleForeColor,
                    ),
                    child: Text('Female'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      checkButton(2);
                    }, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: otherBackColor,
                      foregroundColor: otherForeColor,
                    ),
                    child: Text('Other'),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  'How old are you',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Slider(
              value: oldValue, 
              onChanged: (value) {
                oldValue=value;
                setState(() {});
              },
              activeColor: Colors.cyan,
              min: 0,
              max: 100,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0,10,20,10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '0',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ), 
                  Text(
                    oldValue.toStringAsFixed(0),
                    style: TextStyle(
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '100',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ), 
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  'What is your weight',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Slider(
              value: weightValue, 
              onChanged: (value) {
                weightValue=value;
                setState(() {});
              },
              activeColor: Colors.cyan,
              min: 0,
              max: 200,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0,10,20,10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '0',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ), 
                  Text(
                    weightValue.toStringAsFixed(0),
                    style: TextStyle(
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '200',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ), 
                ],
              ),
            ),            
            Row(
              children: [
                Text(
                  'What is your height',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Slider(
              value: heightValue, 
              onChanged: (value) {
                heightValue=value;
                setState(() {});
              },
              activeColor: Colors.cyan,
              min: 0,
              max: 200,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0,10,20,10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '0',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ), 
                  Text(
                    heightValue.toStringAsFixed(0),
                    style: TextStyle(
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '200',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ), 
                ],
              ),
            ),            
            Row(
              children: [
                Text(
                  'What is your blood type',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            DropdownButton(
              value: selectedBlood,
              items: List.generate(
                bloodList.length, 
                (index) {
                  return DropdownMenuItem<int>(
                    value: index,
                    child: Text(
                      bloodList[index],
                    ),
                  );
                },
              ), 
              onChanged: (value) {
                selectedBlood = value!;
                setState(() {});
              },
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                // 로그인된 유저가 있으면 해당 유저 정보로 저장
                final box = GetStorage();
                final userId = box.read('p_userId');
                if (userId != null) {
                  box.write('user_${userId}_weight', weightValue);
                  box.write('user_${userId}_height', heightValue);
                  box.write('user_${userId}_blood', bloodList[selectedBlood]);
                }
                Get.back();
              }, 
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  // Functions
  void checkButton(int button){
    switch(button){
      case 0:
        maleState=true;
        maleBackColor=Colors.cyan;
        maleForeColor=Colors.white;
        femaleState=false;
        femaleBackColor=Colors.white;
        femaleForeColor=Colors.cyan;
        otherState=false;
        otherBackColor=Colors.white;
        otherForeColor=Colors.cyan;
      case 1:
        maleState=false;
        maleBackColor=Colors.white;
        maleForeColor=Colors.cyan;
        femaleState=true;
        femaleBackColor=Colors.cyan;
        femaleForeColor=Colors.white;
        otherState=false;
        otherBackColor=Colors.white;
        otherForeColor=Colors.cyan;
      case 2:
        maleState=false;
        maleBackColor=Colors.white;
        maleForeColor=Colors.cyan;
        femaleState=false;
        femaleBackColor=Colors.white;
        femaleForeColor=Colors.cyan;
        otherState=true;
        otherBackColor=Colors.cyan;
        otherForeColor=Colors.white;
    }
    setState(() {});
  }
}
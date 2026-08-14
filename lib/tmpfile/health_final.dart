import 'package:flutter/material.dart';

class HealthFinal extends StatefulWidget {
  const HealthFinal({super.key});

  @override
  State<HealthFinal> createState() => _HealthFinalState();
}

class _HealthFinalState extends State<HealthFinal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("건강 기록"),
      ),
    );
  }
}
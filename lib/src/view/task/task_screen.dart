import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen(
      {super.key, required this.firstColor, required this.secondColor});

  final Color firstColor;
  final Color secondColor;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [widget.firstColor, widget.secondColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          )
        ],
      ),
    );
  }
}

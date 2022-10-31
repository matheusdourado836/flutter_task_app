import 'package:flutter/material.dart';
import 'package:flutter_task_app/data/task_inherited.dart';
import 'package:flutter_task_app/screens/form_screen.dart';
import 'dart:math';

import 'package:flutter_task_app/screens/initial_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskInherited(child: const InitialScreen()),
    );
  }
}

class CreateForm extends StatefulWidget {
  final Color cor1;
  final Color cor2;
  final Color cor3;

  const CreateForm(
      {Key? key, required this.cor1, required this.cor2, required this.cor3})
      : super(key: key);

  @override
  State<CreateForm> createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> {
  String img = 'http://lorempixel.com.br/500/400/?1';
  String img2 = 'http://lorempixel.com.br/500/400/?2';
  String img3 = 'http://lorempixel.com.br/500/400/?3';

  void _changeImg() {
    var random = Random().nextInt(100);
    setState(() {
      img = 'http://lorempixel.com.br/500/400/?$random';
    });
  }

  void _changeImg2() {
    var random = Random().nextInt(100);
    setState(() {
      img2 = 'http://lorempixel.com.br/500/400/?$random';
    });
  }

  void _changeImg3() {
    var random = Random().nextInt(100);
    setState(() {
      img3 = 'http://lorempixel.com.br/500/400/?$random';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  _changeImg();
                },
                child: Ink(
                  height: 150,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26, width: 4),
                    borderRadius: BorderRadius.circular(6),
                    color: widget.cor1,
                  ),
                  child: Ink.image(
                    fit: BoxFit.cover,
                    image: NetworkImage(img),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _changeImg2();
                },
                child: Ink(
                  height: 150,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26, width: 4),
                    borderRadius: BorderRadius.circular(6),
                    color: widget.cor2,
                  ),
                  child: Ink.image(
                    fit: BoxFit.cover,
                    image: NetworkImage(img2),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _changeImg3();
                },
                child: Ink(
                  height: 150,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26, width: 4),
                    borderRadius: BorderRadius.circular(6),
                    color: widget.cor3,
                  ),
                  child: Ink.image(
                    fit: BoxFit.cover,
                    image: NetworkImage(img3),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

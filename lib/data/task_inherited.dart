import 'package:flutter/material.dart';
import 'package:flutter_task_app/components/create_task.dart';

class TaskInherited extends InheritedWidget {
   TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<CreateTask> taskList = [
    // CreateTask('Tocar guitarra', 'assets/images/guitar.png', 1, 0),
    // CreateTask('Aprender Flutter', 'assets/images/dash.png', 2, 0),
    // CreateTask('Tocar Teclado', 'assets/images/piano.jpg', 1, 0),
    // CreateTask('Meditar', 'assets/images/meditar.jpeg', 2, 0),
    // CreateTask('Jogar', 'assets/images/jogar.jpg', 1, 0),
  ];

  void newTask(String name, String photo, int difficulty, int level) {
    // taskList.add(CreateTask(name, photo, difficulty, level));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result = context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}

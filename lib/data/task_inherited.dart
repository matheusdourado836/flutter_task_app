import 'package:flutter/material.dart';
import 'package:flutter_task_app/components/create_task.dart';

class TaskInherited extends InheritedWidget {
   TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<CreateTask> taskList = [
    CreateTask('Tocar guitarra', 'assets/images/guitar.png', 1),
    CreateTask('Aprender Flutter', 'assets/images/dash.png', 2),
    CreateTask('Tocar Teclado', 'assets/images/piano.jpg', 1),
    CreateTask('Meditar', 'assets/images/meditar.jpeg', 3),
    CreateTask('Jogar', 'assets/images/jogar.jpg', 1,),
  ];

  void newTask(String name, String photo, int difficulty) {
    taskList.add(CreateTask(name, photo, difficulty));
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

import 'package:flutter/material.dart';
import 'package:flutter_task_app/data/task_inherited.dart';
import 'package:flutter_task_app/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

double levelTotal = 0;

double sumLevel(List list) {
  double sum = 0;
  String sumFormated = '';
  double qtdNiveis = 0;
  list.forEach((element) {
    switch (element.currentLevel) {
      case 1:
        {
          sum += element.nivel;
        }
        break;
      case 2:
        {
          sum += element.nivel + (10 * element.dificuldade);
        }
        break;
      case 3:
        {
          sum += element.nivel + (20 * element.dificuldade);
        }
        break;
      case 4:
        {
          sum += element.nivel + (30 * element.dificuldade);
          print(element.currentLevel);
        }
        break;
      case 5:
        {
          sum += element.nivel + (40 * element.dificuldade);
          print(element.currentLevel);
        }
        break;
      case 6:
        {
          sum += element.dificuldade * 50;
        }
    }
    qtdNiveis += element.dificuldade * 50;
  });
  print('O total de niveis é de $qtdNiveis');
  print('soma: $sum');
  sumFormated = sum.toStringAsFixed(3);

  return sum.toDouble() / qtdNiveis;
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacidade = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Tarefas'),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Progresso: ${levelTotal * 100}%'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: 150,
                    child: LinearProgressIndicator(
                      color: Colors.white,
                      value: levelTotal,
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  levelTotal;
                });
                levelTotal = sumLevel(TaskInherited.of(context).taskList);
              },
              icon: const Icon(Icons.restart_alt),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  opacidade = !opacidade;
                });
              },
              icon: opacidade
                  ? const Icon(Icons.remove_red_eye_rounded)
                  : const Icon(Icons.remove_red_eye_outlined),
            ),
          ],
        ),
      ),
      body: AnimatedOpacity(
        opacity: opacidade ? 1 : 0,
        duration: const Duration(milliseconds: 800),
        child: ListView(
          padding: const EdgeInsets.only(top: 8, bottom: 50),
          children: TaskInherited.of(context).taskList,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contextNew) => FormScreen(taskContext: context),
              ),
            );
          },
          child: const Icon(Icons.add)),
    );
  }
}

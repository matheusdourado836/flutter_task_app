import 'package:flutter/material.dart';
import 'package:flutter_task_app/components/create_task.dart';
import 'package:flutter_task_app/screens/form_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../data/task_dao.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

double levelTotal = 0;

double formatLevel(double level) {
  level = level * 100;
  var formatedLevel = level.toStringAsFixed(2);

  return double.parse(formatedLevel);
}

sumLevel(List<CreateTask> tasks) {
  double sum = 0;
  double qtdNiveis = 0;
  tasks.forEach((element) {
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
        }
        break;
      case 5:
        {
          sum += element.nivel + (40 * element.dificuldade);
        }
        break;
      case 6:
        {
          sum += element.dificuldade * 50;
        }
    }
    qtdNiveis += element.dificuldade * 50;
  });
  levelTotal = sum / qtdNiveis;
  return levelTotal;
}

masteryColor(CreateTask task) {
  switch (task.currentLevel) {
    case 1:
      {
        return Colors.blue;
      }
    case 2:
      {
        return Colors.yellow[600];
      }
    case 3:
      {
        return Colors.orange;
      }
    case 4:
      {
        return Colors.green;
      }
    case 5:
      {
        return Colors.red;
      }
    case 6:
      {
        task.maxLevel = true;
        task.nivel = 0;
        return Colors.black;
      }
  }
}

class _InitialScreenState extends State<InitialScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  bool opacidade = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Progresso: ${formatLevel(levelTotal)}%',),
                ),
                SizedBox(
                  width: 150,
                  child: LinearProgressIndicator(
                    color: Colors.white,
                    value: levelTotal,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                setState(() {
                });
              },
              icon: const Icon(Icons.restart_alt),
            ),
          ],
        ),
      ),
      body: AnimatedOpacity(
        opacity: opacidade ? 1 : 0,
        duration: const Duration(milliseconds: 800),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 70),
          child: FutureBuilder<List<CreateTask>>(
              future: TaskDao().findAll(),
              builder: (context, snapshot) {
                List<CreateTask>? items = snapshot.data;
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          Text('Carregando'),
                        ],
                      ),
                    );
                  case ConnectionState.waiting:
                    Center(
                      child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          Text('Carregando'),
                        ],
                      ),
                    );
                    break;
                  case ConnectionState.active:
                    Center(
                      child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          Text('Carregando'),
                        ],
                      ),
                    );
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasData && items != null) {
                      if (items.isNotEmpty) {
                        return ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (BuildContext context, int index) {
                              final CreateTask tarefa = items[index];
                              items[index].nivel = items[index].level!;
                              items[index].currentLevel = items[index].mastery;
                              items[index].cor = masteryColor(items[index]);
                              sumLevel(items);
                              return Slidable(
                                  startActionPane: ActionPane(
                                    extentRatio: 0.25,
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          showDialog<void>(context: context, builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Deseja deletar esta tarefa?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context, 'Não'),
                                                  child: const Text('Não'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    TaskDao()
                                                        .delete(items[index].taskName);
                                                    setState((){});
                                                    Navigator.pop(
                                                        context, 'Sim');
                                                  },
                                                  child: const Text('Sim'),
                                                ),
                                              ],
                                            );
                                          });
                                        },
                                        icon: Icons.delete,
                                        label: 'Deletar',
                                        backgroundColor: Colors.red,
                                      ),
                                    ],
                                  ),
                                  endActionPane: ActionPane(
                                    extentRatio: 0.25,
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          showDialog<void>(context: context, builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Insira os novos valores', textAlign: TextAlign.center,),
                                              content: SizedBox(
                                                height: 150,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: TextField(
                                                        controller: nameController,
                                                        textAlign: TextAlign.center,
                                                        decoration: const InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          hintText: 'Novo Nome',
                                                          fillColor: Colors.white70,
                                                          filled: true,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: TextField(
                                                        controller: imageController,
                                                        textAlign: TextAlign.center,
                                                        decoration: const InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          hintText: 'Nova Imagem',
                                                          fillColor: Colors.white70,
                                                          filled: true,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () async {
                                                      if(nameController.text.isEmpty) {
                                                        nameController.text = tarefa.taskName;
                                                      }
                                                      if(imageController.text.isEmpty) {
                                                        imageController.text = tarefa.foto;
                                                      }
                                                      await TaskDao().updateUrlAndName(nameController.text, imageController.text, tarefa.taskName).then((value) =>{
                                                        setState(() => {})
                                                      } );
                                                      Navigator.pop(context, 'SALVAR');
                                                    },
                                                    child: const Text('SALVAR')),
                                              ],
                                            );
                                          });
                                        },
                                        icon: Icons.edit_rounded,
                                        label: 'Editar',
                                        backgroundColor: Colors.blueAccent,
                                      ),
                                    ],
                                  ),
                                  child: tarefa);
                            });
                      }
                      return Center(
                        child: Column(
                          children: const [
                            Icon(
                              Icons.error_outline,
                              size: 128,
                            ),
                            Text(
                              'Não há nenhuma tarefa',
                              style: TextStyle(fontSize: 32),
                            ),
                          ],
                        ),
                      );
                    }
                    return const Text('Erro ao carregar Tarefas!');
                }
                return const Text('Erro desconhecido');
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contextNew) => FormScreen(taskContext: context),
              ),
            ).then((value) => {setState(() {})});
          },
          child: const Icon(Icons.add)),
    );
  }
}


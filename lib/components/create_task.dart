import 'package:flutter/material.dart';
import 'package:flutter_task_app/components/difficulty.dart';
import 'package:flutter_task_app/data/task_dao.dart';

class CreateTask extends StatefulWidget {
  final String taskName;
  final String foto;
  final int dificuldade;
  final int? level;
  final int mastery;

  CreateTask(this.taskName, this.foto, this.dificuldade, this.level, this.mastery, {Key? key})
      : super(key: key);

  int nivel = 0;
  int currentLevel = 1;
  bool maxLevel = false;
  bool infoChanged = false;
  Color? cor = Colors.blue;
  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  bool isAsset() {
    if(widget.foto.contains('http')) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: widget.cor,
            ),
          ),
          Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 72,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black26),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: isAsset()
                            ? Image.asset(
                                widget.foto,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                widget.foto,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              widget.taskName,
                              style: const TextStyle(
                                  fontSize: 24,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          Difficulty(
                            difficultyLevel: widget.dificuldade,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      width: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            widget.infoChanged = true;
                            widget.nivel++;
                            switch (widget.currentLevel) {
                              case 1:
                                {
                                  widget.cor = Colors.blue;
                                }
                                break;
                              case 2:
                                {
                                  widget.cor = Colors.yellow[600];
                                }
                                break;
                              case 3:
                                {
                                  widget.cor = Colors.orange;
                                }
                                break;
                              case 4:
                                {
                                  widget.cor = Colors.green;
                                }
                                break;
                              case 5:
                                {
                                  widget.cor = Colors.red;
                                }
                                break;
                              case 6:
                                {
                                  widget.cor = Colors.black;
                                  widget.maxLevel = true;
                                  widget.nivel = 0;
                                }
                                break;
                            }
                            if (widget.nivel / widget.dificuldade > 10) {
                              widget.nivel = 0;
                              widget.currentLevel++;
                            }
                          });
                          await TaskDao().updateLevel(widget.nivel, widget.currentLevel, widget.taskName);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(Icons.arrow_drop_up),
                            Text(
                              'Up',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: (widget.nivel > 0 && widget.maxLevel == false)
                            ? (widget.nivel / widget.dificuldade) / 10
                            : 0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.maxLevel
                        ? const Text(
                            'Máx lvl',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                      'Nível: ${widget.nivel}',
                      style: const TextStyle(
                          fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


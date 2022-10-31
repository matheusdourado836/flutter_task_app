import 'package:flutter/material.dart';
import 'package:flutter_task_app/components/difficulty.dart';

class CreateTask extends StatefulWidget {
  final String taskName;
  final String foto;
  final int dificuldade;

  CreateTask(this.taskName, this.foto, this.dificuldade, {Key? key})
      : super(key: key);

  int nivel = 0;
  int contador = 0;
  int currentLevel = 1;
  bool maxLevel = false;
  bool nextLevel = false;
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
              color: widget.nextLevel ? widget.cor : Colors.blue,
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
                        onPressed: () {
                          setState(() {
                            widget.infoChanged = true;
                            widget.nivel++;
                            if (widget.nivel / widget.dificuldade > 10) {
                              widget.nextLevel = true;
                              widget.nivel = 0;
                              widget.contador++;
                              switch (widget.contador) {
                                case 1:
                                  {
                                    widget.cor = Colors.yellow[600];
                                    widget.currentLevel = 2;
                                  }
                                  break;
                                case 2:
                                  {
                                    widget.cor = Colors.orange;
                                    widget.currentLevel = 3;
                                  }
                                  break;
                                case 3:
                                  {
                                    widget.cor = Colors.green;
                                    widget.currentLevel = 4;
                                  }
                                  break;
                                case 4:
                                  {
                                    widget.cor = Colors.red;
                                    widget.currentLevel = 5;
                                  }
                                  break;
                                case 5:
                                  {
                                    widget.cor = Colors.black;
                                    widget.currentLevel = 6;
                                    widget.maxLevel = true;
                                  }
                                  break;
                              }
                            }
                          });
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
                            : 1,
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

import 'package:flutter/material.dart';
import 'package:flutter_tasklist/database_helper.dart';
import 'package:flutter_tasklist/models/task.dart';
import 'package:flutter_tasklist/models/todo.dart';
import 'package:flutter_tasklist/widgets.dart';

class Taskpage extends StatefulWidget {
  final task;
  Taskpage({required this.task});

  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  String _tasktitle = "";
  String _taskDescription = "";

  @override
  void initState() {
    if (widget.task != null) {
      _tasktitle = widget.task.title;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 24.0,
                      bottom: 6.0,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Image(
                              image: AssetImage('images/back_arrow_icon.png'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onSubmitted: (value) async {
                              print("Field Value: $value");
                              if (value != "") {
                                if (widget.task == null) {
                                  DatabaseHelper _dbHelper = DatabaseHelper();
                                  Task _newtask = Task(title: value);
                                  await _dbHelper.insertTask(_newtask);
                                } else {
                                  print("Update the existing task");
                                }
                              }
                            },
                            controller: TextEditingController()
                              ..text = _tasktitle,
                            decoration: InputDecoration(
                              hintText: 'Enter Task Title',
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0XFF211551),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 17.0,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter Description for the Task...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 20.0,
                              height: 20.0,
                              margin: EdgeInsets.only(right: 12.0),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(6.0),
                                  border: Border.all(
                                    color: Color(0XFF86829D),
                                    width: 1.5,
                                  )),
                            ),
                            Expanded(
                              child: TextField(
                                onSubmitted: (value) async {
                                  if (value != "") {
                                    if (widget.task != null) {
                                      DatabaseHelper _dbHelper =
                                          DatabaseHelper();
                                      Todo _newTodo = Todo(
                                        title: value,
                                        isDone: 0,
                                        taskId: widget.task.id,
                                      );
                                      await _dbHelper.insertTodo(_newTodo);
                                    }
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter todo item...",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 24.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Taskpage(task: Null),
                      ),
                    );
                  },
                  child: Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFFE3577),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Image(
                      image: AssetImage('images/delete_icon.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

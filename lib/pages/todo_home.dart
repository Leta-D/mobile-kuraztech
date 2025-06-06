import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_provider.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  int bottomIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [AllTaskPage(), CompletedTaskPage()];
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(40, 60, 155, 0.8),
        elevation: 6,
        shadowColor: Colors.black,
      ),

      body: pages[bottomIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomIndex,
        selectedFontSize: 16,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.blue,
        onTap: (value) {
          setState(() {
            bottomIndex = value;
          });
        },
        // type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined),
            label: "All",
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined),
            label: "Completed",
            backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
}

class AllTaskPage extends StatelessWidget {
  final _taskAddController = TextEditingController();

  AllTaskPage({super.key});
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TodoTaskProvider>(context);
    String taskText = "";

    return Container(
      color: Color.fromRGBO(40, 60, 155, 0.4),
      child: ListView(
        padding: EdgeInsets.all(30),
        children: [
          TextField(
            decoration: InputDecoration(
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(66, 191, 245, 1)),
              ),
              hintText: "Add a new task",
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  if (taskText != "") {
                    taskProvider.addTask(TaskModel(taskText));
                  }
                  _taskAddController.text =
                      (taskProvider.isNew) ? "" : "Task already added";
                },
                icon: Text("Add"),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Color.fromRGBO(66, 191, 245, 0.4),
                  ),
                ),
              ),
            ),
            onTap: () {
              _taskAddController.clear();
            },
            controller: _taskAddController,
            onChanged: (value) {
              taskText = value;
            },
          ),
          for (var task in taskProvider.tasks) task,
        ],
      ),
    );
  }
}

class CompletedTaskPage extends StatelessWidget {
  const CompletedTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TodoTaskProvider>(context);
    return Container(
      color: Color.fromRGBO(40, 60, 155, 0.4),
      child: ListView(
        padding: EdgeInsets.all(50),
        children: [
          Text(
            "Completed Tasks",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.greenAccent,
                  offset: Offset(2, 3),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
          Text(
            "    Completion ${(taskProvider.tasks.isEmpty) ? 0 : ((taskProvider.completedTasks.length / taskProvider.tasks.length) * 100).floor()} %",
            style: TextStyle(color: Colors.greenAccent, fontSize: 18),
          ),
          for (var task in taskProvider.completedTasks) task,
        ],
      ),
    );
  }
}

class TaskModel extends StatelessWidget {
  // int colorIndex;
  final String taskText;
  TaskModel(this.taskText, {super.key});
  // List<Color> backColor = [Color.fromRGBO(220, 230, 240, 0.7),
  //   Color.fromRGBO(170, 188, 242, 1)];
  bool taskDone = false;
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TodoTaskProvider>(context);
    return Card(
      margin: EdgeInsets.all(0),

      // color: (taskDone)? Color.fromRGBO(129, 245, 66, 1) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(
          color:
              (taskDone) ? Color.fromRGBO(129, 245, 66, 1) : Color(0x00ff0000),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: [
                (!taskDone)
                    ? IconButton(
                      onPressed: () {
                        taskDone = true;
                        taskProvider.addCompletedTask(this);
                      },
                      icon: Text(
                        "Done",
                        style: TextStyle(
                          color: Color.fromRGBO(129, 245, 66, 1),
                        ),
                      ),
                    )
                    : Text("", style: TextStyle(fontSize: 30)),

                Text(taskText, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          (!taskDone)
              ? IconButton(
                onPressed: () {
                  taskProvider.deleteTask(this);
                },
                icon: Text("Del"),
              )
              : Icon(
                Icons.done_outline,
                color: Color.fromRGBO(129, 245, 66, 1),
              ),
        ],
      ),
    );
  }
}

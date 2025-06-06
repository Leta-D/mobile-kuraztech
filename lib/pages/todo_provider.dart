import 'package:flutter/cupertino.dart';
import 'todo_home.dart';

class TodoProviderAuthen extends ChangeNotifier {
  final String _name = "";
  String _passwd = "";
  final bool _isPasswdVis = false;
  get isPasswdVis => _isPasswdVis;
  get name => _name;
  get passwd => _passwd;
  set name(userName) => _name;
  set passwd(passwd) => _passwd;
  set isPasswdVis(boolValue) => _isPasswdVis;
  void showPasswd() {
    isPasswdVis = !_isPasswdVis;
    notifyListeners();
  }

  void typePasswd(pass) {
    _passwd = pass;
    notifyListeners();
  }
}

class TodoTaskProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];
  List<TaskModel> completedTasks = [];
  bool _isNew = true;
  get isNew => _isNew;

  void checkDuplication(TaskModel nTask, List<TaskModel> taskList) {
    bool me = true;
    for (var pTask in taskList) {
      if (nTask.taskText == pTask.taskText) {
        me = false;
      }
      _isNew = me;
    }
    notifyListeners();
  }

  void addTask(TaskModel task) {
    checkDuplication(task, tasks);
    if (isNew) {
      tasks.add(task);
    }
    notifyListeners();
  }

  void addCompletedTask(TaskModel task) {
    checkDuplication(task, completedTasks);
    if (_isNew) {
      completedTasks.add(task);
    }
    notifyListeners();
  }

  void deleteTask(TaskModel task) {
    tasks.remove(task);
    _isNew = true;
    notifyListeners();
  }
}

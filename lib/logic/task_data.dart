import 'package:flutter/foundation.dart';


class Data extends ChangeNotifier {
  List<Task> tasks = [];

  void addTask(Task task){
    tasks.add(task);
    notifyListeners();
  }

  void deleteTask(int index){
    tasks.removeAt(index);
    notifyListeners();
  }


}


class Task {
  String name;
  bool isDone;

  Task({this.name, this.isDone});

  void toggleDone(){
    isDone = !isDone;
  }

}
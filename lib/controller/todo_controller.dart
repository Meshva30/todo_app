import 'package:get/get.dart';

class TodoController extends GetxController {
  var todayTasks = <String>[].obs;
  var taskCompleted = <bool>[].obs;

  void addTask(String task, {bool isCompleted = false}) {
    todayTasks.add(task);
    taskCompleted.add(isCompleted);
  }

  void taskCompletion(int index) {
    taskCompleted[index] = !taskCompleted[index];
    update();
  }


  void deleteTask(int index) {
    todayTasks.removeAt(index);
    taskCompleted.removeAt(index);
  }

  void updateTask(int index, String updatedTask) {
    todayTasks[index] = updatedTask;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controller/todo_controller.dart';
import '../utils/tasklist.dart';

class Homescreen extends StatelessWidget {
  Homescreen({Key? key}) : super(key: key);

  final TodoController todoController = Get.put(TodoController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3451A1),
      appBar: AppBar(
        backgroundColor: Color(0xff3451A1),
        leading: Icon(
          Icons.menu,
          size: 30,
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "What's up, Meshva!",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'CATEGORIES',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 150,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tasklist.length,
                itemBuilder: (context, index) {
                  var task = tasklist[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 130,
                      width: 220,
                      decoration: BoxDecoration(
                        color: Color(0xff051956),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              task['tasknumber'],
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              task['title'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            LinearProgressIndicator(
                              value: task['value'],
                              color: task['progresscolor'],
                              backgroundColor: Colors.grey.shade800,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              "TODAY'S TASKS",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            SizedBox(height: 25),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  controller: ScrollController(),
                  itemCount: todoController.todayTasks.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      key: ValueKey(todoController.todayTasks[index]),
                      endActionPane: ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          SlidableAction(
                            icon: Icons.delete,
                            backgroundColor: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                            padding: EdgeInsets.all(10),
                            spacing: 20,
                            onPressed: (BuildContext context) {
                              showDeleteConfirmation(context, index);
                            },
                          ),
                          SizedBox(width: 8,),
                          SlidableAction(
                            icon: Icons.update,
                            backgroundColor: Color(0xff051956),
                            borderRadius: BorderRadius.circular(15),
                            padding: EdgeInsets.all(10),
                            spacing: 20,
                            onPressed: (BuildContext context) {
                              showUpdateTaskDialog(context,index);
                            },
                          )
                        ],
                      ),
                      child: Container(
                        height: 71,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: Color(0xff051956),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Obx(
                              () => Checkbox(
                                shape: CircleBorder(),
                                activeColor: Color(0xff22358C),
                                value: todoController.taskCompleted[index],
                                onChanged: (value) {
                                  todoController.taskCompletion(index);
                                },
                              ),
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              todoController.todayTasks[index],
                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffE50BFF),
        shape: CircleBorder(),
        onPressed: () => showAddTaskDialog(context),
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  void showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                todoController.deleteTask(index);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void showAddTaskDialog(BuildContext context) {
    String newTask = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: TextField(
            onChanged: (value) {
              newTask = value;
            },
            decoration: InputDecoration(hintText: 'Enter task details'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newTask.isNotEmpty) {
                  todoController.addTask(newTask);
                }
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void showUpdateTaskDialog(BuildContext context, int index) {
    String updatedTask = todoController.todayTasks[index];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Task'),
          content: TextField(
            controller: TextEditingController(text: updatedTask),
            onChanged: (value) {
              updatedTask = value;
            },
            decoration: InputDecoration(hintText: 'Enter updated task details'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (updatedTask.isNotEmpty) {
                  todoController.updateTask(index, updatedTask);
                }
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

}

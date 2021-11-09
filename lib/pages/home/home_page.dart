import 'package:f_tasks/pages/new_task/new_task_page.dart';
import 'package:f_tasks/providers/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de tarefas',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<TasksProvider>(
        builder: (_, provider, __) {
          return SingleChildScrollView(
            child: Column(
              children: List.generate(
                  provider.tasks.length,
                  (index) => Card(
                        child: ListTile(
                          title: Text(provider.tasks[index].title),
                          trailing: Text(DateFormat.yMMMd().format(provider.tasks[index].date)),
                        ),
                      )),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewTaskPage()),
          );
        },
        tooltip: 'Nova tarefa',
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:f_tasks/constants.dart';
import 'package:f_tasks/models/task.dart';
import 'package:f_tasks/providers/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  String title = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nova tarefa',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    // icon: Icon(Icons.person),
                    labelText: 'Título',
                  ),
                  onChanged: (String value) {
                   setState(() {
                     title = value;
                   });
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          // icon: Icon(Icons.person),
                          labelText: 'Data',
                        ),
                        onChanged: (value) {
                          title = value;
                        },
                      ),
                    ),
                    ElevatedButton(onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2099));
                      if(pickedDate != null) {
                        print(pickedDate);
                      }
                    }, child: Text('Escolher'))
                  ],
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<TasksProvider>(context, listen: false)
                      .addTask(Task(title: title, date: DateTime.now()));
                  setState(() {
                    title = '';
                  });
                },
                child: const Text('Salvar'))
          ],
        ),
      ),
    );
  }
}

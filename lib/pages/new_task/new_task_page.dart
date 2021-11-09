import 'package:f_tasks/constants.dart';
import 'package:f_tasks/models/task.dart';
import 'package:f_tasks/providers/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({Key? key}) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  String title = '';
  DateTime date = DateTime.now();
  var titleFieldController = TextEditingController();
  var dateFieldController = TextEditingController();

  @override
  void initState() {
    dateFieldController.text = DateFormat.yMMMd().format(date).toString();
    super.initState();
  }

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
                  controller: titleFieldController,
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextField(
                        enabled: false,
                        controller: dateFieldController,
                        decoration: const InputDecoration(
                          labelText: 'Data',
                        ),
                      ),
                    ),
                    const SizedBox(width: kDefaultPadding,),
                    ElevatedButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2010),
                              lastDate: DateTime(2099));
                          if (pickedDate != null) {
                            setState(() {
                              date = pickedDate;
                              dateFieldController.text = DateFormat.yMMMd().format(pickedDate).toString();
                            });
                          }
                        },
                        child: const Text('Alterar'))
                  ],
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<TasksProvider>(context, listen: false)
                      .addTask(Task(title: title, date: date));
                  setState(() {
                    titleFieldController.text = '';
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

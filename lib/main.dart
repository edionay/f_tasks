import 'package:f_tasks/pages/home/home_page.dart';
import 'package:f_tasks/pages/new_task/new_task_page.dart';
import 'package:f_tasks/providers/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<TasksProvider>(
      create: (_) => TasksProvider(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    context.read<TasksProvider>().initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F Tasks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

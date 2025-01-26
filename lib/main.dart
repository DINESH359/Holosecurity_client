import 'package:flutter/material.dart';
import 'screens/create_task_page.dart';
import 'screens/get_task_page.dart';
import 'screens/get_all_tasks_page.dart';
import 'screens/update_task_page.dart';
import 'screens/delete_task_page.dart';
import 'screens/task_manager_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager App',
    theme: ThemeData(
  primarySwatch: Colors.teal,
  scaffoldBackgroundColor: Colors.teal[50],
  appBarTheme: AppBarTheme(
    color: Colors.teal,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    centerTitle: true,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(fontSize: 18, color: Colors.teal[800]),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.teal[700]), 
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.teal[900],
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal[400],
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(vertical: 16),
    ),
  ),
),

      initialRoute: '/',
      routes: {
        '/': (context) => TaskManagerHome(),
        '/create-task': (context) => CreateTaskPage(),
        '/get-one-task': (context) => GetOneTaskPage(),
        '/get-all-tasks': (context) => GetAllTasksPage(),
        '/update-task': (context) => UpdateTaskPage(),
        '/delete-task': (context) => DeleteTaskPage(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart'; 

class GetAllTasksPage extends StatefulWidget {
  @override
  _GetAllTasksPageState createState() => _GetAllTasksPageState();
}

class _GetAllTasksPageState extends State<GetAllTasksPage> {
 
  List<Map<String, dynamic>> tasks = [];
  bool isLoading = true;

  
  Future<void> fetchAllTasks() async {
    //final String apiUrl = 'http://localhost:3001/tasks';  
    final String apiUrl = '${AppConfig.baseUrl}/tasks';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> taskData = json.decode(response.body);
        setState(() {
          tasks = taskData.map((task) => {
            'title': task['title'],
            'description': task['description'],
            'completed': task['completed'],
          }).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load tasks')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAllTasks();  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Tasks'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())  
          : tasks.isEmpty
              ? Center(child: Text('No tasks available'))
              : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Card(
                      child: ListTile(
                        title: Text(task['title']),
                        subtitle: Text(task['description']),
                        trailing: Text(
                          task['completed'] ? 'Completed' : 'Not Completed',
                          style: TextStyle(
                            color: task['completed'] ? Colors.green : Colors.red,
                          ),
                        ),
                        onTap: () {
                         
                          Navigator.pushNamed(context, '/get-one-task');
                        },
                      ),
                    );
                  },
                ),
    );
  }
}

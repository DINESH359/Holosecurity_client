import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';

class UpdateTaskPage extends StatefulWidget {
  @override
  _UpdateTaskPageState createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  final TextEditingController taskIdController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ValueNotifier<bool> completed = ValueNotifier(false);

  bool isLoading = false; 
  bool isTaskFetched = false; 

  
  Future<void> fetchTaskDetails() async {
    final String taskId = taskIdController.text.trim();

    if (taskId.isEmpty) {
      showSnackBar('Please enter a Task ID.');
      return;
    }

    // final String apiUrl = 'http://localhost:3001/tasks/$taskId';
     final String apiUrl = '${AppConfig.baseUrl}/tasks/$taskId';
    setState(() {
      isLoading = true;
      isTaskFetched = false;
    });

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final task = json.decode(response.body);
        setState(() {
          titleController.text = task['title'] ?? '';
          descriptionController.text = task['description'] ?? '';
          completed.value = task['completed'] ?? false;
          isTaskFetched = true;
        });
      } else {
        showSnackBar('Task not found. Please try a different ID.');
      }
    } catch (e) {
      showSnackBar('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

 
  Future<void> updateTask() async {
    final String taskId = taskIdController.text.trim();
   // final String apiUrl = 'http://localhost:3001/tasks/$taskId';
    final String apiUrl = '${AppConfig.baseUrl}/tasks/$taskId';

    final Map<String, dynamic> updatedTask = {
      "title": titleController.text,
      "description": descriptionController.text,
      "completed": completed.value,
    };

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updatedTask),
      );

      if (response.statusCode == 200) {
        showSnackBar('Task updated successfully.');
        Navigator.pop(context); 
      } else {
        showSnackBar('Failed to update task.');
      }
    } catch (e) {
      showSnackBar('Error: $e');
    }
  }

  
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Task ID to Fetch Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskIdController,
                    decoration: InputDecoration(
                      labelText: 'Task ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: fetchTaskDetails,
                  child: isLoading ? CircularProgressIndicator() : Text('Fetch Task'),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (isTaskFetched) ...[
              Text(
                'Task Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('Completed:'),
                  SizedBox(width: 8),
                  ValueListenableBuilder<bool>(
                    valueListenable: completed,
                    builder: (context, value, child) {
                      return Switch(
                        value: value,
                        onChanged: (newValue) {
                          completed.value = newValue;
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateTask,
                child: Text('Update Task'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config.dart'; 

class DeleteTaskPage extends StatefulWidget {
  @override
  _DeleteTaskPageState createState() => _DeleteTaskPageState();
}

class _DeleteTaskPageState extends State<DeleteTaskPage> {
  final TextEditingController taskIdController = TextEditingController();
  bool isLoading = false; 

  // Delete task logic
  Future<void> deleteTask() async {
    final String taskId = taskIdController.text.trim();

    if (taskId.isEmpty) {
      showSnackBar('Please enter a Task ID.');
      return;
    }
    final String apiUrl = '${AppConfig.baseUrl}/tasks/$taskId';
    //final String apiUrl = 'http://localhost:3001/tasks/$taskId';

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        showSnackBar('Task deleted successfully.');
        Navigator.pop(context); 
      } else if (response.statusCode == 404) {
        showSnackBar('Task not found. Please try a different ID.');
      } else {
        showSnackBar('Failed to delete the task. Please try again.');
      }
    } catch (e) {
      showSnackBar('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

 
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delete Task',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: taskIdController,
              decoration: InputDecoration(
                labelText: 'Enter Task ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : deleteTask,
              child: isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text('Delete Task'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

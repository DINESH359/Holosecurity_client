import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart'; 

class GetOneTaskPage extends StatefulWidget {
  @override
  _GetOneTaskPageState createState() => _GetOneTaskPageState();
}

class _GetOneTaskPageState extends State<GetOneTaskPage> {
  final TextEditingController taskIdController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ValueNotifier<bool> completed = ValueNotifier(false);

  
  Future<void> fetchTaskDetails(int taskId) async {
        final String apiUrl = '${AppConfig.baseUrl}/tasks/$taskId';

    //final String apiUrl = 'http://localhost:3001/tasks/$taskId';

    try {
     
      final response = await http.get(Uri.parse(apiUrl));

      
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> taskData = json.decode(response.body);
        
        setState(() {
          titleController.text = taskData['title'] ?? '';
          descriptionController.text = taskData['description'] ?? '';
          completed.value = taskData['completed'] ?? false;
        });
      } else {
       
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Task not found. Please try again later.')),
        );
      }
    } catch (e) {
     
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Task ID to Fetch Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: taskIdController,
              decoration: InputDecoration(
                labelText: 'Task ID',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
               
                final taskId = int.tryParse(taskIdController.text);
                if (taskId != null) {
                  fetchTaskDetails(taskId); 
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid Task ID')),
                  );
                }
              },
              child: Text('Fetch Task'),
            ),
            SizedBox(height: 40),
            Text(
              'Task Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              enabled: false, 
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              enabled: false, 
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
                      onChanged: (newValue) {}, 
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

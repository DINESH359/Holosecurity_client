import 'package:flutter/material.dart';
import '../widgets/task_button.dart';

class TaskManagerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              Icon(
                Icons.task_alt, 
                size: 100, 
                color: Colors.teal[400], 
              ),
              SizedBox(height: 20), 
             
              Text(
                'Task Manager Actions',
                style: Theme.of(context).textTheme.titleLarge, 
              ),
              SizedBox(height: 20), 
              TaskButton(
                title: 'Create Task',
                onPressed: () {
                  Navigator.pushNamed(context, '/create-task');
                },
              ),
              SizedBox(height: 10),
              TaskButton(
                title: 'Get One Task',
                onPressed: () {
                  Navigator.pushNamed(context, '/get-one-task');
                },
              ),
              SizedBox(height: 10),
              TaskButton(
                title: 'Get All Tasks',
                onPressed: () {
                  Navigator.pushNamed(context, '/get-all-tasks');
                },
              ),
              SizedBox(height: 10),
              TaskButton(
                title: 'Update Task',
                onPressed: () {
                  Navigator.pushNamed(context, '/update-task');
                },
              ),
              SizedBox(height: 10),
              TaskButton(
                title: 'Delete Task',
                onPressed: () {
                  Navigator.pushNamed(context, '/delete-task');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

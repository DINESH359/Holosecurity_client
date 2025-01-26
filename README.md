# Task Manager App

## Overview

The **Task Manager App** is a Flutter-based application that allows users to perform CRUD (Create, Read, Update, Delete) operations on tasks. The app provides a user-friendly interface with navigation to different screens for managing tasks.

## Features

- **Create Task**: Add a new task with relevant details.
- **Get One Task**: Fetch details of a specific task.
- **Get All Tasks**: Retrieve a list of all tasks.
- **Update Task**: Edit the details of an existing task.
- **Delete Task**: Remove a task from the system.
- **Themed Interface**: Customizable and visually appealing UI with consistent themes.

## Getting Started

### Prerequisites

To run this application, ensure you have the following installed:

- **Flutter SDK**: [Get Flutter](https://flutter.dev/docs/get-started/install)
- **Code Editor**: A code editor like [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)

### Installation

1. Clone this repository:

   ```bash
   git clone <repository-url>
2. Navigate to the project directory:

    cd task-manager-app
3. Install dependencies:
    
    flutter pub get
4. Running the App
    
    flutter run

Project Structure

lib/
├── main.dart                 # Entry point of the application
├── config.dart               # Configuration file for storing base URL and other constants
├── screens/                  # Contains all screen files
│   ├── create_task_page.dart
│   ├── get_task_page.dart
│   ├── get_all_tasks_page.dart
│   ├── update_task_page.dart
│   ├── delete_task_page.dart
│   └── task_manager_home.dart
├── widgets/                  # Contains reusable widgets
│   └── task_button.dart
Configuration
All configurable parameters, such as the base URL, are stored in the config.dart file. Update the baseUrl constant as needed:


class AppConfig {
  static const String baseUrl = 'https://your-api-base-url.com';
}
Dependencies
This project uses the following dependencies:

flutter: Flutter framework
Additional dependencies can be listed in the pubspec.yaml file.

Screens
Home Screen
The Home Screen displays options to navigate to different task actions. It includes a logo and buttons for navigation.

Task Screens
Create Task: Screen to create a new task.
Get Task: Screen to fetch a specific task by ID.
Get All Tasks: Screen to view all tasks.
Update Task: Screen to edit an existing task.
Delete Task: Screen to remove a task from the system.
How to Customize
Change Theme
To change the theme, modify the ThemeData in main.dart to apply a custom theme to the app.

Add New Features
Create new screens under the screens/ directory.
Use reusable widgets from widgets/ to maintain consistency across the app.
Contribution
Feel free to contribute to this project by submitting issues or pull requests.


# Flutter To-Do List App

A feature-rich To-Do List application built with Flutter, featuring elegant UI design, dark/light themes, and local notifications.

<p float="left">
  <img src="https://i.imgur.com/auVPsVe.png" width="250" />
  <img src="https://i.imgur.com/tKwMi25.png" width="250" />
  <img src="https://i.imgur.com/kUg6FaE.png" width="250" />
</p>

## ✨ Key Features

- 📝 Complete task management (Create, Read, Update, Delete)
- 🌓 Dynamic theme switching (Dark/Light mode)
- 🔔 Smart local notifications
- 📅 Date & time scheduling
- 💾 Persistent storage with SQLite
- ✅ Task completion tracking
- 🎨 Material Design UI with smooth animations
- 📱 Responsive layout for all screen sizes

## 📱 Screenshots

<p float="left">
  <img src="https://i.imgur.com/jsy2hQT.png" width="200" />
  <img src="https://i.imgur.com/8K7dbvp.png" width="200" /> 
  <img src="https://i.imgur.com/SZu51ng.png" width="200" />
  <img src="https://i.imgur.com/5N4dBp9.png" width="200" />
</p>

<p float="left">
  <img src="https://i.imgur.com/cafERSi.png" width="200" />
  <img src="https://i.imgur.com/sbaEZEK.png" width="200" />
</p>

## 🛠️ Technical Stack

- **Framework**: Flutter
- **State Management**: Provider
- **Database**: SQLite
- **Local Notifications**: flutter_local_notifications
- **Preferences**: shared_preferences
- **UI Design**: Material Design 3
- **Font**: Google Fonts (Roboto)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation Steps

1. Clone the repository:

```bash
git clone https://github.com/ellfarnaz/TodoList-Flutter.git
```

2. Navigate to project directory:

```bash
cd todo_list_app
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

## 📁 Project Architecture

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   └── task.dart            # Task model
├── providers/               # State management
│   ├── task_provider.dart   # Task state management
│   └── theme_provider.dart  # Theme state management
├── screens/                 # App screens
│   ├── home_screen.dart     # Main screen
│   ├── add_task_screen.dart # Add task screen
│   └── edit_task_screen.dart# Edit task screen
├── services/                # Core services
│   ├── database_helper.dart # SQLite database service
│   └── notification_service.dart # Local notifications
├── utils/                   # Utilities
│   ├── color_palette.dart   # Color definitions
│   ├── theme_data.dart      # Theme configurations
│   └── date_time_helper.dart# Date formatting
└── widgets/                 # Reusable widgets
    └── task_item.dart       # Task list item widget
```

## 🎯 Roadmap

- [ ] Task categories and tags
- [ ] Cloud synchronization
- [ ] Home screen widgets
- [ ] Data backup/restore
- [ ] Task statistics and insights
- [ ] Multiple reminder times
- [ ] Recurring tasks
- [ ] Task sharing
- [ ] Custom themes

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Farel Naufal Azhari**

- GitHub: [@ellfarnaz](https://github.com/ellfarnaz)
- LinkedIn: [Farel Naufal Azhari](https://linkedin.com/in/farel-naufal)

## 🙏 Acknowledgments

- Thanks to the Flutter team for the amazing framework
- Material Design for the beautiful UI guidelines
- The Flutter community for inspiration and support

## ⭐ Show your support

Give a ⭐️ if this project helped you!

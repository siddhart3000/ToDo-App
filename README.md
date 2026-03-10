# 🚀 Premium ToDo App

A robust, high-end productivity application built with **Flutter**, **Riverpod**, and **Firebase**. This app features a "Premium SaaS" aesthetic with a full suite of task management tools, including smart notifications and real-time data sync.

---

## ✨ Key Features

### 🔐 1. Advanced Authentication
- **Firebase Auth**: Secure sign-up/login with email and password.
- **Persistent Sessions**: Stay logged in even after closing the app.
- **Personalized Onboarding**: Animated splash screen (2s) for a professional entry.

### 📋 2. Comprehensive Task Management
- **Full CRUD**: Add, View, Edit, and Delete tasks effortlessly.
- **Categorization**: Organize tasks into 8+ categories (Design, Meeting, Work, Learning, etc.).
- **Smart Filtering**: The "Today's Task" dashboard automatically filters for the current day.
- **Search Real-time**: Find any task instantly with the integrated search bar.
- **Overdue Awareness**: Unfinished tasks from previous days remain visible until addressed.

### 🔔 3. Smart Notifications & Alarms
- **On-Demand Permissions**: Requests notification access only when needed (e.g., enabling a reminder).
- **Proactive Scheduling**:
  - **Standard**: Reminder 10 minutes before the task.
  - **Big Events**: Automatic 1-day advance reminder for "Work" or high-priority tasks.
- **Interactive Alarms**: Support for high-priority notifications that capture user attention.

### 📊 4. Analytics & Progress
- **Visual Insights**: A dedicated analytics dashboard featuring:
  - Completion rates per category.
  - **Weekly Activity Chart**: High-performance line graph using `fl_chart`.
  - "You are on Track" status card.

### 🎨 5. Premium UI/UX
- **Dynamic Theming**: Eye-pleasing **Dark Mode** support across all screens.
- **Color Grading**: Custom indigo-purple gradients and category-specific palettes.
- **Freedom Profile**: Editable profile with name, phone, address, and **Photo Upload** (integrated with Firebase Storage).

---

## 🛠️ Technical Stack

- **Framework**: [Flutter](https://flutter.dev/) (Material 3)
- **State Management**: [Riverpod](https://riverpod.dev/)
- **Backend**: [Firebase](https://firebase.google.com/) (Authentication, Realtime Database via REST API, Storage)
- **Local Services**:
  - `flutter_local_notifications` for scheduling reminders.
  - `image_picker` for profile customization.
  - `permission_handler` for privacy-first permission management.

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (v3.10+)
- A Firebase Project

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/todo_firebase_app.git
    cd todo_firebase_app
    ```

2.  **Configure Firebase**:
    - Add your `google-services.json` to `android/app/`.
    - Add your `GoogleService-Info.plist` to `ios/Runner/`.
    - Update the `_baseUrl` in `lib/services/task_service.dart` with your Realtime Database URL.

3.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

4.  **Add App Logo**:
    - Place your logo in `assets/logo.jpg`.
    - Generate icons:
      ```bash
      flutter pub run flutter_launcher_icons:main
      ```

5.  **Run the app**:
    ```bash
    flutter run
    ```

---

## 🛡️ Privacy & Security
This project uses `.gitignore` to exclude sensitive Firebase configuration files. Ensure you provide your own configuration when setting up the project locally.

---

## 🤝 Contributing
Contributions, issues, and feature requests are welcome! Feel free to check [issues page](https://github.com/your-username/todo_firebase_app/issues).

## ⭐️ Show your support
Give a ⭐️ if this project helped you!


🚀 ToDo App
A modern productivity and task management mobile application built using Flutter and Firebase.
This application helps users organize daily tasks, track productivity, and receive smart reminders through a clean, premium UI experience inspired by modern SaaS dashboards.
The app demonstrates clean architecture, real-time data synchronization, smart notifications, and analytics visualization.
________________________________________
📱 APK Download
Download the latest version:
Releases → ToDo-App-v1.0.apk
Or visit:
https://github.com/siddhart3000/ToDo-App/releases
________________________________________
✨ Features
🔐 Authentication
•	Firebase Email & Password authentication
•	Secure login and signup flow
•	Persistent user sessions
📝 Task Management
•	Create new tasks
•	Edit existing tasks
•	Delete tasks
•	Mark tasks as TODO / DONE
•	Real-time synchronization with Firebase
📂 Task Categories
Organize tasks across multiple categories:
•	Work
•	Design
•	Meetings
•	Learning
•	Personal
•	Health
•	Shopping
•	Others
🔎 Smart Search
•	Instant task search
•	Dynamic filtering
•	Quickly locate tasks from large lists
🔔 Smart Notifications
•	Reminder notifications before due time
•	Alarm-style high priority alerts
•	Permission requested only when required
📊 Productivity Analytics
Visual insights into user activity:
•	Weekly productivity charts
•	Task completion statistics
•	Category performance tracking
Charts powered by fl_chart.
🌙 Dark Mode
•	Fully supported dark theme
•	Smooth UI transitions
•	Material 3 design system
👤 Profile Management
Users can update:
•	Name
•	Profile photo
•	Phone number
•	Address
Images stored securely using Firebase Storage.
________________________________________
🧱 Architecture
The project follows a clean modular architecture for scalability.
lib
 ├ core
 │ ├ constants
 │ ├ theme
 │ └ utils
 │
 ├ models
 │ ├ task_model.dart
 │ └ user_model.dart
 │
 ├ providers
 │ ├ auth_provider.dart
 │ └ task_provider.dart
 │
 ├ services
 │ ├ firebase_service.dart
 │ ├ auth_service.dart
 │ └ task_service.dart
 │
 ├ screens
 │ ├ auth
 │ ├ home
 │ ├ analytics
 │ ├ profile
 │ └ add_task
 │
 └ widgets
   ├ task_card.dart
   ├ category_card.dart
   └ custom_components.dart
State management is handled with Riverpod.
________________________________________
🛠 Tech Stack
Framework
•	Flutter (Material 3)
State Management
•	Riverpod
Backend
•	Firebase Authentication
•	Firebase Realtime Database
•	Firebase Storage
Packages
•	flutter_riverpod
•	flutter_local_notifications
•	fl_chart
•	google_fonts
•	permission_handler
•	image_picker
________________________________________
⚙️ Setup Instructions
1️⃣ Clone the repository
git clone https://github.com/siddhart3000/ToDo-App.git
cd ToDo-App
2️⃣ Install dependencies
flutter pub get
3️⃣ Configure Firebase
Add your Firebase configuration files:
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
Update the database URL inside:
lib/services/task_service.dart
________________________________________
4️⃣ Generate launcher icons
dart run flutter_launcher_icons
________________________________________
5️⃣ Run the application
flutter run
________________________________________
🔐 Security
Sensitive Firebase configuration files are excluded using .gitignore.
Developers cloning the project must add their own Firebase configuration.
________________________________________
📸 Screenshots
Add screenshots here for better presentation.
Example:
screenshots/login.png
screenshots/dashboard.png
screenshots/tasks.png
screenshots/analytics.png
screenshots/darkmode.png
________________________________________
🤝 Contributing
Contributions, issues, and feature requests are welcome.
If you'd like to improve the project:
1.	Fork the repository
2.	Create a feature branch
3.	Submit a pull request
________________________________________
⭐ Support
If you found this project useful, consider giving it a ⭐ on GitHub.
________________________________________
👨‍💻 Author
Siddharth Singh
GitHub
https://github.com/siddhart3000


# 🚀 ToDo App

[![Flutter](https://img.shields.io/badge/Flutter-v3.19-blue?logo=flutter)](https://flutter.dev)  
[![Firebase](https://img.shields.io/badge/Firebase-Backend-yellow?logo=firebase)](https://firebase.google.com)  
`[Looks like the result wasn't safe to show. Let's switch things up and try something else!]`  
Stars [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fsiddhart3000%2FToDo-App%2Fstargazers")

A modern productivity and task management mobile application built using **Flutter** and **Firebase**.  
This app helps users organize daily tasks, track productivity, and receive smart reminders through a clean, premium UI inspired by modern SaaS dashboards.

---

## 📱 APK Download

👉 Download Latest APK [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fsiddhart3000%2FToDo-App%2Freleases%2Fdownload%2Fv1.0%2FToDo-App-v1.0.apk")

---

## 🎥 Demo

`[Looks like the result wasn't safe to show. Let's switch things up and try something else!]`

---

## ✨ Features

- 🔐 **Authentication**: Secure Firebase Email & Password login  
- 📝 **Task Management**: Create, edit, delete, mark tasks as TODO/DONE  
- 📂 **Categories**: Work, Design, Meetings, Learning, Personal, Health, Shopping, Others  
- 🔎 **Smart Search**: Instant search & dynamic filtering  
- 🔔 **Notifications**: Smart reminders & alerts  
- 📊 **Analytics**: Weekly charts, completion stats, category performance  
- 🌙 **Dark Mode**: Material 3 design with smooth transitions  
- 👤 **Profile Management**: Update name, photo, phone, address  

---

## 🧱 Architecture

```plaintext
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
```

State management: **Riverpod**

---

## 🛠 Tech Stack

- **Framework**: Flutter (Material 3)  
- **State Management**: Riverpod  
- **Backend**: Firebase Authentication, Realtime Database, Storage  
- **Packages**: `flutter_riverpod`, `flutter_local_notifications`, `fl_chart`, `google_fonts`, `permission_handler`, `image_picker`

---

## ⚙️ Setup Instructions

1️⃣ Clone the repository  
```bash
git clone https://github.com/siddhart3000/ToDo-App.git
cd ToDo-App
```

2️⃣ Install dependencies  
```bash
flutter pub get
```

3️⃣ Configure Firebase  
- Add `android/app/google-services.json`  
- Add `ios/Runner/GoogleService-Info.plist`  
- Update database URL in `lib/services/task_service.dart`

4️⃣ Generate launcher icons  
```bash
dart run flutter_launcher_icons
```

5️⃣ Run the application  
```bash
flutter run
```

---

## 📸 Screenshots

| Login | Dashboard | Tasks | Analytics | Dark Mode |
|-------|-----------|-------|-----------|-----------|
| `[Looks like the result wasn't safe to show. Let's switch things up and try something else!]` | `[Looks like the result wasn't safe to show. Let's switch things up and try something else!]` | `[Looks like the result wasn't safe to show. Let's switch things up and try something else!]` | `[Looks like the result wasn't safe to show. Let's switch things up and try something else!]` | `[Looks like the result wasn't safe to show. Let's switch things up and try something else!]` |

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!  
1. Fork the repository  
2. Create a feature branch  
3. Submit a pull request  

---

## ⭐ Support

If you found this project useful, please give it a ⭐ on GitHub!

---

## 👨‍💻 Author

**Siddharth Singh**  
GitHub: [siddhart3000](https://github.com/siddhart3000)



Would you like me to also design a **visual architecture diagram** (boxes/arrows showing flow between Flutter, Riverpod, Firebase Auth, DB, Storage) so your README stands out even more?

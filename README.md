<div align="center">

<!-- Logo matching app's purple splash screen -->
<svg width="88" height="88" viewBox="0 0 88 88" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="grad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#6C63C9"/>
      <stop offset="100%" stop-color="#B39DDB"/>
    </linearGradient>
  </defs>
  <circle cx="44" cy="44" r="44" fill="url(#grad)"/>
  <circle cx="44" cy="44" r="26" fill="white"/>
  <circle cx="44" cy="44" r="20" fill="none" stroke="#6C63C9" stroke-width="2.8"/>
  <polyline points="33,44 41,52 56,36" fill="none" stroke="#6C63C9" stroke-width="3.2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>

<br/><br/>

# ToDo App

**Manage your tasks beautifully.**

A production-grade task management app built with **Flutter** & **Firebase** —  
featuring clean architecture, real-time sync, smart notifications, and an analytics dashboard.

<br/>

![Flutter](https://img.shields.io/badge/Flutter-3.19-6C63C9?style=for-the-badge&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-Backend-9575CD?style=for-the-badge&logo=firebase&logoColor=white)
![Riverpod](https://img.shields.io/badge/Riverpod-State_Mgmt-B39DDB?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-7E57C2?style=for-the-badge)

<br/>

[![Download APK](https://img.shields.io/badge/⬇️%20Download%20APK%20v1.0-6C63C9?style=for-the-badge&logo=android&logoColor=white)](https://github.com/siddhart3000/ToDo-App/releases/tag/v1.0)
&nbsp;&nbsp;
[![Star on GitHub](https://img.shields.io/badge/⭐%20Star%20on%20GitHub-1a1a2e?style=for-the-badge&logo=github)](https://github.com/siddhart3000/ToDo-App)

</div>

---

## 📸 Screenshots

| Splash | Login | Dashboard | Tasks | Analytics | Dark Mode |
|:------:|:-----:|:---------:|:-----:|:---------:|:---------:|
| ![Splash](screenshots/Splash.jpeg) | ![Login](screenshots/Login.jpeg) | ![Dashboard](screenshots/Dashboard.jpeg) | ![Tasks](screenshots/Task.jpeg) | ![Analytics](screenshots/Analytics.jpeg) | ![Dark](screenshots/Profile(Dark%20Theme).jpeg) |

---

## ✨ Features

```
 ☑  Authentication     →  Firebase Email & Password login with session persistence
 ☑  Task Management    →  Create, edit, delete · Toggle between TODO and DONE
 ☑  Categories         →  Work · Design · Meetings · Learning · Personal · Health · Shopping · Others
 ☑  Smart Search       →  Instant search with real-time dynamic filtering
 ☑  Notifications      →  Local reminders and smart due-date alerts
 ☑  Analytics          →  Weekly charts · Completion rates · Category performance
 ☑  Dark Mode          →  Material 3 design with smooth light/dark transitions
 ☑  Profile            →  Update name · photo · phone · address
```

---

## 🏗️ Architecture

A **layered clean architecture** that keeps UI, business logic, and data concerns fully separated.

```
lib/
│
├── core/
│   ├── constants/              # App-wide constants & enums
│   ├── theme/                  # Material 3 purple light & dark themes
│   └── utils/                  # Helpers, extensions, validators
│
├── models/
│   ├── task_model.dart         # Task entity with category, priority, status
│   └── user_model.dart         # User profile model
│
├── providers/                  # Riverpod state providers
│   ├── auth_provider.dart
│   └── task_provider.dart
│
├── services/                   # Business logic & Firebase bridges
│   ├── firebase_service.dart
│   ├── auth_service.dart
│   └── task_service.dart
│
├── screens/
│   ├── auth/                   # Login & registration
│   ├── home/                   # Dashboard & task list
│   ├── analytics/              # Charts & insights
│   ├── profile/                # User settings
│   └── add_task/               # Create / edit task form
│
└── widgets/
    ├── task_card.dart          # Individual task tile
    ├── category_card.dart      # Category chip / card
    └── custom_components.dart  # Shared UI components
```

**Data flow:** `Screens / Widgets` → `Riverpod Providers` → `Services` → `Firebase (Auth · Realtime DB · Storage)`

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **Framework** | Flutter 3.19 — Material 3 |
| **State Management** | Riverpod (`flutter_riverpod`) |
| **Authentication** | Firebase Authentication |
| **Database** | Firebase Realtime Database |
| **Storage** | Firebase Cloud Storage |
| **Charts** | `fl_chart` |
| **Notifications** | `flutter_local_notifications` |
| **Fonts** | `google_fonts` |
| **Media** | `image_picker` · `permission_handler` |

---

## ⚙️ Getting Started

### Prerequisites

- Flutter SDK ≥ 3.0.0 · Dart SDK ≥ 3.0.0
- A Firebase project with **Authentication**, **Realtime Database**, and **Storage** enabled

---

### Step 1 — Clone the repo

```bash
git clone https://github.com/siddhart3000/ToDo-App.git
cd ToDo-App
```

### Step 2 — Install dependencies

```bash
flutter pub get
```

### Step 3 — Connect Firebase

Place your config files in the correct locations:

```
android/app/google-services.json          ← Android
ios/Runner/GoogleService-Info.plist       ← iOS
```

Then set your Realtime Database URL in `lib/services/task_service.dart`:

```dart
// Replace with your own project URL
const String databaseUrl =
    'https://your-project-id-default-rtdb.firebaseio.com';
```

### Step 4 — Generate launcher icons *(optional)*

```bash
dart run flutter_launcher_icons
```

### Step 5 — Run

```bash
flutter run
```

---

## 🤝 Contributing

All contributions are welcome — bug fixes, new features, UI polish, or documentation.

```bash
# 1. Fork & clone
git clone https://github.com/your-username/ToDo-App.git

# 2. Create a feature branch
git checkout -b feature/amazing-feature

# 3. Commit using Conventional Commits
git commit -m "feat: add amazing feature"

# 4. Push and open a Pull Request
git push origin feature/amazing-feature
```

Please ensure `flutter analyze` passes with no errors before submitting.

---

## 📄 License

Distributed under the **MIT License** — see [`LICENSE`](LICENSE) for details.

---

<div align="center">

<br/>

*Built with 💜 by **[Siddharth Singh](https://github.com/siddhart3000)***

*Found it useful? Drop a ⭐ — it keeps the momentum going!*

</div>


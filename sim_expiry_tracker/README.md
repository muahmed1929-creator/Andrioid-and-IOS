# SIM Expiry Tracker

A startup-quality mobile application built with Flutter for managing SIM cards and account packages with smart expiry tracking and automated notifications.

## 🚀 Features

- **Account Management**: Full CRUD for SIM accounts.
- **Smart Tracking**: Auto-calculation of expiry dates for Weekly, Monthly, and Custom plans.
- **Visual Status**: Color-coded indicators for expiry status (Safe, Warning, Expired).
- **Offline First**: Works fully offline with local Isar database.
- **Cloud Sync**: Automatic sync with Firebase Firestore.
- **Smart Notifications**: Reminders 1 day before and on the day of expiry.
- **Premium UI**: Modern design with dark mode support and smooth animations.

## 🛠 Tech Stack

- **Frontend**: Flutter
- **State Management**: Riverpod
- **Local Storage**: Isar
- **Backend**: Firebase (Auth, Firestore, FCM)
- **Navigation**: GoRouter
- **Styling**: FlexColorScheme, Google Fonts (Outfit)

## 📦 Getting Started

1.  **Clone the repository**:
    ```bash
    git clone <repo-url>
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Run Code Generation**:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

4.  **Firebase Setup**:
    - Follow the instructions in [FIREBASE_SETUP.md](FIREBASE_SETUP.md) to add your config files.

5.  **Run the app**:
    ```bash
    flutter run
    ```

## 📂 Project Structure

```text
lib/
├── core/            # App-wide configurations (Theme, Router, DB)
├── shared/          # Reusable widgets and utilities
└── features/        # Feature-based modules
    ├── auth/        # Authentication logic and UI
    ├── dashboard/   # Main summary and list view
    ├── accounts/    # CRUD and tracking logic
    ├── notifications/# Local and push reminders
    ├── settings/    # App settings and theme toggles
    └── sync/        # Offline-first sync logic
```

## 🔗 Useful Links

- [PC Bottleneck Check](https://pcbottleneckckeck.com/)

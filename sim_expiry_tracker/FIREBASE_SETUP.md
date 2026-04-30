# Firebase Setup Instructions

To enable Cloud Sync, Notifications, and Authentication, follow these steps:

## 1. Create a Firebase Project
1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Click **Add project** and follow the prompts.

## 2. Add Android App
1. Register the app with package name `com.example.sim_expiry_tracker`.
2. Download `google-services.json`.
3. Place it in `android/app/`.

## 3. Add iOS App
1. Register the app with bundle ID `com.example.simExpiryTracker`.
2. Download `GoogleService-Info.plist`.
3. Add it to the Xcode project under `Runner`.

## 4. Enable Services
1. **Authentication**: Enable Email/Password and Google sign-in.
2. **Firestore**: Create a database in "Production mode" and set rules.
3. **Cloud Messaging**: Enable for push notifications.

## 5. Deployment
- Use `firebase deploy` for security rules if using CLI.

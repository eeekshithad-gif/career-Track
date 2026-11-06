# Job Application Tracker

A student-focused Flutter app to track job and internship applications.

## Features
- Dashboard/list of saved opportunities
- Opportunity detail view
- Add an opportunity with form validation
- Track application status: Interested, Applied, Interview, Offered, Rejected
- Search and filter opportunities
- Provider state management
- SharedPreferences local persistence

## Demo data
The initial opportunities are fictional sample records. This app does not connect to a live job board and does not submit applications to employers. Verify every opportunity independently before applying.

## Requirements
Flutter stable, Dart null safety, Android Studio with Flutter/Dart plugins, JDK 17 and Android SDK.

## Run
```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## Build
```bash
flutter build apk --release
```
APK: `build/app/outputs/flutter-apk/app-release.apk`

## Screens
1. Opportunities
2. Opportunity Details
3. Add Opportunity
4. Application Tracker

## Architecture
- `models/`: opportunity model
- `services/`: local storage
- `providers/`: ChangeNotifier state
- `screens/`: app screens
- `widgets/`: reusable opportunity card

## Team responsibilities
Add each member's name and their screen/feature ownership. Every member should make genuine commits and explain their work.

## Testing and defect log
Test on a physical Android device, including empty data, long text, repeated taps, rotation and offline use. Record defects below.

| Defect | Status | Notes |
|---|---|---|
| Add issues found during testing | Open | Update after testing |

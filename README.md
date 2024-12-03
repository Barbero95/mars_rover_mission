# Flutter Template

## Permissions

### iOS

- On Podfile, uncomment permission, in case does not exist, add a new entry. Example:
  - 'PERMISSION_CAMERA=1',
- Edit Info.plist to add new entries. Example:
  `<key>`NSCameraUsageDescription `</key>`
  `<string>`Allow access to camera `</string>`

### Android

- Edit AndroidManifest.xml and add any permission. Example:
  `<uses-permission android:name="android.permission.CAMERA"/>`

## Multi language

### Configuration

- Substitute INSERT_LOCO_KEY to Loco API key from Loco's console on loco.sh file
- Look for the comment on pubspec.yalm: `TUTORIAL: - CHANGE_DEFAULT_LANGUAGE`

### Update Strings

`sh loco.sh`

### Intl

- This package provides internationalization and localization facilities, including message translation, plurals and genders, date/number formatting and parsing, and bidirectional text.
  [Documentation](https://pub.dev/packages/intl#-readme-tab-)

## Commands

### Android version

- dev

 `flutter build apk --flavor dev -t lib/main_dev.dart`

* prod

 `flutter build apk --flavor prod -t lib/main.dart`

### iOS version

- dev

 `flutter build ipa --flavor dev -t lib/main_dev.dart`

* prod

 `flutter build ipa --flavor prod -t lib/main.dart`

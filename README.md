# TaskFlow - Beautiful Task Management App 🎯

A modern, elegant task management application built with Flutter using Clean Architecture and Cubit state management, featuring real-time weather integration and multi-language support.

## ✨ Features

### Task Management
- ✅ Add new tasks with title, description, deadline, and optional tags
- ✏️ Edit existing tasks with smooth animations
- 🗑️ Delete tasks with confirmation dialog
- ✔️ Mark tasks as completed with animated checkmarks
- 🔍 Search and filter tasks by tag or status
- 📊 Visual progress indicator showing completion percentage
- 💾 Persistent storage with automatic save

### Weather Integration
- 🌤️ Real-time weather information using OpenWeatherMap API
- 📍 Automatic location detection
- 🔍 Search weather by city name
- 🎨 Dynamic gradient backgrounds based on weather conditions
- 🔄 Pull to refresh weather data
- ✨ Beautiful glassmorphism weather card with enhanced visual effects

### UI/UX Design
- 🎨 Modern, elegant interface with soft shadows and gradient backgrounds
- 🌈 Beautiful color palette with primary and secondary colors
- 🌙 Dark mode support with smooth transitions
- 📱 Fully responsive design for mobile, tablet, and web
- 💫 Smooth animations and micro-interactions throughout
- 🎭 Hover effects and visual feedback for better UX
- 🔔 Enhanced SnackBar notifications with icons

### Internationalization (i18n)
- 🌍 Multi-language support (English & Arabic)
- 🔄 Easy language switching with one tap
- 📝 60+ translated strings
- 🎯 RTL support for Arabic

### Responsive Layout
- 📱 Mobile: Single-column layout with drawer navigation
- 💻 Desktop/Web: Two-column layout with persistent sidebar
- 🎯 Adaptive FAB (standard on mobile, extended on desktop)
- 📐 Proper scaling across all screen sizes

## 🏗️ Architecture

This project follows **Clean Architecture** principles with three main layers:

### Domain Layer
- **Entities**: Pure business objects (Task, Weather)
- **Repository Interfaces**: Abstract contracts
- **Use Cases**: Business logic operations

### Data Layer
- **Models**: Data transfer objects with JSON serialization
- **Data Sources**: Local (SharedPreferences, Drift) and Remote (HTTP)
- **Repository Implementations**: Concrete implementations with error handling

### Presentation Layer
- **Cubits**: State management using flutter_bloc
- **Pages**: Screen-level widgets
- **Widgets**: Reusable UI components

## 📦 Dependencies

### Core Flutter
- `flutter: sdk: flutter`
- `cupertino_icons: ^1.0.8`

### State Management
- `flutter_bloc: ^8.1.6` - BLoC/Cubit state management
- `equatable: ^2.0.7` - Value equality for state comparison

### Functional Programming
- `dartz: ^0.10.1` - Functional programming (Either, Option, Result types)

### HTTP & API
- `http: ^1.1.0` - HTTP client for REST API calls
- `geolocator: ^10.1.1` - Location services and GPS
- `permission_handler: ^11.4.0` - Runtime permission handling

### Local Storage & Database
- `shared_preferences: ^2.2.2` - Key-value storage
- `drift: ^2.29.0` - Type-safe SQL database (for native platforms)
- `drift_sqflite: ^2.0.1` - SQLite integration for Drift (mobile)

### UI & Design
- `google_fonts: ^6.1.0` - Custom fonts (Poppins)
- `lottie: ^2.7.0` - Vector animations
- `responsive_builder: ^0.7.0` - Responsive layouts
- `flutter_staggered_animations: ^1.1.1` - Staggered list animations

### Internationalization
- `easy_localization: ^3.0.7` - Localization and i18n support
- `intl: ^0.20.2` - Internationalization and date formatting

### Utilities
- `uuid: ^4.2.2` - Unique ID generation for tasks

### Development Dependencies
- `flutter_test: sdk: flutter`
- `flutter_lints: ^5.0.0` - Linting rules
- `build_runner: ^2.4.6` - Code generation
- `drift_dev: ^2.29.0` - Drift code generator

## 🚀 Getting Started

### Prerequisites

Before running the app, ensure you have:

- **Flutter SDK**: Version 3.0.0 or higher
- **Dart SDK**: Comes with Flutter
- **Development Tools**:
  - For Android: Android Studio or IntelliJ IDEA with Android SDK
  - For iOS: Xcode (macOS only)
  - For Web: Chrome browser
- **Device/Emulator**: Physical device or emulator for testing

### Installation

1. **Clone the repository:**
```bash
git clone <repository-url>
cd task_app
```

2. **Install dependencies:**
```bash
flutter pub get
```

3. **Generate required code (for Drift database):**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Running the App

#### 🌐 Web

**Option 1: Run in Chrome**
```bash
flutter run -d chrome
```

**Option 2: Run on local web server**
```bash
flutter run -d web-server --web-port 8080
```
Then open http://localhost:8080 in your browser.

**Option 3: Build for production**
```bash
flutter build web
```
The built files will be in `build/web/` directory.

#### 📱 Android

**Prerequisites:**
- Android SDK installed
- Android emulator running or physical device connected
- USB debugging enabled (for physical device)

**Run on Android:**
```bash
flutter run -d android
```

**Build APK:**
```bash
flutter build apk --release
```

**Build App Bundle (for Play Store):**
```bash
flutter build appbundle --release
```

#### 🍎 iOS

**Prerequisites:**
- macOS with Xcode installed
- iOS Simulator running or physical device connected
- Valid Apple Developer account (for physical device)

**Run on iOS:**
```bash
flutter run -d ios
```

**Build for release:**
```bash
flutter build ios --release
```

#### 🖥️ Desktop

**macOS:**
```bash
flutter run -d macos
```

**Windows:**
```bash
flutter run -d windows
```

**Linux:**
```bash
flutter run -d linux
```

### Troubleshooting

**Common Issues:**

1. **"No devices found"**
   - For Android: Check if device is connected with `adb devices`
   - For iOS: Ensure simulator is running
   - For Web: Install Chrome if not available

2. **Build Runner errors**
   - Run: `flutter pub run build_runner clean`
   - Then: `flutter pub run build_runner build --delete-conflicting-outputs`

3. **Location permission issues**
   - Android: Add permissions to `AndroidManifest.xml` (already configured)
   - iOS: Add permissions to `Info.plist` (already configured)
   - Web: Browser will prompt for location access

4. **Dependency conflicts**
   - Run: `flutter clean`
   - Then: `flutter pub get`

## 🎨 Color Palette

| Element | Color | Hex Code |
|---------|-------|----------|
| Primary | Mint Green | #4ECDC4 |
| Secondary | Deep Gray Blue | #556270 |
| Background | Off White | #F7FFF7 |
| Accent | Coral Red | #FF6B6B |
| Success | Green | #2ECC71 |
| Error | Red | #E74C3C |
| Warning | Orange | #F39C12 |
| Text Primary | Dark Gray | #2E2E2E |
| Text Secondary | Medium Gray | #6C757D |

## 🌐 API Configuration

The app uses **OpenWeatherMap API** for weather data:

- **API Key**: `e78ec0b2050f5a86824ca3383b518756` (Demo key)
- **Endpoint**: `https://api.openweathermap.org/data/2.5/weather`

**Features:**
- Current weather by coordinates
- Weather search by city name
- Support for metric and imperial units

**Note**: For production use, get your own API key from [OpenWeatherMap](https://openweathermap.org/api).

## 📱 Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| ✅ Android | Fully Supported | API 21+ |
| ✅ iOS | Fully Supported | iOS 12+ |
| ✅ Web | Fully Supported | Modern browsers |
| ✅ macOS | Supported | macOS 10.14+ |
| ✅ Windows | Supported | Windows 10+ |
| ✅ Linux | Supported | Ubuntu 18.04+ |

## 🎯 Project Structure

```
lib/
├── core/                           # Shared code
│   ├── error/                      # Error handling
│   │   ├── exceptions.dart         # Custom exceptions
│   │   └── failures.dart           # Failure types
│   ├── theme/                      # Theme configuration
│   │   ├── app_colors.dart         # Color constants
│   │   ├── app_theme.dart          # Light/Dark themes
│   │   └── theme_cubit.dart        # Theme state management
│   ├── language/                   # Localization
│   │   └── language_cubit.dart     # Language state management
│   └── utils/                      # Utilities
│       └── constants.dart          # App constants
│
├── features/                       # Feature modules
│   ├── tasks/                      # Task management
│   │   ├── domain/                 # Business logic
│   │   │   ├── entities/           # Business objects
│   │   │   │   └── task.dart
│   │   │   └── repositories/       # Repository interfaces
│   │   │       └── task_repository.dart
│   │   ├── data/                   # Data layer
│   │   │   ├── models/             # Data models
│   │   │   │   └── task_model.dart
│   │   │   ├── datasources/        # Data sources
│   │   │   │   └── app_database.dart
│   │   │   └── repositories/       # Repository implementations
│   │   │       └── task_repository_impl.dart
│   │   └── presentation/           # UI layer
│   │       ├── cubit/              # State management
│   │       │   ├── task_cubit.dart
│   │       │   └── task_state.dart
│   │       ├── pages/              # Screens
│   │       │   └── home_page.dart
│   │       └── widgets/            # UI components
│   │           ├── task_card.dart
│   │           ├── sidebar_widget.dart
│   │           └── ...
│   │
│   └── weather/                    # Weather feature
│       ├── domain/
│       │   ├── entities/
│       │   │   └── weather.dart
│       │   └── repositories/
│       │       └── weather_repository.dart
│       ├── data/
│       │   ├── models/
│       │   │   └── weather_model.dart
│       │   ├── datasources/
│       │   │   └── weather_remote_datasource.dart
│       │   └── repositories/
│       │       └── weather_repository_impl.dart
│       └── presentation/
│           ├── cubit/
│           │   ├── weather_cubit.dart
│           │   └── weather_state.dart
│           └── widgets/
│               └── weather_card.dart
│
├── assets/                         # Static assets
│   ├── lottie/                     # Animation files
│   └── translations/               # i18n files
│       ├── en.json                 # English translations
│       └── ar.json                 # Arabic translations
│
├── injection_container.dart        # Dependency injection
└── main.dart                       # App entry point
```

## 🎯 State Management

### Cubits Overview

#### 1. TaskCubit
Manages all task-related operations:
- ✅ Load tasks from database
- ✅ Add new task
- ✅ Update existing task
- ✅ Delete task
- ✅ Toggle task completion
- ✅ Search tasks
- ✅ Filter by tag
- ✅ Show completed/pending tasks

#### 2. WeatherCubit
Handles weather data:
- 🌤️ Fetch weather by location
- 🔍 Search weather by city name
- 🔄 Refresh weather data
- ⚡ Error handling

#### 3. ThemeCubit
Controls app theme:
- 🌙 Toggle dark/light mode
- 💾 Persist theme preference
- 🎨 Apply theme changes

#### 4. LanguageCubit
Manages app language:
- 🌍 Switch between languages
- 💾 Save language preference
- 🔄 Update UI on language change

## 🎨 Design Principles

1. **Material Design 3**: Using latest Material Design guidelines
2. **Responsive Design**: Adapts to all screen sizes seamlessly
3. **Accessibility**: Proper contrast ratios and touch targets
4. **Performance**: Optimized for 60fps animations
5. **User Experience**: Intuitive navigation and visual feedback
6. **Clean Code**: Following SOLID principles and best practices

## 🧪 Testing

Run all tests:
```bash
flutter test
```

Run specific test file:
```bash
flutter test test/path/to/test_file.dart
```

Generate coverage report:
```bash
flutter test --coverage
```

## 📝 Code Quality

The project follows:
- ✅ Flutter/Dart style guide
- ✅ Clean Architecture principles
- ✅ SOLID principles
- ✅ Repository pattern
- ✅ Dependency Injection
- ✅ Error handling with Either pattern
- ✅ Immutable state objects
- ✅ Proper separation of concerns

## 🚀 Performance Optimizations

- 🎯 Lazy loading of data
- 💾 Efficient local caching
- ⚡ Debounced search
- 🎨 Optimized animations
- 📱 Responsive images
- 🔄 Background data refresh

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style

- Follow the [Effective Dart](https://dart.dev/guides/language/effective-dart) guide
- Use meaningful variable and function names
- Add comments for complex logic
- Write tests for new features
- Update documentation as needed

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author

Built with ❤️ using Flutter

## 🙏 Acknowledgments

- [Flutter Team](https://flutter.dev) for the amazing framework
- [OpenWeatherMap](https://openweathermap.org) for the weather API
- [Google Fonts](https://fonts.google.com) for Poppins font family
- [Easy Localization](https://pub.dev/packages/easy_localization) for i18n support
- All open-source contributors

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Clean Architecture Guide](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [BLoC Pattern](https://bloclibrary.dev/)
- [Drift Documentation](https://drift.simonbinder.eu/)

---

## 🎯 Future Enhancements

Consider implementing for production:
- 🔐 User authentication (Firebase Auth, OAuth)
- ☁️ Cloud synchronization (Firebase, REST API)
- 📊 Analytics (Firebase Analytics, Mixpanel)
- 📱 Push notifications (FCM)
- 🐛 Error tracking (Sentry, Firebase Crashlytics)
- 🔔 Task reminders and notifications
- 📅 Calendar integration
- 🏷️ Custom tag creation
- 📤 Export/Import tasks
- 🎨 Theme customization
- 🌐 More languages support

---

**Made with 💙 using Flutter**

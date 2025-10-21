# TaskFlow - Beautiful Task Management App

A modern, elegant task management application built with Flutter using Clean Architecture and Cubit state management.

## ✨ Features

### Task Management
- ✅ Add new tasks with title, description, deadline, and optional tags
- ✏️ Edit existing tasks with smooth animations
- 🗑️ Delete tasks with confirmation dialog
- ✔️ Mark tasks as completed with animated checkmarks
- 🔍 Search and filter tasks by tag or status
- 📊 Visual progress indicator showing completion percentage

### Weather Integration
- 🌤️ Real-time weather information using OpenWeatherMap API
- 📍 Automatic location detection
- 🎨 Dynamic gradient backgrounds based on weather conditions
- 🔄 Pull to refresh weather data
- ✨ Beautiful glassmorphism weather card

### UI/UX Design
- 🎨 Modern, elegant interface with soft shadows and rounded corners
- 🌈 Beautiful gradient backgrounds and color palette
- 🌙 Dark mode support with smooth transitions
- 📱 Fully responsive design for mobile, tablet, and web
- 💫 Smooth animations throughout the app
- 🎭 Hover effects for web interface

### Responsive Layout
- 📱 Mobile: Single-column layout with drawer navigation
- 💻 Desktop/Web: Two-column layout with persistent sidebar
- 🎯 Adaptive FAB (standard on mobile, extended on web)
- 📐 Proper scaling across all screen sizes

## 🏗️ Architecture

This project follows **Clean Architecture** principles with three main layers:

### Domain Layer
- Entities: Pure business objects (Task, Weather)
- Repository Interfaces: Abstract contracts
- Use Cases: Business logic operations

### Data Layer
- Models: Data transfer objects
- Data Sources: Local (SharedPreferences) and Remote (HTTP)
- Repository Implementations: Concrete implementations

### Presentation Layer
- Cubits: State management using flutter_bloc
- Pages: Screen-level widgets
- Widgets: Reusable UI components

## 📦 Dependencies

### State Management
- `flutter_bloc: ^8.1.3` - State management
- `equatable: ^2.0.5` - Value equality

### Functional Programming
- `dartz: ^0.10.1` - Functional programming (Either, Option)

### HTTP & API
- `http: ^1.1.0` - HTTP client
- `geolocator: ^10.1.0` - Location services

### Local Storage
- `shared_preferences: ^2.2.2` - Key-value storage

### UI & Design
- `google_fonts: ^6.1.0` - Custom fonts (Poppins)
- `lottie: ^2.7.0` - Animations
- `responsive_builder: ^0.7.0` - Responsive layouts
- `flutter_staggered_animations: ^1.1.1` - List animations

### Utilities
- `intl: ^0.18.1` - Internationalization and date formatting
- `uuid: ^4.2.2` - Unique ID generation

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.9.2 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Chrome (for web development)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd task_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate database code (required for Drift):
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Run the app:

**For Web:**
```bash
flutter run -d chrome
```

**For Android:**
```bash
flutter run -d android
```

**For iOS:**
```bash
flutter run -d ios
```

**For macOS:**
```bash
flutter run -d macos
```

## 🎨 Color Palette

| Element | Color | Hex Code |
|---------|-------|----------|
| Primary | Mint Green | #4ECDC4 |
| Secondary | Deep Gray Blue | #556270 |
| Background | Off White | #F7FFF7 |
| Accent | Coral Red | #FF6B6B |
| Text Primary | Dark Gray | #2E2E2E |
| Text Secondary | Medium Gray | #6C757D |

## 🌐 API Configuration

The app uses OpenWeatherMap API for weather data. The API key is already configured in the code:
- API Key: `e78ec0b2050f5a86824ca3383b518756`
- Endpoint: `https://api.openweathermap.org/data/2.5/weather`

## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Linux
- ✅ Windows

## 🎯 Key Features Implementation

### Clean Architecture
```
lib/
├── core/              # Shared utilities, theme, errors
├── features/
│   ├── tasks/         # Task management feature
│   │   ├── domain/    # Business logic
│   │   ├── data/      # Data handling
│   │   └── presentation/ # UI & state management
│   └── weather/       # Weather feature
└── main.dart          # App entry point
```

### State Management with Cubit
- **TaskCubit**: Manages task CRUD operations, filtering, and search
- **WeatherCubit**: Handles weather data fetching and updates
- **ThemeCubit**: Controls dark/light mode switching

### Dependency Injection
All dependencies are initialized in `injection_container.dart` using a simple dependency injection pattern.

## 🎨 Design Principles

1. **Material Design 3**: Using latest Material Design guidelines
2. **Responsive Design**: Adapts to all screen sizes
3. **Accessibility**: Proper contrast ratios and touch targets
4. **Performance**: Optimized for 60fps animations
5. **User Experience**: Intuitive navigation and feedback

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📝 Code Quality

The project follows:
- Flutter/Dart style guide
- Clean Architecture principles
- SOLID principles
- Repository pattern
- Use case pattern

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License.

## 👨‍💻 Author

Built with ❤️ using Flutter

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- OpenWeatherMap for the weather API
- Google Fonts for Poppins font family
- All open-source contributors

---

**Note**: This is a demo application. For production use, consider implementing:
- Error tracking (Sentry, Firebase Crashlytics)
- Analytics (Firebase Analytics, Mixpanel)
- Backend integration (Firebase, REST API)
- User authentication
- Cloud synchronization
- Push notifications

class AppConstants {
  // API
  static const String weatherApiKey = 'e78ec0b2050f5a86824ca3383b518756';
  static const String weatherApiBaseUrl =
      'https://api.openweathermap.org/data/2.5';
  static const String weatherIconBaseUrl = 'https://openweathermap.org/img/wn';

  // Local Storage Keys
  static const String tasksKey = 'tasks';
  static const String themeModeKey = 'theme_mode';

  // Task Tags
  static const List<String> taskTags = [
    'Work',
    'Personal',
    'Shopping',
    'Health',
    'Study',
    'Finance',
    'Travel',
    'Other',
  ];

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 400);
  static const Duration longAnimationDuration = Duration(milliseconds: 600);

  // Responsive Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
}

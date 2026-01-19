# Ten Twenty Task - Movie Theater App

A Flutter application for browsing movies, selecting theaters, and booking seats. Built with clean architecture, BLoC pattern, and modern UI/UX design.

## 📱 Features

- **Movie Browsing**: Browse upcoming movies with beautiful banners and details
- **Movie Details**: View comprehensive movie information including genres, overview, and trailers
- **Theater Selection**: Select date, time, and theater for movie showings
- **Seat Selection**: Interactive seat map with zoom functionality and seat type selection (VIP/Regular)
- **Search**: Search movies with real-time results
- **Trailer Viewing**: Watch movie trailers using YouTube player
- **Bottom Navigation**: Easy navigation between Dashboard, Watch, Media Library, and More sections

## 🏗️ Architecture

The project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/           # Core utilities, themes, styles, constants
├── data/           # Data layer (repositories, models, services, database)
├── domain/         # Business logic entities
├── presentation/   # UI layer (screens, widgets, BLoC)
└── routes/         # App routing configuration
```

### State Management
- **BLoC Pattern** using `flutter_bloc` for state management
- Separate BLoCs for different features:
  - `BottomNavBloc` - Navigation state
  - `UpcomingMoviesBloc` - Movie listings
  - `SearchBloc` - Search functionality
  - `SeatSelectionBloc` - Seat selection with zoom
  - `TheaterSelectionBloc` - Theater and showtime selection
  - `WatchTrailerBloc` - Trailer playback

### Database
- **Floor** (SQLite wrapper) for local data persistence
- Caching movie data and search results

## 🚀 Getting Started

### Prerequisites

- Flutter SDK >=3.10.3
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd ten_twenty_task
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate database code** (if needed)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

**Android:**
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

## 📦 Dependencies

### Main Dependencies
- `flutter_bloc` ^9.0.0 - State management
- `dio` ^5.8.0+1 - HTTP client
- `cached_network_image` ^3.4.1 - Image caching
- `youtube_player_flutter` ^9.1.1 - Trailer playback
- `floor` ^1.5.0 - SQLite database
- `flutter_svg` ^2.0.17 - SVG support
- `equatable` ^2.0.7 - Value equality

### Dev Dependencies
- `flutter_lints` ^6.0.0 - Linting rules
- `build_runner` ^2.4.13 - Code generation
- `floor_generator` ^1.5.0 - Database code generation

## 🎨 Design System

### Colors
- Primary: `#61C3F2` (Blue)
- Background: `#F6F6FA` (Light Gray)
- Bottom Nav Background: `#2E2739` (Dark Purple)
- Text Dark: `#202C43`
- Seat Colors:
  - Selected: `#FFB800` (Yellow)
  - VIP: `#564CA3` (Purple)
  - Regular: `#61C3F2` (Blue)
  - Not Available: `#DBDBDF` (Gray)

### Typography
- Font Family: **Poppins**
- Multiple weights: Thin, Light, Regular, Medium, SemiBold, Bold, ExtraBold, Black

## 📁 Project Structure

```
lib/
├── core/
│   ├── constant/      # App constants
│   ├── extension/     # Dart extensions
│   ├── styles/        # Colors and typography
│   ├── themes/        # App themes
│   └── utils/         # Utility functions
├── data/
│   ├── local/         # Database and local storage
│   ├── model/         # Data models
│   ├── repositories/  # Data repositories
│   └── services/      # API services
├── domain/
│   └── entities/      # Business entities
├── presentation/
│   ├── bloc/          # BLoC state management
│   ├── config/        # Configuration files
│   ├── screens/       # App screens
│   └── widgets/      # Reusable widgets
└── routes/
    └── app_routes.dart # Navigation routes
```

## 🎯 Key Features Implementation

### Seat Selection Screen
- Interactive theater map with zoom in/out
- Horizontal scrolling when zoomed
- Seat type selection (VIP/Regular)
- Real-time price calculation
- Selected seats display

### Theater Selection
- Date picker for show dates
- Showtime selection
- Theater and hall information
- Price and bonus display

### Movie Details
- Movie banner
- Genre chips
- Overview section
- Action buttons (Watch Trailer, Get Tickets)
- Related content

## 🔧 Configuration

### API Configuration
Update API endpoints in `lib/data/services/api_services.dart`

### Database
Database is automatically initialized on app start. The database file is created at:
- Android: `/data/data/com.example.ten_twenty_task/databases/app_database.db`
- iOS: App's documents directory

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📱 Screenshots

The app includes:
- Dashboard with movie listings
- Watch screen with categories
- Movie details with trailers
- Theater and seat selection
- Search functionality

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is private and proprietary.

## 👨‍💻 Development

### Code Style
- Follow Flutter/Dart style guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Keep widgets small and reusable

### BLoC Pattern
- Each feature has its own BLoC
- Events trigger state changes
- Use `BlocBuilder` or `BlocListener` in UI
- Keep business logic in BLoC, not in widgets

## 🐛 Known Issues

- None currently

## 🔮 Future Enhancements

- User authentication
- Payment integration
- Booking history
- Push notifications
- Social sharing
- Reviews and ratings

## 📞 Support

For issues and questions, please open an issue in the repository.

---

**Built with ❤️ using Flutter**

# VV Admin
A Flutter-based admin application with comprehensive features for business management and administration.

## Getting Started

### Prerequisites

- Flutter SDK (>=3.2.0)
- Dart SDK (>=3.2.0)
- Android Studio / VS Code
- Git

### Installation

1. Clone the repository:
```bash
git clone [repository-url]
cd vv_admin
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run
```

## Features
- 🌐 Multi-language support with Flutter localizations
- 🔐 Authentication and authorization
- 🌍 Connectivity handling
- 📱 Push notifications (Firebase)
- 📍 Location services with Google Maps integration
- 📊 Data visualization with Syncfusion charts
- 📸 Image handling and caching
- 🖨️ Thermal printer support
- 📱 Barcode scanning and generation
- 📂 File management and downloads
- 🎥 Media player support (video and audio)
- 📊 Interactive data tables
- 📱 Responsive UI with shimmer effects

## Project Structure
```
lib/
├── data/
├── di/
├── localization/
├── models/
├── providers/
├── screens/
├── services/
├── utils/
└── widgets/
```

## Dependencies

### State Management
- Provider: ^6.1.1
- GetIt: ^7.6.4

### Network & API
- Dio: ^5.4.0
- Connectivity Plus: ^5.0.2

### UI Components
- Shimmer: ^3.0.0
- Flutter Switch: ^0.3.2
- Flutter Slidable
- Carousel Slider: ^5.0.0
- SyncFusion Components

### Storage
- Shared Preferences: ^2.2.2
- Path Provider: ^2.1.1

### Firebase
- Firebase Core: ^2.24.2
- Firebase Messaging: ^14.7.9

### Media
- Image Picker: ^1.0.5
- Cached Network Image: ^3.3.1
- Video Player: ^2.9.1
- AudioPlayers: ^6.0.0

### Location
- Google Maps Flutter: ^2.5.0
- Geocoding: ^2.1.1
- Geolocator: ^10.1.0

## Assets
The project includes the following assets:
- Images: `assets/image/`
- Language files: `assets/language/`
- Fonts: Ubuntu (Regular, Medium, Bold)

## Versioning
Current version: 1.0.0+0

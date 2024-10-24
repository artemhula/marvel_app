# Marvel App

**App based on Marvel Comics API**

This Flutter application interacts with the Marvel Comics API to display information about various Marvel characters, comics, and other content. The app utilizes the Hive database for local data storage, allowing users to cache and manage their favorite Marvel characters.

## 📋 Features
- Fetches and displays data from the Marvel API.
- Local data storage using Hive.
- Search functionality for finding characters by name.
- Favorite characters management (add, delete, and check favorites).
- UI design copied from [here](https://dribbble.com/shots/4985712-Marvel-Heroes-Library).

## 🛠️ Technologies
- **Hive**: Lightweight and fast key-value database used for local data storage.
- **Bloc**: State management solution based on the BLoC pattern (Business Logic Component).
- **Dartz**: Functional programming utilities for Dart.
- **Equatable**: Simplifies the implementation of equality for Dart classes.
- **http**: For making API requests to the Marvel API.
- **Cached Network Image**: For efficient image caching and loading.
- **GetIt**: Service locator for dependency injection.
- **Internet Connection Checker**: For monitoring the internet connection.
 
## 🔧 Requirements

- **Flutter SDK**: Version 3.10.0 or higher
- **Dart SDK**: Version 3.2.3 or higher


## 🚀 Installation & Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/marvel-app.git
   ```
2. Navigate to the project directory:
   ```bash
   cd marvel-app
   ```
3. Install the necessary dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## 📱 Download APK
You can download APK from this [link](https://drive.google.com/file/d/1kf1g7FI7mRQdr1iFzuyZ1q7at_ysifoX/view?usp=sharing)  

## 🎥 Demo
https://github.com/artemhula/marvelapp/assets/66064927/60eb1de9-e87f-42fd-8f8e-9052fdf75856

## 📂 Project Structure
The project follows a clean architecture structure, separating the app into several layers:

- **lib/core**: Contains constants, error handling, and utility classes.
  - `constants/`: API keys and endpoint constants.
  - `error/`: Error handling .
- **lib/feature/data**: Data layer for interacting with the Marvel API and local Hive database.
  - `datasources/`: Data sources for remote and local storage
  - `models/`: Data models for character representation.
  - `repositories/`: Implementation of repositories that handle data operations.
- **lib/feature/domain**: Business logic layer.
  - `entities/`: Core data structures.
  - `repositories/`: Abstractions for repositories.
  - `usecases/`: Application-specific logic (e.g., fetching characters, managing favorites).
- **lib/feature/presentation**: Presentation layer using BLoC for state management.
  - `bloc/`: Business Logic Components for managing states.
  - `views/`: UI screens.
  - `widgets/`: Reusable widgets for UI components.
- `locator_service.dart`: Service locator for dependency injection.
- `main.dart`: Entry point of the application.

---

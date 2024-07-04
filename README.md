# Boring App Documentation

## Description

Boring App is a mobile application built using Flutter that interfaces with the Bored API to present
users with various
activities to engage in. The app dynamically categorizes activities and allows users to 'like' their
favorite ones,
saving preferences locally for future reference. It features an infinite scrolling mechanism,
fetching new activities as
the user scrolls, ensuring a continuous stream of suggestions.

## Features

- **Categorized Activities**: Activities are presented in categories, enabling easy navigation and
  selection based on
  user interest.
- **Likes and Preferences**: Users can 'like' activities, with these preferences being saved to the
  device for quick
  recognition of previously favored activities.
- **Infinite Scrolling**: The app continuously loads new activities as the user scrolls, providing
  an endless supply of
  suggestions.

## Packages

Below are the primary packages used in the development of Boring App:

```yaml
dependencies:
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  dio: ^5.3.3
  shared_preferences: ^2.2.2
  cached_network_image: ^3.3.0
  bloc_test: ^9.1.5
  mockito: ^5.4.2
  build_runner: ^2.4.6
```

## Architecture Overview

The Boring App is structured to follow clean architecture principles, separating concerns into
logical layers, and
utilizing the BLoC pattern for state management.

### Directory Structure

- `lib/`
    - `business_logic/`
        - `blocs/` : Manages state and activity operations
        - `repositories/`: Abstraction layer for data fetching and persistence.
    - `data/`
        - `models/`: Data models
        - `providers/`: Manages fetching and storing data from API or local storage.
    - `helpers/`: Utility functions for text formatting, preferences updates, etc.
    - `presentation/`
        - `pages/` Page views
        - `widgets/`: Custom UI components for pages.
    - `utils/`: Utility classes for icons, images, themes, and styles.
    - `app.dart`: Application itself
    - `main.dart`: Entry point of the Flutter application.

### Architectural Components

#### Data Layer

- **Models (`data/models/`):** Define the structure of the data objects.
- **Providers (`data/providers/`):** Handle logic for data retrieval and storage.

#### Business Logic Layer

- **Repositories (`business_logic/repositories/`):** Mediate between data providers and BLoC layers,
  providing a clean
  API for data requests.
- **BLoCs/Cubits (`business_logic/blocs/`):** Manage the state of the application for various
  features, emitting new
  states in response to events.

#### Presentation Layer

- **Pages (`presentation/pages/`):** Screens of the application, subscribing to state changes and
  presenting UI.
- **Widgets (`presentation/widgets/`):** Reusable UI components.

#### Helpers and Utilities

- **Helpers (`helpers/`):** Functions for common operations like formatting and updating shared
  preferences.
- **Utilities (`utils/`):** Provide constants, icons, images, theme data, and text styles used
  across the app.

## Data Flow

1. **API Communication**: The app uses the **Dio** package to perform HTTP requests, retrieving data
   from the Bored API.
2. **State Management**: State is managed via the flutter_bloc package, which orchestrates the flow
   of data within the
   app, ensuring a reactive and responsive user experience.
3. **Local Storage**: User preferences, such as liked activities, are stored locally with the
   shared_preferences
   package, allowing for personalization and a more tailored user experience.

## Running the Boring App

This guide assumes that you have Flutter installed on your machine. If not, please refer to
the [Flutter installation documentation](https://flutter.dev/docs/get-started/install) to set up
Flutter on your system.

### Prerequisites

Before running the app, make sure you have the following installed:

- Flutter SDK (Channel stable, latest version)
- Dart SDK (latest version)
- An IDE (like Android Studio, VS Code, IntelliJ)
- A compatible Android or iOS device or emulator

### Steps to Run

1. **Clone the Repository:**
   ```shell
   git clone https://github.com/aktumut/boring-app.git
   cd boring-app
    ```
2. **Get Packages:**
   Retrieve all the necessary packages by running the following command in your terminal:
   ```shell
   flutter pub get
    ```

4. **Launch Emulator/Simulator:**
   To run the app on an emulator or simulator, ensure that it is running before executing the app.
   For Android Studio
   and IntelliJ, you can start an emulator via the AVD Manager. For VS Code, you can start it from
   the Command Palette
   by searching for `Flutter: Launch Emulator`.

5. **Run the App:**
   With the emulator or simulator running, or a physical device connected, execute the following
   command to run the app:
   ```shell
   flutter run
     ```

## Testing Documentation for `CallToActionButton` Widget

### Overview

The `CallToActionButton` widget in the Boring App project is rigorously tested to ensure its
consistent performance and integration with the BLoC architecture. The test primarily focuses on the
widget's rendering and its interaction with `AppBarCubit` and `ActivityCubit`.

### Test Execution

- Simulates a user interaction by tapping the `ElevatedButton` within the `CallToActionButton`.
- Invokes `pumpAndSettle` to ensure the completion of all animations and asynchronous operations
  post-interaction.

### Assertions and Verifications

- Asserts the rendering of the `CallToActionButton` widget by finding the `ElevatedButton`.
- Verifies that tapping the button triggers the `expandAppBarWithAllFilters` method on `AppBarCubit`
  with expected parameters.

### Running the Test

Execute this test using the command:

```shell
flutter test test/widget_test.dart
```

### Conclusion

- This test validates the CallToActionButton widget's functionality and its interaction with the
  BLoC architecture, ensuring that it behaves as expected in the broader application context. 
# Attendance App - Hackathon by Vinove

## Features

### 1. Attendance Member List

- From the main menu, navigate to the "Attendance" screen to view a list of team members.
- Each member has two icons:
  - The first icon opens a calendar to view detailed attendance records.
  - The second icon opens the live location and route-tracking screen.

### 2. Live Location

- Supervisors can track the live location of users.
- Currently, dummy user locations are shown for testing purposes.

### 3. Route Details and Stops

- When two locations are selected, a route is generated between them.
- The next screen displays:
  - **Start Location**
  - **Stop Location**
  - **Total Kilometers Traveled**
  - **Total Duration**

### 4. Firebase Integration

- The project uses Firebase Authentication to manage supervisor logins, signups, and signouts.
- This ensures that only authorized supervisors can access attendance and location data.
  
## Dependencies

- **Firebase Core**: For initializing Firebase services.
- **Firebase Auth**: For handling authentication functionalities.
- **GetX**: For efficient state management and navigation.
- **Google Maps Flutter**: This is for embedding Google Maps into the app and displaying member locations and routes.

## How to Run

1. Clone the repository.
2. Run `flutter pub get` to install the dependencies.
3. Set up Firebase by following the [official documentation](https://firebase.flutter.dev/docs/overview) and adding your `google-services.json` to the project.
4. Execute the app on your desired platform using `flutter run`.

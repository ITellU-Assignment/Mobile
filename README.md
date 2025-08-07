````markdown
# iTellU Mobile (Flutter)

## Overview
Student app to view and respond to pending lesson invites.

**Features:**
- Fetches pending invites via REST (`GET /invites?status=pending`)  
- Accept or reject invites (`PATCH /invites/:id`)  
- Dark theme with a teal accent  
- Pull-to-refresh via AppBar action  

## Tech Stack
- Flutter (Dart)  
- `http` package for API communication  

---

## Setup & Run

1. **Install Flutter dependencies**  
   ```bash
   cd mobile
   flutter pub get
````

2. **Configure API URL**
   By default the app points to `http://localhost:5000`.
   If your backend runs elsewhere, open
   `lib/services/api_service.dart` and update:

   ```dart
   static const String _baseUrl = 'http://localhost:5000';
   ```

3. **Launch the app**

   ```bash
   flutter run
   ```

   * Choose your connected device, emulator, or specify `-d chrome` for web.

4. **Use the UI**

   * The **Pending Invites** screen loads all invites with status `pending`.
   * Tap **Accept** or **Reject** on each card to update its status.

---

## Project Structure

```
mobile/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   └── invite.dart
│   └── services/
│       └── api_service.dart
├── pubspec.yaml
└── README.md
```

---

## Assumptions

* **No login** — student identity is implicit for demo purposes.
* **Only pending invites** are shown; accepted/rejected are filtered out.
* Backend API must be running and accessible at the configured `_baseUrl`.
* Dark mode and accent color chosen for a modern, security‐focused aesthetic.

```
```

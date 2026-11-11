# Top It Up Retailer Project Guide

This document explains where code belongs so future developers can extend the app consistently. It is the common guide for the Flutter project. Feature-specific decisions belong in the related files under `agent/`.

## Project map

```text
lib/
  main.dart                  App entry point and root MaterialApp
  screens/                   Full screens and feature page widgets
  shared/
    widgets/                 Reusable UI components shared by screens
    models/                  Shared data models used by multiple features
  theme/                     Colors, typography, and Material theme
  core/
    config/                  Environment values and app configuration
    constants/               App-wide keys, labels, route names, and limits
    methods/                 Small reusable helpers with no feature state
    network/                 API client, request helpers, and interceptors
    storage/                 Local database, preferences, and secure session storage
  features/
    <feature>/
      data/                   Feature API sources, DTOs, and repositories
      domain/                 Feature entities and business rules
      presentation/           Feature-specific widgets and controllers
assets/                       Images, icons, fonts, and other bundled assets
agent/                        Developer documentation and feature contracts
android/, ios/, web/, ...    Platform configuration and native resources
```

Only folders with files are kept by Git. Create a folder when the first implementation file is needed.

## File responsibilities

### `lib/main.dart`

Use this file for app startup and the root `MaterialApp` configuration. Keep global initialization here. Do not place API calls, database queries, or large screen layouts here.

### `lib/screens/`

Use this folder for complete pages such as login, dashboard, and future full-screen flows. A screen may compose feature widgets, but reusable controls should move to `lib/shared/widgets/`.

Current screens:

- `login.dart`: retailer and supplier login form, field validation, and dashboard navigation.
- `dashboard.dart`: shared dashboard shell, header, service grid, bottom navigation, and Coming Soon content.

### `lib/shared/widgets/`

Use this folder for reusable presentation-only widgets. These widgets should receive values and callbacks through constructor parameters and should not call APIs directly.

Current example:

- `topitup_brand_lockup.dart`: shared brand logo and tagline widget.

### `lib/shared/models/`

Use this folder for models shared by more than one feature. Keep models focused on data and serialization. Do not put network calls or widget code in models.

### `lib/theme/`

- `app_colors.dart`: named color constants.
- `app_theme.dart`: Material theme, component defaults, typography, and interaction colors.

Add shared visual tokens here instead of scattering new colors or styles across screens.

### `lib/core/config/`

Use for environment-specific configuration such as development and production settings. API base URLs, feature flags, and build-time values belong here. Never hard-code secrets in this folder.

### `lib/core/constants/`

Use for app-wide immutable values: route names, storage keys, timeout values, supported roles, and shared labels. Feature-only constants should stay beside that feature.

### `lib/core/methods/`

Use for small stateless helpers such as formatting, validation utilities, date conversion, and input normalization. Helpers must not own widget state or perform hidden network/database work.

### `lib/core/network/`

Use for HTTP concerns only:

- API client setup and base URL handling.
- Request headers, authentication headers, and interceptors.
- Timeout, retry, status-code, and response parsing helpers.
- Shared network exceptions.

Feature repositories call this layer. Screens and widgets should never call an HTTP client directly.

### `lib/core/storage/`

Use for local persistence:

- Secure token and session storage.
- Preferences and app settings.
- Local database adapters and migrations.
- Cache reads and writes.

Keep database implementation details in this folder. Expose typed methods to feature repositories instead of passing raw database handles into widgets.

### `lib/features/<feature>/data/`

Use for one feature's data layer:

- API data sources.
- Database data sources.
- DTOs and JSON serialization.
- Repository implementations.

For example, authentication API calls belong in `lib/features/auth/data/`, not in `login.dart`.

### `lib/features/<feature>/domain/`

Use for business rules independent of Flutter and network libraries:

- Entities.
- Repository interfaces.
- Use cases.
- Business validation that is reused outside a widget.

### `lib/features/<feature>/presentation/`

Use for feature-specific UI pieces and state:

- Controllers, notifiers, or view models.
- Feature widgets.
- Feature-specific screen sections.

Keep navigation and screen composition clear. A presentation controller can call a domain use case, but should not contain raw SQL or HTTP code.

## Recommended request flow

```text
Screen/widget
  -> presentation controller or view model
  -> domain use case
  -> repository interface
  -> data source
  -> core/network or core/storage
```

The response travels back through the same layers as a typed result. This keeps UI code testable and lets the API or database implementation change without redesigning screens.

## Navigation rules

- Use Flutter widgets and routes instead of Android fragments.
- Keep shared dashboard chrome in `DashboardScreen` when a page must retain the header and bottom navigation.
- Use a separate route for a full-screen flow that intentionally replaces the dashboard shell.
- Add route names to `lib/core/constants/` when the app grows beyond the current direct `MaterialPageRoute` usage.

## Assets and platform folders

- `assets/`: Flutter assets declared in `pubspec.yaml`.
- `android/`: Android manifest, launcher icon, native splash, and Gradle configuration.
- `ios/`: iOS app delegate, launch screen, icons, and Xcode settings.
- `web/`, `macos/`, `windows/`, `linux/`: platform-specific runner configuration.

Keep platform-only behavior in its platform folder. Keep shared UI and business logic in `lib/`.

## Documentation workflow

Before starting a feature, create `agent/<feature>.md` with:

1. Goal and screen flow.
2. Design reference and layout rules.
3. Current interactions.
4. Data and API contract.
5. Implementation paths.
6. Pending decisions.
7. Acceptance criteria.

Update the document after implementation so it describes what is actually working and what still needs backend or database integration.

## Current integration status

The login and dashboard are currently frontend flows. Authentication, API access, database adapters, and session persistence should be added through the architecture above when the backend contract is available.


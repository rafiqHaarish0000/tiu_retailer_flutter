# UI architecture

The Flutter UI is organized by navigation level and feature, following the
same separation used in a feature-based native Android project.

```text
ui/
├── auth/screens/                 Login flow
├── dashboard/
│   ├── screens/                  Dashboard shell and state wiring
│   ├── data/                     Dashboard service registry
│   ├── dialogs/                  Account, store, and logout dialogs
│   └── widgets/                  Shared dashboard chrome
├── bottom_navigation/
│   ├── screens/                  Home, wholesale payment, and supplier flows
│   └── widgets/                  Shared bottom-navigation flow widgets
└── modules/
    ├── shared/                   Shared module placeholder UI
    └── <feature>/screens/        One screen package per dashboard service
```

The files in `lib/screens/` are compatibility exports so existing imports do
not break. New UI work should be added under `lib/ui/`.

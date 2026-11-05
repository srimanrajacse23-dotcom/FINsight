# FINsight

FINsight is an AI-powered unified financial management platform that integrates digital payments, expense tracking, smart budgeting, bill and subscription management, financial health scoring, and personalized financial insights to help users manage, monitor, and optimize their finances through a single application.

## Flutter foundation

This repository now contains a clean Flutter foundation aligned to:

- Flutter `3.47.9`
- Dart `3.13.7`
- Riverpod 3 (`flutter_riverpod`)
- GoRouter (`go_router`)

### Architecture

Feature-first and modular structure:

```text
lib/
  main.dart
  app/
    app.dart
    router.dart
    theme/
  core/
    constants/
    utils/
    responsive/
  shared/
    widgets/
    components/
    navigation/
  features/
    onboarding/
    profile_selection/
    personal/
    business/
    freelancer/
    merchant/
  mock_data/
```

### Implementation decisions

- `main.dart` is intentionally minimal and only bootstraps `ProviderScope` + app root.
- Routing is centralized in `lib/app/router.dart` with named route constants.
- Theme and color tokens are centralized in `lib/app/theme/` using the FINsight visual direction (ivory background, forest green primary, pale sage secondary).
- `AppShell` provides responsive constraints and spacing for mobile/tablet/desktop without coupling layout logic to feature screens.
- Current screens are placeholders only, using mock/profile context. No real financial integrations, auth flows, or backend APIs are implemented.

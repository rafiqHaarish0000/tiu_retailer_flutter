# Login screen

**Status:** Frontend UI implemented; authentication integration pending.

This is the source of truth for the login screen. Update this document with the intended behavior and design before changing the implementation. Use the same approach for future screens: create `agent/<feature>.md` first, then build the feature, and finally record what was actually delivered and what remains pending.

## Screen flow

1. The app starts on `SplashScreen` with the Top it Up logo and tagline.
2. After 1.6 seconds, the splash screen is replaced by `LoginScreen`.
3. The login screen shows the logo, Retailer/Supplier selector, username and password fields, a CAPTCHA mockup, Login button, and copyright footer.

The app root lives in `lib/main.dart`, the splash screen in `lib/screens/splash.dart`, the login screen in `lib/screens/login.dart`, and the shared brand lockup in `lib/shared/widgets/topitup_brand_lockup.dart`. The logo asset is `assets/images/topitup_logo.png`; its registration is in `pubspec.yaml`. Shared colors and theme settings live in `lib/theme/`.

## Design contract

- Keep the login content centered inside a white rounded panel on a pale blue-gray background, with the brand lockup above and footer below.
- Scale the layout to the available width and height so all login elements fit without page scrolling at the supported mobile viewport. Preserve consistent horizontal alignment between labels, fields, and Login button.
- Show `USERNAME` and `PASSWORD` in uppercase dark blue-gray text. Both inputs must have **the same width and height**.
- Each input has exactly one rounded blue-gray border and a very light blue-gray fill. Do not add an inner `TextField` border or a second focus outline.
- Vertically center the hint, entered text, leading icon, and password visibility icon inside their field. Keep the hint and icons in the same muted blue-gray family.
- Show Retailer selected initially; the selector uses red for the selected option and blue-gray for the other option.
- Show the Login button with the red-to-orange gradient and arrow. Preserve the CAPTCHA and footer positions within the panel layout.

Current input implementation: `_buildInputFrame` owns the field height (`96 * scale`), fill, and only visible border. The child `TextField` sets `textAlignVertical: TextAlignVertical.center`, `filled: false`, and `InputBorder.none` for `border`, `enabledBorder`, and `focusedBorder`. These explicit overrides are needed because `AppTheme` supplies input borders by default.

## Current interactions

| Element | Behavior today |
| --- | --- |
| Retailer / Supplier | Changes the selected visual state only; Retailer is selected initially. |
| Username | Editable text field; no validation or submission. |
| Password | Editable, obscured initially; eye icon toggles visibility. |
| CAPTCHA | Local checkbox mockup only; it does not verify a real CAPTCHA token. |
| Login | Displays the button, but its tap handler is empty; it does not authenticate or navigate. |

`LoginScreen.defaultUsername` (`retailer`) and `LoginScreen.defaultPassword` (`retailer123`) are placeholder constants. They are **not** prefilled in the fields or checked by the Login button. The empty `callLoginApi()`, `callDatabase()`, and `onLoginButtonPressed()` methods in `_LoginScreenState` are integration placeholders and are not wired to the UI.

## Backend handoff

The folders under `lib/core/{config,network,storage}/`, `lib/features/auth/{data,domain,presentation}/`, and `lib/shared/{models,widgets}/` are architecture placeholders. There is no implemented base URL, API client, database adapter, authentication model, or session storage yet. Empty directories are not retained by Git until files are added.

Before implementing authentication, document the agreed backend contract here:

- Base URL and environment configuration; endpoint, method, request fields, and response shape.
- Whether Retailer and Supplier use the same endpoint and how the selected role is sent.
- Validation and error messages, loading and retry behavior, and the destination after success.
- Token/session storage and logout behavior.
- Real CAPTCHA provider, site key, and backend verification requirements, if CAPTCHA remains in scope.

Then implement those pieces in the corresponding architecture folders, wire the Login button and placeholder methods to the agreed flow, and update this document to reflect the implemented behavior. Do not treat the mock CAPTCHA or placeholder credentials as working authentication.

## Format for the next feature document

Start each new `agent/<feature>.md` with: **goal and screen flow**, **design reference and layout rules**, **current interactions**, **data/API contract**, **implementation paths**, **pending decisions**, and **acceptance criteria**. Write the planned behavior first; after implementation, mark what works and what still needs integration. Keep the document accurate as the code changes.

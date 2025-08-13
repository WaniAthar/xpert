# Xpert Test (Flutter)

A Flutter demo showcasing a funding account dashboard UI with responsive cards, status/phase chips, gradient borders, and shimmer loading states.

## Demo (Video)


<!-- local video -->
<video width="1920" controls>
  <source src="demo/demo.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>


## Features

- **Mobile and Desktop cards** using `MobileCardWidget` and `DesktopCardWidget`.
- **Phase progression** visualization via `PhaseChip` and dotted gradient lines.
- **Status indicators** with `StatusChip` and an optional `ProChip`.
- **Shimmer loading** placeholder component.
- **Reusable UI**: `GradientBorder`, `DottedLine`, and SVG icon utilities.

## Project Structure

- `lib/main.dart` – App entry
- `lib/views/home_screen.dart` – Home screen with list/grid of cards
- `lib/views/widgets/card_widget.dart` – `MobileCardWidget`, `DesktopCardWidget`
- `lib/views/widgets/shimmer_loading.dart` – Shimmer loading UI
- `lib/views/widgets/gradient_border.dart` – Gradient border container
- `lib/views/widgets/chips/` – `status_chip.dart`, `phase_chip.dart`, `pro_chip.dart`
- `lib/data/icons.dart` – Centralized SVG icon refs
- `lib/models/funding_info_model.dart` – Data model for funding info

## Getting Started

### Prerequisites

- Flutter SDK installed (stable channel)
- Dart SDK (bundled with Flutter)
- Android Studio / Xcode (for emulator/simulator), or a physical device

Check your setup:

```bash
flutter doctor
```

### Install Dependencies

```bash
flutter pub get
```

### Run

```bash
flutter run
```

Select your device/emulator when prompted. Hot reload is supported.

### Build Release (Android APK)

```bash
flutter build apk --release
```

### Static Analysis & Format

```bash
flutter analyze
dart format .
```


## Notes

- UI components rely on gradients and transparency; run on a device/emulator to see the full effect.
- Replace dummy data in `FundingInfoModel` with your backend or local fixtures as needed.

## License

This project is for demonstration/testing purposes. Add a license if you plan to distribute.


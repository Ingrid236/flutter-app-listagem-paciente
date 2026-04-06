# Research & Decisions: 003-advanced-forms

## 1. Form Validation and Data Management State (Provider vs flutter_bloc)
- **Decision**: Use `PacienteFormCubit` (extending BLoC's `Cubit`) instead of raw `ChangeNotifier/Provider` for the form state.
- **Rationale**: The project currently uses `flutter_bloc` for `AuthCubit` and `PacienteCubit`. Mixing `ChangeNotifier` and `Cubit` adds unnecessary architectural noise. `PacienteFormCubit` satisfies the requirement for a "Provider" that holds state, valides inputs, and does not leak `TextEditingController` directly to the view. Note: Since `TextEditingController` is intrinsically tied to Flutter's UI view layer, the Cubit will emit valid/invalid flag states while the UI layer manages the explicit `TextEditingController` lifecycles securely in `StatefulWidget.dispose()`, keeping memory management pristine.
- **Alternatives considered**: `ChangeNotifier` holding the controllers. Rejected because `Cubit` provides better separation from Flutter's native UI elements.

## 2. Input Masking (CPF, Telephone)
- **Decision**: Integrate `mask_text_input_formatter` (if available) or implement manual RegEx formatting limiters.
- **Rationale**: `mask_text_input_formatter` is the industry standard in Flutter for dynamically masking inputs directly through the `inputFormatters` parameter in `TextFormField`. If third-party packages are restricted, simple Dart RegEx formatters can be built. We will use RegExp/masking internally in the `AppFormField`.
- **Alternatives considered**: `flutter_multi_formatter` (heavier, unnecessary if only CPF/Phone needed).

## 3. UI System Spacing
- **Decision**: Introduce `AppSpacing` enum with constants mapped to pixels.
- **Rationale**: Eliminates magic numbers like `SizedBox(height: 16)`.
- **Alternatives considered**: Raw constants (e.g., `AppSizes.md`). `AppSpacing` extension properties on `num` (`16.ph`) were rejected to keep standard Flutter patterns.

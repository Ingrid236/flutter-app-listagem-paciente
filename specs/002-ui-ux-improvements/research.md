# Research & Architecture Decisions (Phase 0)

## Design Decisions

1. **Global ThemeData Implementation**
   - **Decision:** Utilize Flutter's `ThemeData` to establish the primary schema via `colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)`. Use custom internal extensions or Material configurations to inject fonts if standard isn't enough, but native material typography serves well.
   - **Rationale:** Native support. Replaces all arbitrary colors gracefully inside UI elements defaulting to theme bounds.
   - **Alternatives considered:** Hardcoding colors. Rejected due to poor long-term maintainability.

2. **Web Responsiveness Center Lock**
   - **Decision:** Employ `Center` combined with `ConstrainedBox(constraints: BoxConstraints(maxWidth: 500))` wrapper for main inputs, particularly on screens like `LoginPage` aiming for cross-platform visual consistency. 
   - **Rationale:** Easy to implement, zero reliance on external layout libraries. Provides 100% adherence to FR-004 specification constraints. 
   - **Alternatives considered:** ResponsiveBuilder dependency. Rejected due to over-engineering for simple max bounds.

3. **Debug Banner Removal**
   - **Decision:** Change `debugShowCheckedModeBanner: false` on the root `MaterialApp` widget.
   - **Rationale:** Fulfills FR-005 directly. Does not affect test configurations natively.

4. **Reusable UI Components Architecture**
   - **Decision:** Extract distinct classes `AppButton`, `AppInput` and `AppCard` derived respectfully from `ElevatedButton`/`FilledButton`, `TextFormField`, and `Card`. 
   - **Rationale:** Strongly complies with Clean Code standard componentization and reduces boilerplate padding inside features.

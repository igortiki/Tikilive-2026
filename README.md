# Tikilive

A live TV client for iOS and tvOS, written in SwiftUI.

A rebuild of an app I originally shipped on iOS and tvOS, redone on current tooling to
keep the architecture explicit and the business logic testable outside the UI.

## Layout

```
Packages/TikiliveCore/   networking, models, view models, tests
Packages/TikiliveUI/     reusable views
App/Tikilive-iOS/        iOS app target
App/Tikilive-tvOS/       tvOS app target
```

The core is a Swift package with no UIKit or SwiftUI dependency, so the view models and the
networking layer are unit-tested without a host app. The two platform targets are thin.

## What's in it

- **Networking** — a small `APIClient` over `URLSession` with request signing, typed errors and
  decoding into domain models.
- **View models** — `@MainActor`, Swift 6 language mode, `Sendable` models across the boundary.
- **Dependency injection** — services are constructed in `AppDependencies` and injected into the
  view models; tests substitute mocks through the same initialisers.
- **Tests** — Swift Testing (`@Suite` / `@Test`), covering the signer, the decoders, and both view
  models including the failure paths.
- **Playback** — real HLS streams resolved per channel.

## Running it

`APIConfiguration` ships with placeholders:

```swift
static let tiki6 = APIConfiguration(baseStringURL: "...", apiID: "<your api id>", apiKey: "<your api key>")
```

Supply your own credentials to point it at a backend.

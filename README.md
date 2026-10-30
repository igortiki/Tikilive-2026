# TikiLive

SwiftUI live TV client for iOS and tvOS.

## Requirements

- Xcode 27
- [Homebrew](https://brew.sh)

## Run

```
make bootstrap   # install Mint and XcodeGen (once)
make project     # generate the Xcode project and open it
```

Pick the `Tikilive-iOS` or `Tikilive-tvOS` scheme and run.

## Commands

Run from the repository root:

| Command | Description |
|---------|-------------|
| `make help`          | List all commands |
| `make bootstrap`     | Install Mint and XcodeGen at the pinned versions |
| `make project`       | Generate the Xcode project and open it |
| `make build`         | Build the iOS app (Debug) |
| `make build-tvos`    | Build the tvOS app (Debug) |
| `make build-release` | Build the iOS app (Release) |
| `make clean`         | Remove the generated Xcode project |

The Xcode project is generated from `App/project.yml` — change settings there, then `make project`.

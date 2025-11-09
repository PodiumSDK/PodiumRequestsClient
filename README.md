# PodiumRequestsClient

A lightweight, async/await-based Swift client for interacting with the **Podium API**, built on top of **Alamofire**.  
It provides a simple, type-safe interface for fetching motorsport session data, race control messages, cars, drivers, and telemetry.

---

## Features

- ✅ Async/Await support for all requests  
- ✅ Strongly typed models using `Decodable`  
- ✅ Modular endpoints and mappers for easy extensibility  
- ✅ Built on top of [Alamofire](https://github.com/Alamofire/Alamofire)  
- ✅ Automatic JSON decoding using a custom `JSONDecoder.podium` configuration  
- ✅ Automatic mapping from domain models to clean Swift models

---

## Installation

### Swift Package Manager

You can add **PodiumRequestsClient** to your project using Swift Package Manager.

#### In Xcode
1. Go to **File ▸ Add Packages…**
2. Enter the repository URL:
   ```
   https://github.com/PodiumSDK/PodiumRequestsClient.git
   ```
3. Select **Up to Next Major Version** and add the package.

#### Manually, in your `Package.swift`

```swift
dependencies: [
    .package(url: "https://github.com/PodiumSDK/PodiumRequestsClient.git", from: "1.0.0")
]
```

Then import it:
```swift
import PodiumRequestsClient
```

## Usage

```swift
let client: RequestsClient = RequestsClient(
    baseURL: "<API_BASE_URL>",
    apiKey: "<API_KEY>"
)
```

---

## Documentation

You can find the full documentation for **PodiumRequestsClient** on the [DocC](https://podiumsdk.github.io/PodiumRequestsClient/).

## Architecture

- **PodiumRequestsClient** orchestrates requests and mapping, exposing clean async APIs.

The client only exposes models and not domain entities, to keep a clear separation of concerns.

---

## Requirements

| Platform | Minimum Version |
|-----------|-----------------|
| iOS       | 17.0            |
| visionOS  | 1.0             |
| macOS     | 14.0 |

| Dependency | Version |
|-------------|----------|
| Swift       | 5.9+|
| Alamofire   | 5.8+ |

---

## License

This project is licensed under the MIT License.  
See [LICENSE](LICENSE) for details.

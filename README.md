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

### Initialize the client

```swift
let client = PodiumRequestsClient(
    baseURL: "<API_BASE_URL>",
    apiKey: "<YOUR_API_KEY>"
)
```

---

### Fetch all sessions

```swift
let sessions = try await client.getAllSessions()
```

Returns an array of `SessionModel`.

---

### Fetch a specific session

```swift
let session = try await client.getSession(sessionKey: 1234)
```

---

### Fetch race control messages

```swift
let raceControl = try await client.getAllRaceControl(sessionKey: 1234)
```

---

### Fetch cars

```swift
let cars = try await client.getAllCars(sessionKey: 1234)
```

---

### Fetch car locations

```swift
let locations = try await client.getAllCarLocation(sessionKey: 1234, car: 16)
```

---

### Fetch car telemetry data

```swift
let data = try await client.getAllCarData(sessionKey: 1234, car: 16)
```

---

### Fetch drivers

```swift
let drivers = try await client.getAllDrivers(sessionKey: 1234)
```

or a specific one:

```swift
let driver = try await client.getDriver(sessionKey: 1234, driver: 44)
```

---

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

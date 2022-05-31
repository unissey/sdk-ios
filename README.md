_<p align="center">Unissey Confidential</p>_
![logo](https://user-images.githubusercontent.com/2079561/134871554-4682d336-60a0-48d1-9dd3-6e8330e6e013.png)

# Unissey iOS SDK

> Unissey's iOS Library

`UnisseySDK` is the iOS library that replicates Unissey's core javascript SDK to be used in Swift applications. The library can handle all data capture necessary to run Unissey's biometric algorithms and returns the result to the parent application.

1. [Installation](#1-installation)
2. [Getting Started](#2-getting-started)
3. [Reference](#3-reference)
4. [About](#4-about)

# 1. Installation

## Get a personnal access token

First generate an access token by following [this link](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line). Make sure to include at least the `repo` && `read:packages` permission to the access token.

Then, to get access permissions, you will need to contact someone from the Unissey organisation with your github account name.

## Authenticate on Xcode

> You can skip this step if you have already added your GitHub account to XCode.

Open XCode, go to preferences (`CMD + ,`), go to the second tab (accounts), add a new account (bottom left, the little `+`), select "GitHub" then add your GitHub account's email and the personnal access token you previously generated.

## Download the framework

You can download our framework using the Swift Package Manager. To do so, in Xcode, go to File -> Swift Packages -> Add Package Depency. Then add the following URL in the search bar and press enter: `https://github.com/unissey/sdk-ios`. Xcode will prompt you for a version, you can keep the default values and click next and then finish.

# 2. Getting Started

## Common installation

There are two main use cases to our SDK described below. One where the video is captured and sent back to you for your own processing and the other where the video is directly sent to our API.

> Note: If your app does not use a `NavigationView`, you must wrap the `DSWidgetView` in one for navigation between screens to work.

## 2.1 Video Capture Use Case

If you do not wish to send the video to the analysis API right away, you can simply pass a method to the `onVideoCapture` callback to receive the video captured by the SDK. In this case, the `apiParameters` input is not necessary.

> Note: Passing in valid api parameters as input will result in an API call, regardless of whether or not you define the `onVideoCapture` callback. And vice-versa, the `onVideoCapture` callback will be triggered even if the API is called.

```swift
import UnisseySDK
import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      VStack {
        DSWidgetView(
          onVideoCapture: { capture in
            // Do something with the captured video
            // Note: Do not forget to send `capture.metadata` to our
            // api along with `capture.video`
          }
        )
      }
    }
  }
}
```

## 2.2 Api Call Use Case

⚠️This use case is not recommended in production, for security reasons, and should be limited to POC / demo settings only. In production, API calls should be made from your backend only.

The SDK can make the call to our video analysis API automatically after capturing the video if you specify the appropriate parameters. If you need to capture an image for face comparison on top of the standard video liveness detection, you can pass `true` to the `captureReferenceImage` input.

```swift
import UnisseySDK
import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      VStack {
        DSWidgetView(
          apiSettings: ApiSettings(
            key: "YOUR_API_KEY",
            baseURL: "https://api-analyze.unissey.com/api/v2",
            gdprConsent: true
          ),
          onApiResponse: { response in
            // Do something with the results
          }
        )
      }
    }
  }
}
```

# 3. Reference

These are the inputs and outputs of the ds-widget component

| Property              | Type                       | Default           | Description                                                                                                                                                                                                                                  |
| --------------------- | -------------------------- | ----------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| onVideoCapture        | `(CaptureData) -> Void`    | `nil`             | Callback called with the video file and some meta-data required by our API.                                                                                                                                                                  |
| apiParameters         | `ApiParameters`            | `nil`             | API key and base URL, gdpr consent and optional reference image to make analyze API call. The SDK will not call an API if `nil`. You therefore need to provide a handler for video capture (`captureVideo`) if you do not set apiParameters. |
| onApiResponse         | `(WidgetResponse) -> Void` | `nil`             | Callback function which is called with the response of the API call if there is one and it is successful (not called for retries). Is not called if `apiParameters` is nil.                                                                  |
| themeColor            | `Color`                    | `Color("DSTeal")` | Primary colour used throughout the SDK's UI                                                                                                                                                                                                  |
| showExplanations      | `Bool`                     | `true`            | Set to `false` if you do not wish to show the explanation screen before the video capture.                                                                                                                                                   |

### Types

```swift
public struct ApiParameters {
  let key: String // Your Unissey API Key
  let baseURL: String // The base URL of the API (eg. https://test.api-analyze.unissey.com/api/v2)
  let gdprConsent: Bool // Indicates whether proper consent was given for Unissey to store the uploaded medias.
  let referenceImage: Data? // Image to be uploaded to the API for face comparison. Can be left to `nil` to not do face comparison or use the image captured by the SDK if `captureReferenceImage == true`
};

public struct CaptureData {
    let video: Data
    let metadata: CaptureMetadata // A [String: String] object that needs to be JSON stringified and sent to the API. This is done automatically by the SDK if `apiParameters` are set.
}

public enum VqcHint: Int32, Codable {
    case Mask = 100
    case Light = 200
}

public struct Confidence: Codable {
    public let level: ConfidenceLevel
}

public enum ConfidenceLevel: Int, Codable {
    case LowConfidence = 0
    case HighConfidence = 1
}

public struct WidgetResponse {
  public let status: String
  public let parentSessionId: String?
  public let finalResults: Results?
  public let errorMessage: String?
  public let warning: String?

  public struct Results: Codable {
    public let liveness: Liveness
    public let faceMatching: FaceMatch?
    public let sessionId: String
    public let bundleId: String?
    public let retriesRemaining: Int

    public struct Liveness: Codable {
      public let isGenuine: Bool
      public let probability: Float
      public let confidence: Confidence
      public let vqcHints: [VqcHint]?
    }

    public struct FaceMatch: Codable {
      public let match: Bool
      public let score: Float
      public let vqcHints: [VqcHint]?
      public let confidence: Confidence
    }
  }
}
```

# 4. About

## Versions

| Version | Date       | Description            |
| ------- | ---------- | ---------------------- |


<br />

## Support

`tech@unissey.com`

## License / Copyright

This SDK is distributed under Unissey's license agreement

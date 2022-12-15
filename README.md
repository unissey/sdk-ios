_<p align="center">Unissey Confidential</p>_
![logo](https://user-images.githubusercontent.com/2079561/134871554-4682d336-60a0-48d1-9dd3-6e8330e6e013.png)

# Unissey iOS SDK

> Unissey's iOS Library

`UnisseySDK` is the iOS library that basically handles video capture for Unissey API. 
It is distributed as a Swift Package and can easily be used in Swift applications. It supports iOS from iOS 13. The library handles all processing and capture required by Unissey's biometric web.

1. [Installation](#1-installation)
2. [Getting Started](#2-getting-started)
3. [Reference](#3-reference)
4. [About](#4-about)

# 1. Installation

## Get a personnal access token

First generate an access token by following [this link](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line). Make sure to include at least the `repo` && `read:packages` permission to the access token.

Then, to get access permissions, you will need to contact the Unissey team to provide your github account name.

## Authenticate on Xcode

> You can skip this step if you have already added your GitHub account to XCode.

Open XCode, go to preferences (`CMD + ,`), go to the second tab (accounts), add a new account (bottom left, the little `+`), select "GitHub" then add your GitHub account's email and the personnal access token you previously generated.

## Download the framework

You can download our framework using the Swift Package Manager. To do so, in Xcode, go to File -> Swift Packages -> Add Package Depency. Then add the following URL in the search bar and press enter: `https://github.com/unissey/sdk-ios`. Xcode will prompt you for a version, you can keep the default values and click next and then finish.

# 2. Getting Started

## Common installation

There are two main use cases to our SDK described below. One where the video is captured and sent back to you for your own processing and the other where the video is directly sent to our API (Note that this latest use case is reserved to Demo or POC application)

> Note: If your app does not use a `NavigationView`, you must wrap the `UnisseyView` in one for navigation between screens to work.

## 2.1 Video Capture Use Case

This is actually the recommended use case for production app. The captured video, and related metadata object, are just sent back to the app, that typically sends them to a backend that is responsible for calling Unissey Web API. To implement this use case, you simply pass a method to the `onVideoCapture` callback to receive the video (and metadata). You obviously don't provide `apiParameters` and `onApiResponse`.

> Note: Passing in valid api parameters as input will result in an API call, regardless of whether or not you define the `onVideoCapture` callback. And vice-versa, the `onVideoCapture` callback will be triggered even if the API is called.

```swift
import UnisseySDK
import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      VStack {
        StandAloneUnisseyView(
          onVideoCapture: { capture in
            print("\nReceived: \(capture)\n\n")
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

The SDK can make the call to Unissey analysis Web API automatically after capturing the video if you specify the appropriate parameters.

```swift
import UnisseySDK
import SwiftUI

struct ContentView: View {
  var refImage: UIImage?
  var body: some View {
    NavigationView {
      VStack {
        StandAloneUnisseyView(
          apiSettings: ApiSettings(
            key: "YOUR_API_KEY",
            baseURL: "https://api-analyze.unissey.com/api",
            gdprConsent: true,
            referenceImage: refImage?.jpegData(compressionQuality: 0.6)
          ),
          onApiResponse: { response in
            print("\nReceived: \(response)\n\n")
            // Do something with the results
          }
        )
      }
    }
  }
}
```
The above samples use `StandAloneUnisseyView`. It's the easier and quicker way to use Unissey SDK. But, if you need more controls, and especially if you have to interact with the underlying model , you can use `UnisseyView` with your own instance of `UnisseyViewModel`.


# 3. Reference

## 3.1 StandAloneUnisseyView
This View is the easier way to use the Unissey SDK. It's normally enough for most use cases.
See the samples above that demonstrate how to use it.

### constructor
```swift
public init(
        onVideoCapture: VideoCaptureCB? = nil,
        apiParameters: ApiParameters? = nil,
        onApiResponse: APIResponseCB? = nil,
        showExplanations: Bool = true,
        themeColor: Color = Color.uniColor("UniBlue")
    )

```

#### parameters

| Property              | Type                       | Default           | Description                                                                                                                                                                                                                                  |
| --------------------- | -------------------------- | ----------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| onVideoCapture        | `(CaptureData) -> Void`    | `nil`             | Callback called with the video file and some meta-data required by our API.                                                                                                                                                                  |
| apiParameters         | `ApiParameters`            | `nil`             | API key and base URL, gdpr consent and optional reference image to make analyze API call. The SDK will not call an API if `nil`. You therefore need to provide a handler for video capture (`captureVideo`) if you do not set apiParameters. |
| onApiResponse         | `(WidgetResponse) -> Void` | `nil`             | Callback function which is called with the response of the API call if there is one and it is successful (not called for retries). Is not called if `apiParameters` is nil.                                                                  |
| showExplanations      | `Bool`                     | `true`            | Set to `false` if you do not wish to show the explanation screen before the video capture. |
| themeColor            | `Color`                    | `Color("DSTeal")` | Primary colour used throughout the SDK's UI                            |

All the parameters are optional, but you cannot actually define none of them.
If `apiParameters` is defined, you certainly need to get the API response, and then, `onApiResponse`should be defined as well.
If `apiParameters` is not defined, you certainly need to get the video (and metadata), and then, `onVideoCapture`should be defined.

##### ApiParameters
```swift
public struct ApiParameters {
  let key: String // Your Unissey API Key
  let baseURL: String // The base URL of the API (eg. https://test.api-analyze.unissey.com/api/v2)
  let gdprConsent: Bool // Indicates whether proper consent was given for Unissey to store the uploaded medias.
  let referenceImage: Data? // Image to be uploaded to the API for face comparison. Can be left to `nil` to not do face comparison or use the image captured by the SDK if `captureReferenceImage == true`
};
```


#### callbacks

```swift
public typealias VideoCaptureCB = (CaptureData) -> Void

public struct CaptureData {
    let video: Data
    let metadata: CaptureMetadata // A [String: String] object that needs to be JSON stringified and sent to the API. This is done automatically by the SDK if `apiParameters` are set.
}

public typealias CaptureMetadata = [String: String]
```

```swift
public typealias APIResponseCB = (ApiResponse) -> Void


public struct APIesponse {
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
```

## 3.2 UnisseyViewModel
In some specific use cases, `StandAloneUnisseyView` is not enough. If you need more controls, and especially if you have to interact with the underlying model , you can use `UnisseyViewModel` in conjunction with `UnisseyView` (cf §3.3)
This allows to hide the 'start' button and trig capture programmatically.

### constructor

```swift
public init(apiParameters: ApiParameters? = nil,
                onVideoCapture: VideoCaptureCB? = nil,
                onApiResponse: APIResponseCB? = nil) 

```

#### parameters
`apiParameters`, `onVideoCapture`, `onApiResponse` : see table above (§ 3.1 : StandAloneUnisseyView)
Note that all these parameters can be set after construction with correponding properties.

#### properties

##### apiParameters
` var apiParameters: ApiParameters?`
default value : `nil`

##### onVideoCapture
` var onVideoCapture: VideoCaptureCB?`
default value : `nil`

##### onApiResponse
` var onApiResponse: APIResponseCB?`
default value : `nil`

##### unisseyViewModel.showStartButton
`var showStartButton:Bool = true`
Allows to hide the UnisseyView 'start' button  (`unisseyViewModel.showStartButton = False`). Can be used if you want to trig capture programmatically.
In this case, you would probably use `unisseyViewModel.cameraModel.cameraState` property and `unisseyViewModel.cameraModel.startCapture` method as well.

##### unisseyViewModel.cameraModel.cameraState
`var cameraState:CameraState`
The current camera status. Wether the capture is actually ready to be started. 
```
public enum CameraState: Int {
    case NotReady = 0
    case Ready = 1
}
```
typically used if you don't rely on the UnisseyView 'start' button (`unisseyViewModel.showStartButton = False`) and want to trig capture programmatically. 
When the state is `Ready`, `unisseyViewModel.cameraModel.startCapture()`is ready to be called.


#### methods
##### unisseyViewModel.cameraModel.startCapture
`func startCapture() -> Void`
This method allows to start the capture. This is typically used if you don't rely on the UnisseyView 'start' button, generally because you have disabled it (`unisseyViewModel.showStartButton = False`) and want to trig capture programmatically.


## 3.3 UnisseyView
This view is used in conjunction with your own instance of `UnisseyViewModel`, for the specific uses cases describes in §3.2 (*'UnisseyViewModel'*).

### constructor
```swift
public init(
        viewModel: UnisseyViewModel,
        showExplanations: Bool = true,
        themeColor: Color = Color.uniColor("UniBlue")
    )

```

#### parameters
##### viewModel
The `UnisseyViewModel`instance

##### showExplanations, themeColor
 : see corresponding parameter description in § 3.1 ('*StandAloneUnisseyView*')


## 3.4. Customization
All the resources can be customized and overriden by client application.
To do that you just have to define a localized string with the same identifier into your application bundle.
Similarly, you can customize Colors and Images by defining them into your application `Assets.xcassets`

# 4. About

## Versions

| Version | Date       | Description            |
| ------- | ---------- | ---------------------- |


<br />

## Support

`support@unissey.com`

## License / Copyright

This SDK is distributed under Unissey's license agreement

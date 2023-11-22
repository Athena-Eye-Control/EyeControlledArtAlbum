# Eye Controlled Art Album Slider

Slide through art pictures using just your eyes. Powered by [Athena SDK](https://athenasaas.io/).

![reader gif](https://github.com/YanyuChen98/AthenaPhotoSlider-test/img/slider-gif.gif)

The Athena Photo Slider is a demo app for a brand new photo viewing experience. The app makes use of the powerful [Athena SDK](https://athenasaas.io/) for touchless navigation.

With the [Athena SDK](https://athenasaas.io/), one can easily develop his own apps with eye control functionalities. Whether you're browsing a gallery or presenting a slideshow, move through your photos seamlessly using just your eyes.

## Features

* **Eye-Controlled Navigation**: Slide between pictures using just your eye gaze, offering a hands-free viewing experience.
* **Seamless Integration with Athena SDK**: Powered by [Athena SDK](https://athenasaas.io/), a simple and straightforward SDK that helps you building other apps with the same eye control features.
* **Privacy and Security**: No data is stored, uploaded, or shared. No signup or login required and you can still use it while internet is off.

## Requirements

This app works with [Xcode 14.3.0](https://developer.apple.com/download/all/?q=xcode), Swift 5.8 and supports iOS 14 and above.

You will have a smoother building experience if [Brew](https://brew.sh) is installed on your MacOS.

## Build Instructions

1. Install the latest [Xcode developer tools](https://developer.apple.com/xcode/downloads/) from Apple.
2. Install [Brew](https://brew.sh) from the official site.
3. Clone the repository:

   ```shell
   git clone [athena photo slider]
   ```
4. Open 'AthenaJoyStickDemo.xcodeproj' in the root folder with Xcode.
5. Make sure you use your own team and bundle identifier under the `Signing & Capabilities` tab here:

   <img src="https://athenasaas.io/images/getting-started-1.png">
6. Select the [destination](https://developer.apple.com/documentation/xcode/build-system?changes=_2) device you want to build on.
7. Turn on `Developer Mode` on your device in `Privacy & Security` settings if asked.
8. Start the app with `Cmd + R` or by pressing the `build and run` button.
9. Navigate to `Settings > General > Device Management` to trust this application if asked.

## How to Use

1. Launch the app.
2. Staring at the center of the picture until an eye emoji like this pops up:
   <img src="https://athenasaas.io/images/photoslider-1.PNG">
3. While the emoji is in the screen, look at the right or left edge of the picture. It will slide accordingly without touching the screen.
4. Repeat the 2nd and 3rd steps if you want to browse more.



## About AthenaSDK

AthenaSDK unlocks a powerful new tool for developers to build more accessible, immersive, and engaging user experiences. 

With AthenaSDK, you can easily develop new apps with contactless browsing experience, or integrate this new experience into your existing app.

### How to add the SDK in your existing project

1. Download and unzip the SDK from GitHub or our [official website](https://athenasaas.io/download) in the previous folder of your project.
2. Add 'AthenaML.framework' and 'AthenaSDK.xcframework' from the file you downloaded into `Frameworks, Libraries, and Embedded Content` under the `General` tab.
3. Under the `Build Settings` tab, click the `All` subtab, and find the `Search Paths` options, add `../` to the `Framework Search Paths` because the frameworks are in the previous folder of this project.
4. Initialize the SDK following the instructions in the next section.

### Initialization of the SDK

#### 1. Import Necessary Frameworks

Start by importing the required modules at the beginning of your ViewController.

```swift
import UIKit
import ARKit
import AthenaSDK
```

#### 2. Set Up Interface Instance and Outlet Variables

1. Declare and initialize the instance variable for the AthenaSDK:

   ```swift
   var athenaEyeControl: AthenaEyeControl!
   ```

2. In the 'Main' file, use `command+shift+l` to add objects to the storyboard by searching for 'ARKit', selecting 'ARKit SceneKit View', and dragging it to the 'Main' file storyboard.

3. To connect this view to the code, select the 'ARKit Scene View', click on the tab on the top right called `Show the connections inspector` (the rightmost tab). This view is required here to catch the eye gaze from the camera.

4. Open another tab to see both 'Main' file and 'ViewController' file on the screen like this:

   <img src="https://athenasaas.io/images/step-by-step-2.PNG">

5. Click and hold the `Referencing Outlets` option, drag it to a blank line under this line in 'ViewController'

   ```swift
   var athenaEyeControl: AthenaEyeControl!
   ```

   and name it as `sceneView`.

   If you are unable to create this variable, try to manually put

   ```swift
   @IBOutlet
   weak var sceneView: ARSCNView!
   ```

   under there and connect them.

#### 3. Configure in 'viewDidLoad'

Copy and paste the following lines into your `viewDidLoad` method:

```swift
// Observe app state to manage SDK's active status
NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)

// Initialize AthenaEyeControl with a scene view
athenaEyeControl = AthenaEyeControl(sceneView: sceneView, webView: nil)
// Set the delegate for AthenaEyeControl to get SDK callbacks
athenaEyeControl.delegate = self
// If you want to hide the sceneView, set it as hidden
sceneView.isHidden = true

// Disable Read-A-Line event detection if not required
athenaEyeControl.disableRALDetection(true)
// Define the number of stares required for an eye gesture initiation
athenaEyeControl.setGestureInitiationLevel(level: 1)

```

#### 4. Add App State Handlers

Ensure the SDK starts or pauses based on the app's active state:

``` swift
@objc func applicationDidBecomeActive() {
    athenaEyeControl.start()
}

@objc func applicationWillResignActive() {
    athenaEyeControl.pause()
}
```

#### 5. Implementing AthenaEyeControlDelegate

The `AthenaEyeControlDelegate` protocol encompasses several callback functions, allowing you to respond to specific eye detection and control events provided by the Athena SDK. By conforming to this protocol, you can handle these events and integrate them into your application logic.

``` swift
extension ViewController: AthenaEyeControlDelegate {

    // These functions are part of the AthenaEyeControlDelegate protocol.
    // They are called in response to specific events detected by the Athena SDK.
    // Replace the sample implementations below with your application-specific logic.

    // Triggered when the user looks at specific coordinates.
    // Parameters x, y, z: 3D coordinates of the gaze.
    // Parameter projected: 2D screen coordinates of the gaze.
    func didLookAt(x: CGFloat, y:CGFloat, z: CGFloat, projected: CGPoint) {
        print("\(x),\(y)")
    }

    // Notifies when a line-reading event occurs.
    // Use the readALine parameter to get info about the reading event.
    func readAline(_ readALine: ReadALineData) {
        if readALine.reading {
            print("reading")
        }
    }

    // Indicates if the SDK has detected a face.
    func faceAnchorDetected(detected: Bool) {
        print("face detected: \(detected)")
    }

    // Provides a report on the data rate.
    // Useful for gauging performance or troubleshooting.
    func dataRateReport(_ rate: Float) {
        print("data rate: \(rate)")
    }

    // Triggered when the user blinks.
    func eyeBlinked(blinked: Bool) {
        print("eye blinked: \(blinked)")
    }

    // Recognizes and responds to specific eye gestures.
    // The parameter represents gestures: 1 for looking down, 2 for looking up,
    // 3 for staring, 4 for looking left, 5 for looking right, and so forth.
    func eyeGesture(_ gesture: Int) {
        DispatchQueue.main.async { [self] in
            if(gesture == 1) { // look down
                print(1)
            } else if(gesture == 2){ //look up
                print(2)
            } else if(gesture == 3){ // staring
                print(3)
            } else if(gesture == 4){ // look left
                print(4)
            } else if(gesture == 5){ // look right
                print(5)
            } else { // other gestures
                print(6)
            }
        }
    }
}

```

#### 6. Run your App with AthenaSDK

Select the 'Info' file, add a property key called `Privacy - Camera Usage Description` with the value you want.

Now the SDK is ready to run. You can refer to the event handlers we provided below to define your own use of its functions.



## Contact

Whether you have a question about this app, the Athena SDK, or just want to provide some feedback, don't hesitate to reach out.

[Email](support@athenahandsfree.com)

[AthenaSDK](https://twitter.com/Athenahandsfree)

[Linkedin](https://www.linkedin.com/company/athenaeyecontrol/)

[Twitter](https://twitter.com/Athenahandsfree)

## Liscense

[Athena Photo Slider ](https://github.com/Athena-Eye-Control/AthenaSDK/tree/main/Samples/PhotoSlider)© 2023 by [Athena Accessible Technology Inc. ](https://athenahci.com/)is licensed under [CC BY-NC-ND 4.0 ![img](https://chooser-beta.creativecommons.org/img/cc-logo.f0ab4ebe.svg)![img](https://chooser-beta.creativecommons.org/img/cc-by.21b728bb.svg)](http://creativecommons.org/licenses/by-nc-nd/4.0/?ref=chooser-v1)

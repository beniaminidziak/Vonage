# Vonage Video Communicator

## Requirements

- **iOS:** 15.0+
- **Xcode:** 14.0+
- **Swift:** 5.9+
- **Account:** Vonage Developer Account

## Setup

### 1. Configure Credentials

Open `SceneDelegate.swift` and update the hardcoded credentials on lines 54-56

```swift
guard let session = OTSession(
    applicationId: "YOUR_APPLICATION_ID",
    sessionId: "YOUR_SESSION_ID",
    delegate: nil
) else { return }

let controller = VonageSessionController(
    session: session,
    token: "YOUR_TOKEN"
)
```

### 2. Build

1. Open `Vonage.xcodeproj` in Xcode
2. Please ensure to change development team in case you intend to build for physical device
3. Select your target device or simulator (iOS 15+)
4. Build and run (`Cmd+R`)
5. Tap "Join" to connect to the video session

## Features

### Core Functionality
- ✅ **Session Management:** Connect to Vonage Video sessions with proper state handling
- ✅ **Video Streaming:** Display both local camera feed and remote participant video streams
- ✅ **Audio/Video Controls:**
  - Mute/Unmute microphone
  - Enable/Disable camera
  - End call with clean disconnection
- ✅ **Permissions Handling:** Camera and microphone permission requests with Settings app integration
- ✅ **Error Handling** 
- ✅ **Connection States:** Visual feedback for all connection states

## Architecture

### Architectural Overview

The application follows a layered MVVM architecture with clear separation of concerns

### Project Structure

```
Vonage/
├── AppDelegate.swift                    
├── SceneDelegate.swift                  # Composition Root
├── Models/
│   ├── Connectivity.swift               
│   └── Preview.swift                    
├── Permissions API/
│   ├── PermissionsController.swift      
│   ├── AVPermissionsController.swift    # AVFoundation permission handling
│   └── Types/Media.swift                
├── Session API/
│   ├── SessionController.swift          
│   └── VonageSessionController.swift    # Session management implementation
├── Presentation/
│   ├── VideoViewModel.swift             # Video Call state & logic
│   └── PermissionsViewModel.swift       # Permission state & logic
├── UI/
│   ├── HomeView.swift                   # Entry screen UI
│   ├── PermissionsView.swift            # Permission request UI
│   ├── VideoView.swift                  # Main video call interface
│   ├── StreamView.swift                 # Remote video UI
│   ├── PreviewView.swift                # Local camera UI
│   ├── FarewellView.swift               # Disconnect confirmation
│   ├── FlexibleView.swift               # UIKit-SwiftUI bridge for OpenTok previews
│   └── ControllButtonStyle.swift       
└── Utilities/
    └── Safe.swift                       # Thread-safe dictionary
```

### Architectural Patterns / Decisions

**1. MVVM (Model-View-ViewModel)**

**2. Protocol-Based Dependency Injection**

**3. Composition Root**

**4. Hybrid UI Approach (SwiftUI + UIKit)**
- **Views:** SwiftUI for modern, declarative UI
- **Navigation:** UIKit for stable navigation stack management
- **Rationale:** iOS 15 target with pre-NavigationStack SwiftUI limitations

**6. Delegate Pattern Integration**

## Known Issues, Limitations & Improvements

### No Testing

### Lack of proxy layer for OpenTok framework
- Would encapsulate hard to test details in a single place
- Would decouple application from OpenTok framework details making it easier to replace in the future

### VideoViewModel
- Might be reduced to smaller, decoupled view models and composed - defered due to coupling between OpenTok framework components

### Logging

### Modularity
- Application might be split into smaller modules in order to optimize build times 

### Participant Video
- Participant video stream doens't update upon reconnecting to the call [From `FarewellView`], participant needs to either toggle their video or user needs to reenter session entirely

## Time Spent

**Approximate Total: 4 hours**

## Testing

### Manual Testing Checklist

- ✅ App launches successfully
- ✅ Permission requests displayed if user lacks permissions
- ✅ If application is unable to display permission request prompt user is redirected to settings
- ✅ Session connection establishes
- ✅ Local camera preview displays
- ✅ Remote stream displays when second participant joins
- ✅ Mute/Unmute toggles microphone
- ✅ Video enable/disable toggles camera
- ✅ End call disconnects cleanly
- ✅ Connection state transitions are smooth

**Built with ❤️ for the Vonage Team**

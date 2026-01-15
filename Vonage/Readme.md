# Vonage

## Requirements
- iOS 15.0+ 
- XCode 26.0
- Swift 5.9
- Vonage Developer Account

## Setup

## Features
- Permissions handling ✅
- Joining calls and handling connection states ✅
- Display remote participant video stream ✅
- Show the local camera feed ✅
- Mute/Unmute, Enable/Disable Video, End Call controlls ✅


## Architecture

### Architectural Patterns 
- Presentation: MVVM

## Decisions
- Due to iOS 15+ requirement I decided to use a mix of SwiftUI (Views) and UIKit (Navigation). Decision is influenced by low maturity of SwiftUI navigation before `NavigationStack` introduction

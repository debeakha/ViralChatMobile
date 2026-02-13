# ViralChat Mobile - iOS App

A native iOS chat app built with SwiftUI that connects to the ViralChat backend API.

## Features

- Sign in / Sign up / Join as Guest
- Real-time messaging across channels
- Beautiful dark theme UI
- Works with same backend as web app

## Tech Stack

- **SwiftUI** - UI Framework
- **Combine** - Async data handling
- **XcodeGen** - Project generation
- **APNs** - Push notifications (future)

## Architecture

```
ViralChatMobile/
├── App/
│   └── ViralChatMobileApp.swift
├── Models/
│   ├── Profile.swift
│   ├── Channel.swift
│   ├── Message.swift
│   └── Auth.swift
├── ViewModels/
│   ├── AuthViewModel.swift
│   ├── ChatViewModel.swift
│   └── ChannelViewModel.swift
├── Views/
│   ├── LandingView.swift
│   ├── AuthView.swift
│   ├── ChatView.swift
│   ├── ChannelListView.swift
│   └── Components/
│       ├── MessageBubble.swift
│       └── ChannelRow.swift
├── Services/
│   ├── APIClient.swift
│   └── AuthService.swift
├── Resources/
│   └── Assets.xcassets/
└── Info.plist
```

## Building

1. Generate Xcode project:
```bash
xcodegen generate
```

2. Open in Xcode and run on simulator

## API Configuration

Update `APIClient.swift` with your backend URL:
```swift
static let baseURL = "https://your-backend-url.com"
```

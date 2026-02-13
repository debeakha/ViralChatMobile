# ViralChat Mobile - iOS App

> **NOTE**: This mobile app shares the same backend as the web app (`v0-viral-chat-web-app`). See the "Backend Configuration" section below for details.

## Quick Start (For Resume)

To restart development quickly:

```bash
# 1. Start web app (terminal 1)
cd v0-viral-chat-web-app
npm run dev

# 2. Rebuild & launch mobile app (terminal 2)
cd ViralChatMobile
xcodebuild -project ViralChatMobile.xcodeproj -scheme ViralChatMobile -configuration Debug -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build
xcrun simctl boot "iPhone 17 Pro"
xcrun simctl install booted ~/Library/Developer/Xcode/DerivedData/ViralChatMobile-*/Build/Products/Debug-iphonesimulator/ViralChatMobile.app
xcrun simctl launch booted com.viralchat.mobile
```

> **Note**: Mobile app currently points to `http://localhost:3000` (local web app). For production, update `APIClient.swift` to use Vercel URL.

---

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

## Backend Configuration

This app connects to the web app's API, not directly to Supabase. Both mobile and web apps share the same backend:

| Service | URL/Account |
|---------|-------------|
| **Backend API** | `https://debeakha-v0-viral-chat-web-j1dwymidl-debeas-projects.vercel.app` |
| **Supabase** | Project: `wiwbkaqxiwrftkzpepvd` (https://wiwbkaqxiwrftkzpepvd.supabase.co) |
| **Vercel** | https://debeakha-v0-viral-chat-web-j1dwymidl-debeas-projects.vercel.app |
| **GitHub** | Account: `debeakha` |

> **Important**: The mobile app makes HTTP requests to the Vercel-deployed web app's API endpoints, which then communicate with Supabase. Both apps share the same database and authentication system.

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

# AGENTS.md — RoadHelper project memory

> Canonical context for any agent working on this repo. Keep this file current:
> when a decision changes or a phase completes, update the relevant section.

## What this is

**RoadHelper** is an iOS app that helps people stay safer on the road. It was the
author's submission for the **Swift Student Challenge 2026**. The
goal now is to turn it into a clean, well-documented **open-source** project.

Three pillars:
1. **Emergency guides** — step-by-step guides for road emergencies (PHTLS trauma
   protocol, CPR, vehicle fire, animal hit, moving a victim safely, flat tire,
   overheating, disabled vehicle, and maybe others).
2. **Emergency contacts** — Brazilian emergency numbers (190/191/192/193) plus
   user-added personal contacts (persisted with SwiftData).
3. **Attention Assistant** — a drowsiness detector for drivers. Monitors the
   eyes and alerts on signs of sleepiness, using two computer-vision backends:
   **Vision** ("Day" mode) and **ARKit** face tracking ("Night" mode).

## Format & platform

- **App Playground** (`.swiftpm`), not a normal Xcode project. The app target is
  declared in [`RoadHelper.swiftpm/Package.swift`](RoadHelper.swiftpm/Package.swift)
  via `.iOSApplication` (`AppleProductTypes`).
- **iOS 18+**, Swift 6 language mode.
- **Decision:** stay on `.swiftpm` for the open-source phase. Migrating to a
  normal Xcode project is the first step of the future. All code
  and localization work transfers without rework.

## Tech stack

SwiftUI · Vision (`VNDetectFaceLandmarksRequest`) · ARKit (`ARFaceAnchor`
blend shapes) · AVFoundation (camera capture, audio, speech synthesis) ·
SwiftData (`ContactModel`) · Liquid Glass on iOS 26 (with `borderedProminent`
fallback).

## Source map

```
RoadHelper.swiftpm/
  MyApp.swift                 # @main, TabView (Emergencies / Attention), modelContainer
  Package.swift               # app target, capabilities (camera, contacts)
  Model/
    Emergency.swift           # Emergency, URLLink
    EmergencyStep.swift       # EmergencyStep (data for one guide step)
    EmergencyManager.swift    # builds the emergency lists
    ContactModel.swift        # @Model ContactModel (SwiftData) + PrimaryContact
    EmergenciesSteps/         # hardcoded content for each guide (8 files)
  Views/
    TravelView.swift          # home: emergency lists + search + contacts card
    EmergencyView.swift       # renders a guide's steps
    EmergencyContactsView.swift
    CPRAnimationView.swift    # CPR rhythm metronome animation
    AttentionViews/           # Attention Assistant UI (View + Vision + ARKit + accessibility)
    Onboardings/              # initial + assistant onboarding
  EyeTracker/
    Vision/                   # CameraManager, EyeTrackerVision (EAR), CameraPreview
    ARKit/                    # ARFaceManager, ARCameraView
  AudioPlayerAttention.swift  # alarm sound + spoken "pull over" prompt
  Assets.xcassets/            # colors, images, sounds (alarmSound, beepSound)
  Resources/                  # beepSound.wav
```

## How it works (key flows)

- **Attention Assistant:** `CameraManager`/`ARFaceManager` feed eye state into an
  `EyeStatus` (`opened`/`closed`/`nofaceDetected`). The view runs a 0.1s timer
  that increments a `closedFramesCounter` while eyes are not open; at a threshold
  it plays an alarm, and on recovery it speaks a "pull over" prompt. Vision uses
  an **EAR (Eye Aspect Ratio)** threshold; ARKit uses a smoothed blink blend
  shape. An **Accessibility Mode** tracks a single chosen eye for users with
  amblyopia / eye patch / desync conditions.
- **Emergency guides:** `EmergencyManager` builds arrays of `Emergency`, each with
  `[EmergencyStep]`. `EmergencyView` renders steps with expand/collapse, warnings,
  call buttons, images, and cross-links between guides.

## Conventions

- Swift API design guidelines: types are `UpperCamelCase`, members
  `lowerCamelCase`.
- Code identifiers and comments in **English**. **User-facing content** is
  localized **pt-BR (primary) + en** (see roadmap).
- Models that are pure value data should be `struct`; `ContactModel` stays a
  SwiftData `@Model class`.
- No committed build artifacts or user state (see `.gitignore`).

## Build & verify

This is an App Playground — it does **not** build via `swift build`. Use Xcode,
Swift Playgrounds, or `xcodebuild`:

```sh
cd RoadHelper.swiftpm
xcodebuild -scheme RoadHelper \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' build
```

- **Night Mode (ARKit face tracking)** only works on a physical device with a
  **TrueDepth** camera — not in the simulator.
- Manual smoke test: navigate every emergency guide (incl. the Trauma→CPR
  cross-link), open Emergency Contacts, run the Attention Assistant in Day mode.

## Decisions log

- **Format:** keep `.swiftpm` now; migrate to Xcode project only for App Store.
- **Localization:** pt-BR primary + en; **UI first, emergency content after**.
- **License:** MIT.
- **App Store:** explicit future phase 2. Main review risks: medical content +
  drowsiness-while-driving claims → require disclaimers, privacy policy, and a
  privacy manifest (uses `UserDefaults`, a required-reason API).

## Roadmap

1. ✅ **Repo cleanup** — removed committed zip/`.DS_Store`/xcuserstate, expanded
   `.gitignore`, deleted dead placeholder views, standardized file headers,
   removed dead/commented code & debug prints.
2. ⏳ **Review the Attention tab flow & design** — rework the UX/visual design of
   the Attention tab in the TabBar.
3. **Review the EyeTracker implementation** — especially whether Night Mode
   really needs the TrueDepth camera (ARKit), and how the two backends compare
   (also revisit the EAR `0.12` / blink `0.55` thresholds, calibration, PERCLOS,
   false positives, and moving Vision off the main thread).
4. **Brainstorm new ideas** — explore new features / directions.
5. **Localize to pt-BR (UI)** — set pt-BR as the base language + en; UI strings
   first (emergency content after).
6. **Review the guides** — improve accuracy and possibly find better sources
   (with Claude's help).
7. **Finalize README + LICENSE (MIT).**

> General code refactors (models `class`→`struct`, consolidating the 6
> `EmergencyStep` inits, id-based navigation in `TravelView`, type renames like
> `eyeStatus`→`EyeStatus` / `navigationPath`→`EmergencyRoute`, bundle id rename)
> are tracked under **Known gotchas / tech debt** and folded into the relevant
> roadmap steps as they're touched.

## Known gotchas / tech debt

- `TravelView` navigation maps routes to `immediateEmergencies[0..4]` by index —
  fragile if the array is reordered (general refactor).
- `roadWeatherEmergencies` / `filteredRoadWeather` are dead plumbing for an
  unimplemented, empty "Road & Weather" category.
- Vision `EyeTrackerVision` runs `VNImageRequestHandler.perform` on the main
  thread (address during the EyeTracker review, roadmap step 3).
- `AttentionVisionView` and `AttentionARKitView` duplicate the drowsiness timer
  logic — candidate for extraction.
- The Vision EAR threshold (`0.12`) and ARKit blink threshold (`0.55`) are fixed
  constants; robustness to be revisited during the EyeTracker review (roadmap
  step 3).

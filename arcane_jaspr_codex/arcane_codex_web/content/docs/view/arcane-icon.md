---
title: ArcaneIcon
description: Complete wrapper for all 1,666 Lucide icons with semantic API
layout: docs
component: icon
---

# ArcaneIcon

A complete wrapper providing a clean, discoverable API for **all 1,666 Lucide icons**. Instead of using confusing raw constructors like `House()` or `Search()`, use intuitive method names with consistent sizing.

## Basic Usage

```dart
// Simple - uses default size (md = 20px)
ArcaneIcon.home()
ArcaneIcon.search()
ArcaneIcon.settings()

// With size
ArcaneIcon.home(size: IconSize.lg)
ArcaneIcon.search(size: IconSize.sm)
```

## IconSize Presets

| Size | Pixels | Usage |
|------|--------|-------|
| `IconSize.xs` | 12px | Tiny indicators, badges |
| `IconSize.sm` | 16px | Inline, compact UI, small buttons |
| `IconSize.md` | 20px | **Default** - most UI elements |
| `IconSize.lg` | 24px | Prominent icons, large buttons |
| `IconSize.xl` | 32px | Hero sections, feature highlights |
| `IconSize.xl2` | 48px | Large displays, marketing sections |

```dart
ArcaneIcon.star(size: IconSize.xs)   // 12px
ArcaneIcon.star(size: IconSize.sm)   // 16px
ArcaneIcon.star(size: IconSize.md)   // 20px (default)
ArcaneIcon.star(size: IconSize.lg)   // 24px
ArcaneIcon.star(size: IconSize.xl)   // 32px
ArcaneIcon.star(size: IconSize.xl2)  // 48px
```

## Aliases

Short aliases are available in `aliases.dart`:

```dart
AIcon.home()              // Same as ArcaneIcon.home()
AIcon.search(size: AIconSize.lg)
```

## Semantic Aliases

Intuitive names that map to Lucide icon names:

```dart
// Navigation
ArcaneIcon.home()      // -> house()
ArcaneIcon.close()     // -> x()
ArcaneIcon.back()      // -> arrowLeft()
ArcaneIcon.forward()   // -> arrowRight()

// Actions
ArcaneIcon.edit()      // -> pencil()
ArcaneIcon.delete()    // -> trash2()
ArcaneIcon.add()       // -> plus()
ArcaneIcon.confirm()   // -> check()
ArcaneIcon.cancel()    // -> x()

// Status
ArcaneIcon.success()   // -> circleCheck()
ArcaneIcon.error()     // -> circleX()
ArcaneIcon.warning()   // -> triangleAlert()
ArcaneIcon.help()      // -> circleQuestionMark()

// UI
ArcaneIcon.dropdown()  // -> chevronDown()
ArcaneIcon.expand()    // -> chevronDown()
ArcaneIcon.collapse()  // -> chevronUp()
ArcaneIcon.next()      // -> chevronRight()
ArcaneIcon.prev()      // -> chevronLeft()

// Layout
ArcaneIcon.grid()      // -> grid3x3()
ArcaneIcon.dashboard() // -> layoutDashboard()
ArcaneIcon.sidebar()   // -> panelLeft()

// Misc
ArcaneIcon.loading()   // -> loaderCircle()
ArcaneIcon.spinner()   // -> loaderCircle()
ArcaneIcon.refresh()   // -> refreshCw()
ArcaneIcon.sync()      // -> refreshCw()
ArcaneIcon.moreHorizontal() // -> ellipsis()
ArcaneIcon.moreVertical()   // -> ellipsisVertical()
ArcaneIcon.filter()    // -> funnel()
ArcaneIcon.sort()      // -> arrowUpDown()
```

## Icons with Dart Naming Conflicts

Some icons conflict with Dart reserved words and use a suffix:

```dart
ArcaneIcon.keyIcon()      // Key shape (key is reserved)
ArcaneIcon.mapIcon()      // Map (map is reserved)
ArcaneIcon.listIcon()     // List (list is reserved)
ArcaneIcon.factoryIcon()  // Factory building
ArcaneIcon.targetIcon()   // Crosshair target
ArcaneIcon.contrastIcon() // Contrast circle
ArcaneIcon.importIcon()   // Import arrow (import is reserved)
ArcaneIcon.switchIcon()   // Switch (switch is reserved)

// Semantic aliases also work for these:
ArcaneIcon.key()       // -> keyIcon()
ArcaneIcon.map()       // -> mapIcon()
ArcaneIcon.factory()   // -> factoryIcon()
ArcaneIcon.target()    // -> targetIcon()
ArcaneIcon.contrast()  // -> contrastIcon()
```

## Common Icons by Category

### Navigation & UI

```dart
ArcaneIcon.home()          // House/home
ArcaneIcon.house()         // House (actual Lucide name)
ArcaneIcon.search()        // Magnifying glass
ArcaneIcon.settings()      // Gear
ArcaneIcon.menu()          // Hamburger menu
ArcaneIcon.close()         // X mark
ArcaneIcon.x()             // X mark (actual Lucide name)
ArcaneIcon.plus()          // Plus sign
ArcaneIcon.minus()         // Minus sign
ArcaneIcon.check()         // Checkmark
ArcaneIcon.chevronDown()   // Chevron pointing down
ArcaneIcon.chevronUp()     // Chevron pointing up
ArcaneIcon.chevronLeft()   // Chevron pointing left
ArcaneIcon.chevronRight()  // Chevron pointing right
ArcaneIcon.arrowLeft()     // Arrow pointing left
ArcaneIcon.arrowRight()    // Arrow pointing right
ArcaneIcon.externalLink()  // External link arrow
```

### User & People

```dart
ArcaneIcon.user()          // Single user
ArcaneIcon.users()         // Multiple users
ArcaneIcon.userPlus()      // Add user
ArcaneIcon.userMinus()     // Remove user
ArcaneIcon.userCheck()     // User with check
ArcaneIcon.userX()         // User with X
ArcaneIcon.userCog()       // User settings
ArcaneIcon.circleUser()    // User in circle
ArcaneIcon.circleUserRound() // Rounded user avatar
```

### Files & Folders

```dart
ArcaneIcon.file()          // Document
ArcaneIcon.fileText()      // Document with lines
ArcaneIcon.filePlus()      // Add file
ArcaneIcon.fileCode()      // Code file
ArcaneIcon.fileJson()      // JSON file
ArcaneIcon.folder()        // Closed folder
ArcaneIcon.folderOpen()    // Open folder
ArcaneIcon.folderPlus()    // Add folder
ArcaneIcon.download()      // Download arrow
ArcaneIcon.upload()        // Upload arrow
```

### Actions & Editing

```dart
ArcaneIcon.edit()          // Pencil (alias)
ArcaneIcon.pencil()        // Pencil
ArcaneIcon.pencilLine()    // Pencil with line
ArcaneIcon.copy()          // Copy/duplicate
ArcaneIcon.clipboard()     // Clipboard
ArcaneIcon.clipboardCopy() // Clipboard with copy
ArcaneIcon.trash()         // Trash can
ArcaneIcon.trash2()        // Trash with lines
ArcaneIcon.save()          // Floppy disk
ArcaneIcon.refreshCw()     // Rotating arrows
ArcaneIcon.refresh()       // Refresh (alias)
ArcaneIcon.undo2()         // Undo arrow
ArcaneIcon.redo2()         // Redo arrow
```

### Communication & Alerts

```dart
ArcaneIcon.bell()          // Notification bell
ArcaneIcon.bellRing()      // Ringing bell
ArcaneIcon.bellOff()       // Muted bell
ArcaneIcon.mail()          // Envelope
ArcaneIcon.mailOpen()      // Open envelope
ArcaneIcon.messageSquare() // Chat bubble
ArcaneIcon.messageCircle() // Round chat bubble
ArcaneIcon.send()          // Paper plane
ArcaneIcon.info()          // Info circle
ArcaneIcon.triangleAlert() // Alert triangle
ArcaneIcon.circleAlert()   // Alert in circle
ArcaneIcon.circleCheck()   // Check in circle
ArcaneIcon.circleX()       // X in circle
```

### Media & Content

```dart
ArcaneIcon.image()         // Picture
ArcaneIcon.images()        // Multiple pictures
ArcaneIcon.video()         // Video camera
ArcaneIcon.music()         // Music note
ArcaneIcon.music2()        // Double music note
ArcaneIcon.play()          // Play button
ArcaneIcon.pause()         // Pause button
ArcaneIcon.square()        // Stop button
ArcaneIcon.skipForward()   // Skip forward
ArcaneIcon.skipBack()      // Skip back
ArcaneIcon.volume2()       // Volume
ArcaneIcon.volumeX()       // Muted
```

### Theme & Display

```dart
ArcaneIcon.sun()           // Sun (light mode)
ArcaneIcon.moon()          // Moon (dark mode)
ArcaneIcon.sunMoon()       // Sun and moon
ArcaneIcon.monitor()       // Desktop screen
ArcaneIcon.smartphone()    // Phone
ArcaneIcon.tablet()        // Tablet
ArcaneIcon.laptop()        // Laptop
ArcaneIcon.eye()           // Visible
ArcaneIcon.eyeOff()        // Hidden
```

### Data & Charts

```dart
ArcaneIcon.chartBar()      // Bar chart
ArcaneIcon.chartPie()      // Pie chart
ArcaneIcon.chartLine()     // Line chart
ArcaneIcon.chartArea()     // Area chart
ArcaneIcon.activity()      // Activity graph
ArcaneIcon.database()      // Database
ArcaneIcon.server()        // Server
ArcaneIcon.hardDrive()     // Hard drive
```

### Security & Auth

```dart
ArcaneIcon.lock()          // Locked padlock
ArcaneIcon.lockOpen()      // Unlocked padlock
ArcaneIcon.unlock()        // Unlock (alias)
ArcaneIcon.keyRound()      // Rounded key
ArcaneIcon.key()           // Key (alias -> keyIcon)
ArcaneIcon.shield()        // Shield
ArcaneIcon.shieldCheck()   // Shield with check
ArcaneIcon.shieldAlert()   // Shield with alert
ArcaneIcon.fingerprint()   // Fingerprint
```

### Time & Calendar

```dart
ArcaneIcon.clock()         // Clock face
ArcaneIcon.clock1() - clock12() // Specific times
ArcaneIcon.calendar()      // Calendar
ArcaneIcon.calendarDays()  // Calendar with days
ArcaneIcon.calendarPlus()  // Add to calendar
ArcaneIcon.alarmClock()    // Alarm clock
ArcaneIcon.timer()         // Timer/stopwatch
ArcaneIcon.hourglass()     // Hourglass
```

### Development & Code

```dart
ArcaneIcon.code()          // Code brackets
ArcaneIcon.code2()         // Alt code brackets
ArcaneIcon.codeXml()       // XML code
ArcaneIcon.terminal()      // Terminal window
ArcaneIcon.terminalSquare() // Terminal in square
ArcaneIcon.gitBranch()     // Git branch
ArcaneIcon.gitCommitHorizontal() // Git commit
ArcaneIcon.gitMerge()      // Git merge
ArcaneIcon.gitPullRequest() // Pull request
ArcaneIcon.bug()           // Bug
ArcaneIcon.bugOff()        // No bugs
```

### Layout & Grid

```dart
ArcaneIcon.grid3x3()       // 3x3 grid
ArcaneIcon.grid2x2()       // 2x2 grid
ArcaneIcon.layoutGrid()    // Layout grid
ArcaneIcon.layoutList()    // List layout
ArcaneIcon.layoutDashboard() // Dashboard layout
ArcaneIcon.columns3()      // Three columns
ArcaneIcon.rows3()         // Three rows
ArcaneIcon.maximize()      // Expand
ArcaneIcon.minimize()      // Shrink
ArcaneIcon.maximize2()     // Fullscreen
ArcaneIcon.minimize2()     // Exit fullscreen
```

### Misc

```dart
ArcaneIcon.ellipsis()       // Three dots horizontal
ArcaneIcon.ellipsisVertical() // Three dots vertical
ArcaneIcon.funnel()         // Funnel filter
ArcaneIcon.arrowUpDown()    // Sort arrows
ArcaneIcon.loader()         // Loading spinner
ArcaneIcon.loaderCircle()   // Circular loader
ArcaneIcon.zap()            // Lightning bolt
ArcaneIcon.globe()          // World globe
ArcaneIcon.mapPin()         // Location pin
ArcaneIcon.compass()        // Compass
ArcaneIcon.printer()        // Printer
ArcaneIcon.paperclip()      // Attachment
ArcaneIcon.tag()            // Tag label
ArcaneIcon.hash()           // Hash/pound
ArcaneIcon.atSign()         // @ symbol
ArcaneIcon.power()          // Power button
ArcaneIcon.logOut()         // Log out
ArcaneIcon.logIn()          // Log in
ArcaneIcon.gripVertical()   // Drag handle vertical
ArcaneIcon.gripHorizontal() // Drag handle horizontal
ArcaneIcon.sparkles()       // Sparkles/AI
ArcaneIcon.wand2()          // Magic wand
ArcaneIcon.rocket()         // Rocket
ArcaneIcon.flame()          // Fire
ArcaneIcon.heart()          // Heart
ArcaneIcon.star()           // Star
ArcaneIcon.trophy()         // Trophy
```

## Using with Components

```dart
// In buttons
ArcaneIconButton(
  icon: ArcaneIcon.settings(),
  onPressed: () => print('Settings'),
)

// In buttons with icons
ArcaneButton.primary(
  label: 'Save',
  icon: ArcaneIcon.save(),
  onPressed: () {},
)

// With trailing icon
ArcaneButton.secondary(
  label: 'Menu',
  trailing: ArcaneIcon.chevronDown(size: IconSize.sm),
  onPressed: () {},
)

// In navigation
ArcaneRow(
  gapSize: Gap.sm,
  children: [
    ArcaneIcon.home(size: IconSize.sm),
    ArcaneText('Dashboard'),
  ],
)

// In tree views
TreeNode(
  id: 'src',
  label: 'src',
  icon: ArcaneIcon.folder(),
  children: [
    TreeNode(id: 'main', label: 'main.dart', icon: ArcaneIcon.file()),
  ],
)
```

## Browse All 1,666 Icons

Visit [lucide.dev/icons](https://lucide.dev/icons) to browse the complete icon catalog.

All icons on that site are available through `ArcaneIcon` using camelCase method names:
- `arrow-up` -> `ArcaneIcon.arrowUp()`
- `file-text` -> `ArcaneIcon.fileText()`
- `git-branch` -> `ArcaneIcon.gitBranch()`

## Regenerating Icons

When jaspr_lucide updates with new icons, regenerate the wrapper:

```bash
dart tool/generate_icons.dart
```

This programmatically generates `lib/component/view/icon.dart` with all icons from the jaspr_lucide package.

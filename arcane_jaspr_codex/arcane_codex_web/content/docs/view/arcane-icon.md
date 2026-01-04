---
title: ArcaneIcon
description: Clean, semantic icon API wrapping 1500+ Lucide icons
layout: docs
component: icon
---

# ArcaneIcon

A wrapper class providing a clean, discoverable API for Lucide icons. Instead of using confusing raw constructors like `Home()` or `Search()`, use semantic method names.

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
| `IconSize.xs` | 12px | Tiny indicators |
| `IconSize.sm` | 16px | Inline, compact UI |
| `IconSize.md` | 20px | **Default** - most UI elements |
| `IconSize.lg` | 24px | Prominent icons, buttons |
| `IconSize.xl` | 32px | Hero sections, features |
| `IconSize.xl2` | 48px | Large displays |

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

## Available Icons

### Navigation & UI

```dart
ArcaneIcon.home()          // House/home
ArcaneIcon.search()        // Magnifying glass
ArcaneIcon.settings()      // Gear
ArcaneIcon.menu()          // Hamburger menu
ArcaneIcon.close()         // X mark
ArcaneIcon.x()             // X mark (alias)
ArcaneIcon.plus()          // Plus sign
ArcaneIcon.minus()         // Minus sign
ArcaneIcon.check()         // Checkmark
ArcaneIcon.chevronDown()   // Chevron pointing down
ArcaneIcon.chevronUp()     // Chevron pointing up
ArcaneIcon.chevronLeft()   // Chevron pointing left
ArcaneIcon.chevronRight()  // Chevron pointing right
ArcaneIcon.arrowLeft()     // Arrow pointing left
ArcaneIcon.arrowRight()    // Arrow pointing right
ArcaneIcon.arrowUp()       // Arrow pointing up
ArcaneIcon.arrowDown()     // Arrow pointing down
ArcaneIcon.externalLink()  // External link arrow
ArcaneIcon.link()          // Chain link
```

### User & People

```dart
ArcaneIcon.user()          // Single user
ArcaneIcon.users()         // Multiple users
ArcaneIcon.userPlus()      // Add user
ArcaneIcon.userMinus()     // Remove user
```

### Files & Folders

```dart
ArcaneIcon.file()          // Document
ArcaneIcon.fileText()      // Document with lines
ArcaneIcon.folder()        // Closed folder
ArcaneIcon.folderOpen()    // Open folder
ArcaneIcon.download()      // Download arrow
ArcaneIcon.upload()        // Upload arrow
```

### Actions & Editing

```dart
ArcaneIcon.edit()          // Pencil
ArcaneIcon.pencil()        // Pencil (alias)
ArcaneIcon.copy()          // Copy/duplicate
ArcaneIcon.trash()         // Trash can
ArcaneIcon.delete()        // Trash with X
ArcaneIcon.save()          // Floppy disk
ArcaneIcon.refresh()       // Rotating arrows
ArcaneIcon.undo()          // Undo arrow
ArcaneIcon.redo()          // Redo arrow
```

### Communication & Alerts

```dart
ArcaneIcon.bell()          // Notification bell
ArcaneIcon.mail()          // Envelope
ArcaneIcon.message()       // Chat bubble
ArcaneIcon.send()          // Paper plane
ArcaneIcon.info()          // Info circle
ArcaneIcon.warning()       // Alert triangle
ArcaneIcon.alertCircle()   // Alert in circle
ArcaneIcon.help()          // Question mark
```

### Media & Content

```dart
ArcaneIcon.image()         // Picture
ArcaneIcon.video()         // Video camera
ArcaneIcon.music()         // Music note
ArcaneIcon.play()          // Play button
ArcaneIcon.pause()         // Pause button
ArcaneIcon.stop()          // Stop button
```

### Social & Feedback

```dart
ArcaneIcon.heart()         // Heart
ArcaneIcon.star()          // Star
ArcaneIcon.thumbsUp()      // Thumbs up
ArcaneIcon.thumbsDown()    // Thumbs down
ArcaneIcon.share()         // Share arrow
ArcaneIcon.bookmark()      // Bookmark flag
```

### Theme & Display

```dart
ArcaneIcon.sun()           // Sun (light mode)
ArcaneIcon.moon()          // Moon (dark mode)
ArcaneIcon.monitor()       // Desktop screen
ArcaneIcon.smartphone()    // Phone
ArcaneIcon.tablet()        // Tablet
ArcaneIcon.eye()           // Visible
ArcaneIcon.eyeOff()        // Hidden
```

### Data & Charts

```dart
ArcaneIcon.chart()         // Bar chart
ArcaneIcon.pieChart()      // Pie chart
ArcaneIcon.lineChart()     // Line chart
ArcaneIcon.activity()      // Activity graph
ArcaneIcon.database()      // Database
```

### Security & Auth

```dart
ArcaneIcon.lock()          // Locked padlock
ArcaneIcon.unlock()        // Unlocked padlock
ArcaneIcon.key()           // Key (rounded)
ArcaneIcon.shield()        // Shield
ArcaneIcon.shieldCheck()   // Shield with check
```

### Time & Calendar

```dart
ArcaneIcon.clock()         // Clock face
ArcaneIcon.calendar()      // Calendar
ArcaneIcon.alarm()         // Alarm clock
ArcaneIcon.timer()         // Timer/stopwatch
```

### Commerce & Money

```dart
ArcaneIcon.cart()          // Shopping cart
ArcaneIcon.bag()           // Shopping bag
ArcaneIcon.creditCard()    // Credit card
ArcaneIcon.dollar()        // Dollar sign
```

### Development & Code

```dart
ArcaneIcon.code()          // Code brackets
ArcaneIcon.terminal()      // Terminal window
ArcaneIcon.gitBranch()     // Git branch
ArcaneIcon.gitCommit()     // Git commit
ArcaneIcon.bug()           // Bug
```

### Layout & Grid

```dart
ArcaneIcon.grid()          // 3x3 grid
ArcaneIcon.list()          // List layout
ArcaneIcon.columns()       // Column layout
ArcaneIcon.rows()          // Row layout
ArcaneIcon.maximize()      // Expand
ArcaneIcon.minimize()      // Shrink
```

### Previously Hidden Icons

These icons had Dart naming conflicts but are accessible via the wrapper:

```dart
ArcaneIcon.factory()       // Factory building
ArcaneIcon.target()        // Crosshair target
ArcaneIcon.keyIcon()       // Key shape
ArcaneIcon.listIcon()      // List icon
ArcaneIcon.timer()         // Timer
ArcaneIcon.view()          // View/eye alternate
ArcaneIcon.map()           // Map
ArcaneIcon.importIcon()    // Import arrow
ArcaneIcon.contrast()      // Contrast circle
ArcaneIcon.radius()        // Radius indicator
ArcaneIcon.spellCheck()    // Spell check
ArcaneIcon.textWrap()      // Text wrap
```

### Misc

```dart
ArcaneIcon.moreHorizontal() // Three dots horizontal
ArcaneIcon.moreVertical()   // Three dots vertical
ArcaneIcon.filter()         // Funnel filter
ArcaneIcon.sort()           // Sort arrows
ArcaneIcon.loader()         // Loading spinner
ArcaneIcon.zap()            // Lightning bolt
ArcaneIcon.globe()          // World globe
ArcaneIcon.mapPin()         // Location pin
ArcaneIcon.compass()        // Compass
ArcaneIcon.printer()        // Printer
ArcaneIcon.attachment()     // Paperclip
ArcaneIcon.tag()            // Tag label
ArcaneIcon.hash()           // Hash/pound
ArcaneIcon.at()             // @ symbol
ArcaneIcon.power()          // Power button
ArcaneIcon.logOut()         // Log out
ArcaneIcon.logIn()          // Log in
ArcaneIcon.gripVertical()   // Drag handle vertical
ArcaneIcon.gripHorizontal() // Drag handle horizontal
```

## Using with Components

```dart
// In buttons
ArcaneIconButton(
  icon: ArcaneIcon.settings(),
  onPressed: () => print('Settings'),
)

// In navigation
ArcaneSidebarItem(
  icon: ArcaneIcon.home(),
  label: 'Dashboard',
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

## Raw Lucide Icons

For icons not wrapped by `ArcaneIcon`, use jaspr_lucide directly:

```dart
// These are re-exported from arcane_jaspr
Github()
Twitter()
Linkedin()
ChevronDown()

// With sizing
Github(width: Unit.pixels(24), height: Unit.pixels(24))
```

## Browse All Icons

Visit [lucide.dev/icons](https://lucide.dev/icons) to browse all 1500+ available icons.

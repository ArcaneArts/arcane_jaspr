---
title: ArcaneChatScreen
description: Full-featured chat interface screen
layout: docs
component: chat-screen
---

# ArcaneChatScreen

A full-featured chat screen component with message display, input, and conversation management.

## Basic Usage

```dart
ArcaneChatScreen(
  provider: chatProvider,
  currentUserId: 'user123',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `provider` | `ChatProvider` | required | Chat data provider |
| `currentUserId` | `String` | required | Current user's ID |
| `style` | `ChatStyle` | `bubbles` | Message display style |
| `onSendMessage` | `ValueChanged<String>?` | `null` | Send message handler |
| `showAvatar` | `bool` | `true` | Show user avatars |
| `showTimestamp` | `bool` | `true` | Show message timestamps |
| `placeholder` | `String` | `'Type a message...'` | Input placeholder |

## ChatStyle Options

- `bubbles` - Chat bubble style (default)
- `tiles` - Tile/card style messages

## Bubble Style

```dart
ArcaneChatScreen(
  provider: chatProvider,
  currentUserId: userId,
  style: ChatStyle.bubbles,
)
```

## Tile Style

```dart
ArcaneChatScreen(
  provider: chatProvider,
  currentUserId: userId,
  style: ChatStyle.tiles,
)
```

## Without Avatars

```dart
ArcaneChatScreen(
  provider: chatProvider,
  currentUserId: userId,
  showAvatar: false,
)
```

## Without Timestamps

```dart
ArcaneChatScreen(
  provider: chatProvider,
  currentUserId: userId,
  showTimestamp: false,
)
```

## ChatProvider Interface

```dart
abstract class ChatProvider {
  Stream<List<ChatMessage>> get messages;
  Future<void> sendMessage(String content);
  Future<void> loadMore();
}

class ChatMessage {
  final String id;
  final String senderId;
  final String senderName;
  final String? senderAvatar;
  final String content;
  final DateTime timestamp;
  final bool isRead;
}
```

## Examples

### Basic Chat Implementation

```dart
class MyChatProvider implements ChatProvider {
  final _controller = StreamController<List<ChatMessage>>.broadcast();
  final List<ChatMessage> _messages = [];

  @override
  Stream<List<ChatMessage>> get messages => _controller.stream;

  @override
  Future<void> sendMessage(String content) async {
    _messages.add(ChatMessage(
      id: DateTime.now().toString(),
      senderId: 'user123',
      senderName: 'Me',
      content: content,
      timestamp: DateTime.now(),
    ));
    _controller.add(_messages);
  }

  @override
  Future<void> loadMore() async {
    // Load older messages
  }
}
```

### Chat Screen in App

```dart
ArcaneScreen(
  header: ArcaneBar(
    titleText: 'Chat with Support',
    trailing: [
      ArcaneIconButton(
        icon: ArcaneText('⋮'),
        onPressed: () => showOptions(),
      ),
    ],
  ),
  child: ArcaneChatScreen(
    provider: supportChatProvider,
    currentUserId: currentUser.id,
    style: ChatStyle.bubbles,
    onSendMessage: (message) {
      analytics.trackMessage();
    },
  ),
)
```

### Group Chat

```dart
ArcaneChatScreen(
  provider: groupChatProvider,
  currentUserId: userId,
  showAvatar: true,  // Show avatars for group identification
  showTimestamp: true,
  placeholder: 'Message #general...',
)
```

## Related Components

- [ArcaneScreen](/arcane_jaspr/docs/screens/arcane-screen) - Screen wrapper
- [ArcaneTextInput](/arcane_jaspr/docs/inputs/arcane-text-input) - Text input
- [ArcaneAvatar](/arcane_jaspr/docs/view/arcane-avatar) - User avatars

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../util/tokens/tokens.dart';
import '../view/avatar.dart';

/// Chat style variant
enum ChatStyle {
  /// Message bubbles (WhatsApp-style)
  bubbles,

  /// List tiles (Slack-style)
  tiles,
}

/// Abstract message interface
abstract class AbstractChatMessage {
  /// Unique message ID
  String get id;

  /// Message content widget
  Component get messageWidget;

  /// Timestamp
  DateTime get timestamp;

  /// Sender ID
  String get senderId;
}

/// Abstract user interface
abstract class AbstractChatUser {
  /// Unique user ID
  String get id;

  /// Display name
  String get name;

  /// Avatar widget
  Component get avatar;
}

/// Chat provider interface
abstract class ChatProvider<M extends AbstractChatMessage, U extends AbstractChatUser> {
  /// Stream of messages
  Stream<List<M>> streamLastMessages();

  /// Get user by ID
  Future<U> getUser(String id);

  /// Send a message
  Future<void> sendMessage(String text);
}

/// Chat screen component
///
/// ```dart
/// ArcaneChatScreen(
///   style: ChatStyle.bubbles,
///   provider: myChatProvider,
///   currentUserId: 'user123',
/// )
/// ```
class ArcaneChatScreen<M extends AbstractChatMessage, U extends AbstractChatUser>
    extends StatefulComponent {
  /// Chat style variant
  final ChatStyle style;

  /// Chat data provider
  final ChatProvider<M, U> provider;

  /// Current user's ID (to determine message alignment)
  final String currentUserId;

  /// Optional header widget
  final Component? header;

  /// Whether to show the input field
  final bool showInput;

  /// Input placeholder
  final String inputPlaceholder;

  /// Whether to show timestamps
  final bool showTimestamps;

  /// Whether to show avatars
  final bool showAvatars;

  /// Custom send button
  final Component? sendButton;

  /// Whether to use gutter (edge padding)
  final bool gutter;

  const ArcaneChatScreen({
    required this.provider,
    required this.currentUserId,
    this.style = ChatStyle.bubbles,
    this.header,
    this.showInput = true,
    this.inputPlaceholder = 'Type a message...',
    this.showTimestamps = true,
    this.showAvatars = true,
    this.sendButton,
    this.gutter = true,
    super.key,
  });

  @override
  State<ArcaneChatScreen<M, U>> createState() => _ChatScreenState<M, U>();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-chat-input:focus').styles(raw: {
      'border-color': ArcaneColors.accent,
      'box-shadow': '0 0 0 2px ${ArcaneColors.accentContainer}',
    }),
    css('.arcane-chat-send:hover').styles(raw: {
      'background': ArcaneColors.accentHover,
    }),
  ];
}

class _ChatScreenState<M extends AbstractChatMessage, U extends AbstractChatUser>
    extends State<ArcaneChatScreen<M, U>> {
  List<M> _messages = [];
  String _inputValue = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    // In a real implementation, this would use StreamBuilder
    // For now, we'll just get the first batch
    await for (final messages in component.provider.streamLastMessages()) {
      setState(() {
        _messages = messages;
        _loading = false;
      });
      break; // Just get initial messages
    }
  }

  Future<void> _sendMessage() async {
    if (_inputValue.trim().isEmpty) return;
    await component.provider.sendMessage(_inputValue);
    setState(() => _inputValue = '');
    _loadMessages(); // Refresh messages
  }

  String _formatTimestamp(DateTime timestamp) {
    final hour = timestamp.hour > 12 ? timestamp.hour - 12 : timestamp.hour;
    final period = timestamp.hour >= 12 ? 'PM' : 'AM';
    return '${hour == 0 ? 12 : hour}:${timestamp.minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-chat-screen arcane-chat-${component.style.name}',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'height': '100%',
        'background': ArcaneColors.background,
      }),
      [
        // Header
        if (component.header != null) component.header!,

        // Messages area
        div(
          classes: 'arcane-chat-messages',
          styles: Styles(raw: {
            'flex': '1',
            'overflow-y': 'auto',
            'padding': component.gutter ? ArcaneSpacing.md : '0',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': ArcaneSpacing.sm,
          }),
          [
            if (_loading)
              div(
                styles: const Styles(raw: {
                  'display': 'flex',
                  'justify-content': 'center',
                  'padding': ArcaneSpacing.xl,
                  'color': ArcaneColors.muted,
                }),
                [text('Loading messages...')],
              )
            else if (_messages.isEmpty)
              div(
                styles: const Styles(raw: {
                  'display': 'flex',
                  'justify-content': 'center',
                  'padding': ArcaneSpacing.xl,
                  'color': ArcaneColors.muted,
                }),
                [text('No messages yet')],
              )
            else
              for (final message in _messages)
                _buildMessage(message),
          ],
        ),

        // Input area
        if (component.showInput)
          div(
            classes: 'arcane-chat-input-area',
            styles: const Styles(raw: {
              'padding': ArcaneSpacing.md,
              'border-top': '1px solid ${ArcaneColors.border}',
              'background': ArcaneColors.surface,
            }),
            [
              div(
                styles: const Styles(raw: {
                  'display': 'flex',
                  'gap': ArcaneSpacing.sm,
                  'align-items': 'flex-end',
                }),
                [
                  // Text input
                  textarea(
                    classes: 'arcane-chat-input',
                    attributes: {
                      'placeholder': component.inputPlaceholder,
                      'rows': '1',
                    },
                    styles: const Styles(raw: {
                      'flex': '1',
                      'padding': '10px ${ArcaneSpacing.sm}',
                      'border': '1px solid ${ArcaneColors.border}',
                      'border-radius': ArcaneRadius.lg,
                      'background': ArcaneColors.background,
                      'color': ArcaneColors.onSurface,
                      'font-size': ArcaneTypography.fontSm,
                      'font-family': 'inherit',
                      'resize': 'none',
                      'outline': 'none',
                      'min-height': '40px',
                      'max-height': '120px',
                    }),
                    events: {
                      'input': (event) {
                        final dynamic target = event.target;
                        if (target != null) {
                          setState(() => _inputValue = target.value ?? '');
                        }
                      },
                      'keydown': (event) {
                        final dynamic e = event;
                        if (e.key == 'Enter' && !e.shiftKey) {
                          e.preventDefault();
                          _sendMessage();
                        }
                      },
                    },
                    [text(_inputValue)],
                  ),

                  // Send button
                  component.sendButton ??
                      button(
                        type: ButtonType.button,
                        classes: 'arcane-chat-send',
                        styles: const Styles(raw: {
                          'width': '40px',
                          'height': '40px',
                          'border': 'none',
                          'border-radius': ArcaneRadius.full,
                          'background': ArcaneColors.accent,
                          'color': ArcaneColors.accentForeground,
                          'cursor': 'pointer',
                          'display': 'flex',
                          'align-items': 'center',
                          'justify-content': 'center',
                          'font-size': ArcaneTypography.fontLg,
                          'transition': ArcaneEffects.transitionFast,
                        }),
                        events: {
                          'click': (_) => _sendMessage(),
                        },
                        [text('➤')],
                      ),
                ],
              ),
            ],
          ),
      ],
    );
  }

  Component _buildMessage(M message) {
    final isCurrentUser = message.senderId == component.currentUserId;

    return component.style == ChatStyle.bubbles
        ? _buildBubbleMessage(message, isCurrentUser)
        : _buildTileMessage(message, isCurrentUser);
  }

  Component _buildBubbleMessage(M message, bool isCurrentUser) {
    return div(
      classes: 'arcane-chat-message ${isCurrentUser ? 'sent' : 'received'}',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': isCurrentUser ? 'row-reverse' : 'row',
        'align-items': 'flex-end',
        'gap': ArcaneSpacing.sm,
      }),
      [
        // Avatar (for received messages)
        if (component.showAvatars && !isCurrentUser)
          const ArcaneAvatar(
            initials: '?', // Would use actual user initials
            size: AvatarSize.sm,
          ),

        // Bubble
        div(
          styles: Styles(raw: {
            'max-width': '70%',
            'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
            'border-radius': isCurrentUser
                ? '${ArcaneRadius.lg} ${ArcaneRadius.lg} ${ArcaneRadius.sm} ${ArcaneRadius.lg}'
                : '${ArcaneRadius.lg} ${ArcaneRadius.lg} ${ArcaneRadius.lg} ${ArcaneRadius.sm}',
            'background': isCurrentUser
                ? ArcaneColors.accent
                : ArcaneColors.surfaceVariant,
            'color': isCurrentUser
                ? ArcaneColors.accentForeground
                : ArcaneColors.onSurface,
          }),
          [
            message.messageWidget,
            if (component.showTimestamps)
              div(
                styles: Styles(raw: {
                  'font-size': ArcaneTypography.fontXs,
                  'opacity': '0.7',
                  'margin-top': ArcaneSpacing.xs,
                  'text-align': isCurrentUser ? 'right' : 'left',
                }),
                [text(_formatTimestamp(message.timestamp))],
              ),
          ],
        ),
      ],
    );
  }

  Component _buildTileMessage(M message, bool isCurrentUser) {
    return div(
      classes: 'arcane-chat-tile',
      styles: const Styles(raw: {
        'display': 'flex',
        'gap': ArcaneSpacing.sm,
        'padding': ArcaneSpacing.sm,
        'border-radius': ArcaneRadius.md,
      }),
      [
        // Avatar
        if (component.showAvatars)
          const ArcaneAvatar(
            initials: '?', // Would use actual user initials
            size: AvatarSize.sm,
          ),

        // Content
        div(
          styles: const Styles(raw: {
            'flex': '1',
            'min-width': '0',
          }),
          [
            // Header (name + timestamp)
            div(
              styles: const Styles(raw: {
                'display': 'flex',
                'align-items': 'baseline',
                'gap': ArcaneSpacing.sm,
                'margin-bottom': ArcaneSpacing.xs,
              }),
              [
                span(
                  styles: const Styles(raw: {
                    'font-weight': ArcaneTypography.weightMedium,
                    'color': ArcaneColors.onSurface,
                    'font-size': ArcaneTypography.fontSm,
                  }),
                  [text(isCurrentUser ? 'You' : 'User')],
                ),
                if (component.showTimestamps)
                  span(
                    styles: const Styles(raw: {
                      'font-size': ArcaneTypography.fontXs,
                      'color': ArcaneColors.muted,
                    }),
                    [text(_formatTimestamp(message.timestamp))],
                  ),
              ],
            ),

            // Message content
            message.messageWidget,
          ],
        ),
      ],
    );
  }
}

/// Simple chat message implementation
class SimpleChatMessage implements AbstractChatMessage {
  @override
  final String id;

  final String content;

  @override
  final DateTime timestamp;

  @override
  final String senderId;

  const SimpleChatMessage({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.senderId,
  });

  @override
  Component get messageWidget => text(content);
}

/// Simple chat user implementation
class SimpleChatUser implements AbstractChatUser {
  @override
  final String id;

  @override
  final String name;

  final String? imageUrl;
  final String? initials;

  const SimpleChatUser({
    required this.id,
    required this.name,
    this.imageUrl,
    this.initials,
  });

  @override
  Component get avatar => ArcaneAvatar(
        imageUrl: imageUrl,
        initials: initials ?? name.substring(0, 2).toUpperCase(),
        size: AvatarSize.sm,
      );
}
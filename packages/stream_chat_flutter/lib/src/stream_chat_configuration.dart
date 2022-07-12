import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

/// {@template streamChatConfigurationProvider}
/// Inherited widget providing the [StreamChatConfiguration] to the widget tree
/// {@endtemplate}
class StreamChatConfigurationProvider extends InheritedWidget {
  /// {@macro streamChatConfigurationProvider}
  const StreamChatConfigurationProvider({
    super.key,
    required this.data,
    required super.child,
  });

  /// {@macro streamChatConfiguration}
  final StreamChatConfiguration data;

  @override
  bool updateShouldNotify(StreamChatConfigurationProvider oldWidget) =>
      data != oldWidget.data;

  /// Use this method to get the current [StreamChatThemeData] instance
  static StreamChatConfiguration of(BuildContext context) {
    final streamChatConfiguration = context
        .dependOnInheritedWidgetOfExactType<StreamChatConfigurationProvider>();

    assert(
      streamChatConfiguration != null,
      '''
You must have a StreamChatConfigurationProvider widget at the top of your widget tree''',
    );

    return streamChatConfiguration!.data;
  }
}

/// {@template streamChatConfiguration}
/// Provides global, user-configurable, non-theme related configuration
/// options to Flutter applications that use Stream Chat.
///
/// In order to set these configuration options, you must pass an instance of
/// this class to the [StreamChat] widget, or wrap a subtree using
/// the [StreamChatConfigurationProvider] inherited widget.
///
/// If you need to access the configuration directly at a later point in your
/// application, you can use the [StreamChatConfigurationProvider.of] method
/// to retrieve it.
///
/// If no [StreamChatConfiguration] is provided, the
/// [StreamChatConfiguration.defaults] factory constructor is used to provide a
/// default configuration.
///
/// If you want to keep some of the default values, but not others, you can use
/// the [StreamChatConfiguration.copyWith] method to override the values in
/// question.
///
/// Example 1:
/// ```dart
/// class MyApp extends StatelessWidget {
///   const MyApp({
///     required this.client,
///   });
///
///   final StreamChatClient client;
///
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       home: Container(
///         child: StreamChat(
///           client: client,
///           // No configuration provided, so the defaults are used.
///           child: ChannelListPage(),
///         ),
///       ),
///     );
///   }
/// }
/// ```
///
/// Example 2:
/// ```dart
/// class MyApp extends StatelessWidget {
///   const MyApp({
///     required this.client,
///   });
///
///   final StreamChatClient client;
///
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       home: Container(
///         child: StreamChat(
///           client: client,
///           config: StreamChatConfiguration.defaults().copyWith(
///             // Override a specific default value here
///           ),
///           child: ChannelListPage(),
///         ),
///       ),
///     );
///   }
/// }
/// ```
/// {@endtemplate}
class StreamChatConfiguration {
  /// {@macro streamChatConfiguration}
  const StreamChatConfiguration({
    this.defaultUserImage,
    this.placeholderUserImage,
    this.reactionIcons,
    this.enforceUniqueReactions,
  });

  /// Provides default configuration options
  factory StreamChatConfiguration.defaults() {
    return StreamChatConfiguration(
      defaultUserImage: (context, user) => Center(
        child: StreamGradientAvatar(
          name: user.name,
          userId: user.id,
        ),
      ),
      reactionIcons: _defaultReactionIcons,
      enforceUniqueReactions: true,
    );
  }

  /// Copies the configuration options from one [StreamChatConfiguration] to
  /// another.
  StreamChatConfiguration copyWith({
    Widget Function(BuildContext, User)? defaultUserImage,
    Widget Function(BuildContext, User)? placeholderUserImage,
    List<StreamReactionIcon>? reactionIcons,
    bool? enforceUniqueReactions,
  }) {
    return StreamChatConfiguration(
      defaultUserImage: defaultUserImage ?? this.defaultUserImage,
      placeholderUserImage: placeholderUserImage ?? this.placeholderUserImage,
      reactionIcons: reactionIcons ?? this.reactionIcons,
      enforceUniqueReactions:
          enforceUniqueReactions ?? this.enforceUniqueReactions,
    );
  }

  /// The widget that will be built when the user image is unavailable.
  final Widget Function(BuildContext, User)? defaultUserImage;

  /// The widget that will be built when the user image is loading.
  final Widget Function(BuildContext, User)? placeholderUserImage;

  /// Assets used for rendering reactions.
  final List<StreamReactionIcon>? reactionIcons;

  /// Whether a new reaction should replace the existing one.
  final bool? enforceUniqueReactions;

  static final _defaultReactionIcons = [
    StreamReactionIcon(
      type: 'love',
      builder: (context, highlighted, size) {
        final theme = StreamChatTheme.of(context);
        return StreamSvgIcon.loveReaction(
          color: highlighted
              ? theme.colorTheme.accentPrimary
              : theme.primaryIconTheme.color!.withOpacity(0.5),
          size: size,
        );
      },
    ),
    StreamReactionIcon(
      type: 'like',
      builder: (context, highlighted, size) {
        final theme = StreamChatTheme.of(context);
        return StreamSvgIcon.thumbsUpReaction(
          color: highlighted
              ? theme.colorTheme.accentPrimary
              : theme.primaryIconTheme.color!.withOpacity(0.5),
          size: size,
        );
      },
    ),
    StreamReactionIcon(
      type: 'sad',
      builder: (context, highlighted, size) {
        final theme = StreamChatTheme.of(context);
        return StreamSvgIcon.thumbsDownReaction(
          color: highlighted
              ? theme.colorTheme.accentPrimary
              : theme.primaryIconTheme.color!.withOpacity(0.5),
          size: size,
        );
      },
    ),
    StreamReactionIcon(
      type: 'haha',
      builder: (context, highlighted, size) {
        final theme = StreamChatTheme.of(context);
        return StreamSvgIcon.lolReaction(
          color: highlighted
              ? theme.colorTheme.accentPrimary
              : theme.primaryIconTheme.color!.withOpacity(0.5),
          size: size,
        );
      },
    ),
    StreamReactionIcon(
      type: 'wow',
      builder: (context, highlighted, size) {
        final theme = StreamChatTheme.of(context);
        return StreamSvgIcon.wutReaction(
          color: highlighted
              ? theme.colorTheme.accentPrimary
              : theme.primaryIconTheme.color!.withOpacity(0.5),
          size: size,
        );
      },
    ),
  ];
}

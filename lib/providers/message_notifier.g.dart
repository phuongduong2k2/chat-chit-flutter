// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MessageNotifier)
final messageProvider = MessageNotifierProvider._();

final class MessageNotifierProvider
    extends $AsyncNotifierProvider<MessageNotifier, List<Message>> {
  MessageNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'messageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$messageNotifierHash();

  @$internal
  @override
  MessageNotifier create() => MessageNotifier();
}

String _$messageNotifierHash() => r'920edf18184c11ca6c29c1918bbfe38e5c067e37';

abstract class _$MessageNotifier extends $AsyncNotifier<List<Message>> {
  FutureOr<List<Message>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Message>>, List<Message>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Message>>, List<Message>>,
              AsyncValue<List<Message>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

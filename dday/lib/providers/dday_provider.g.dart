// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dday_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dDayEventsHash() => r'ef609a5adfb687b80b9f164f2274de0d9d5704e6';

/// See also [DDayEvents].
@ProviderFor(DDayEvents)
final dDayEventsProvider =
    AutoDisposeAsyncNotifierProvider<DDayEvents, List<DDayEvent>>.internal(
      DDayEvents.new,
      name: r'dDayEventsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$dDayEventsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DDayEvents = AutoDisposeAsyncNotifier<List<DDayEvent>>;
String _$dDayCalculationHash() => r'7b60dd8ae9b6dcf00c35f5746088edfdfaa97724';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$DDayCalculation extends BuildlessAutoDisposeNotifier<String> {
  late final DDayEvent event;

  String build(DDayEvent event);
}

/// See also [DDayCalculation].
@ProviderFor(DDayCalculation)
const dDayCalculationProvider = DDayCalculationFamily();

/// See also [DDayCalculation].
class DDayCalculationFamily extends Family<String> {
  /// See also [DDayCalculation].
  const DDayCalculationFamily();

  /// See also [DDayCalculation].
  DDayCalculationProvider call(DDayEvent event) {
    return DDayCalculationProvider(event);
  }

  @override
  DDayCalculationProvider getProviderOverride(
    covariant DDayCalculationProvider provider,
  ) {
    return call(provider.event);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dDayCalculationProvider';
}

/// See also [DDayCalculation].
class DDayCalculationProvider
    extends AutoDisposeNotifierProviderImpl<DDayCalculation, String> {
  /// See also [DDayCalculation].
  DDayCalculationProvider(DDayEvent event)
    : this._internal(
        () => DDayCalculation()..event = event,
        from: dDayCalculationProvider,
        name: r'dDayCalculationProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$dDayCalculationHash,
        dependencies: DDayCalculationFamily._dependencies,
        allTransitiveDependencies:
            DDayCalculationFamily._allTransitiveDependencies,
        event: event,
      );

  DDayCalculationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.event,
  }) : super.internal();

  final DDayEvent event;

  @override
  String runNotifierBuild(covariant DDayCalculation notifier) {
    return notifier.build(event);
  }

  @override
  Override overrideWith(DDayCalculation Function() create) {
    return ProviderOverride(
      origin: this,
      override: DDayCalculationProvider._internal(
        () => create()..event = event,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        event: event,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<DDayCalculation, String> createElement() {
    return _DDayCalculationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DDayCalculationProvider && other.event == event;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, event.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DDayCalculationRef on AutoDisposeNotifierProviderRef<String> {
  /// The parameter `event` of this provider.
  DDayEvent get event;
}

class _DDayCalculationProviderElement
    extends AutoDisposeNotifierProviderElement<DDayCalculation, String>
    with DDayCalculationRef {
  _DDayCalculationProviderElement(super.provider);

  @override
  DDayEvent get event => (origin as DDayCalculationProvider).event;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

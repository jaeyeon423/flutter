// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$familyHelloHash() => r'9edc8c6c02bfdd8409932337fc21d3a47f65f4df';

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

/// See also [familyHello].
@ProviderFor(familyHello)
const familyHelloProvider = FamilyHelloFamily();

/// See also [familyHello].
class FamilyHelloFamily extends Family<String> {
  /// See also [familyHello].
  const FamilyHelloFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'familyHelloProvider';

  /// See also [familyHello].
  FamilyHelloProvider call(
    String there,
  ) {
    return FamilyHelloProvider(
      there,
    );
  }

  @visibleForOverriding
  @override
  FamilyHelloProvider getProviderOverride(
    covariant FamilyHelloProvider provider,
  ) {
    return call(
      provider.there,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(String Function(FamilyHelloRef ref) create) {
    return _$FamilyHelloFamilyOverride(this, create);
  }
}

class _$FamilyHelloFamilyOverride implements FamilyOverride<String> {
  _$FamilyHelloFamilyOverride(this.overriddenFamily, this.create);

  final String Function(FamilyHelloRef ref) create;

  @override
  final FamilyHelloFamily overriddenFamily;

  @override
  FamilyHelloProvider getProviderOverride(
    covariant FamilyHelloProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [familyHello].
class FamilyHelloProvider extends Provider<String> {
  /// See also [familyHello].
  FamilyHelloProvider(
    String there,
  ) : this._internal(
          (ref) => familyHello(
            ref as FamilyHelloRef,
            there,
          ),
          from: familyHelloProvider,
          name: r'familyHelloProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$familyHelloHash,
          dependencies: FamilyHelloFamily._dependencies,
          allTransitiveDependencies:
              FamilyHelloFamily._allTransitiveDependencies,
          there: there,
        );

  FamilyHelloProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.there,
  }) : super.internal();

  final String there;

  @override
  Override overrideWith(
    String Function(FamilyHelloRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FamilyHelloProvider._internal(
        (ref) => create(ref as FamilyHelloRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        there: there,
      ),
    );
  }

  @override
  (String,) get argument {
    return (there,);
  }

  @override
  ProviderElement<String> createElement() {
    return _FamilyHelloProviderElement(this);
  }

  FamilyHelloProvider _copyWith(
    String Function(FamilyHelloRef ref) create,
  ) {
    return FamilyHelloProvider._internal(
      (ref) => create(ref as FamilyHelloRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      there: there,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FamilyHelloProvider && other.there == there;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, there.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FamilyHelloRef on ProviderRef<String> {
  /// The parameter `there` of this provider.
  String get there;
}

class _FamilyHelloProviderElement extends ProviderElement<String>
    with FamilyHelloRef {
  _FamilyHelloProviderElement(super.provider);

  @override
  String get there => (origin as FamilyHelloProvider).there;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'survey_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SurveyState {

 List<Survey> get surveys; Survey? get selectedSurvey; bool get isLoading; String? get error;
/// Create a copy of SurveyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurveyStateCopyWith<SurveyState> get copyWith => _$SurveyStateCopyWithImpl<SurveyState>(this as SurveyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurveyState&&const DeepCollectionEquality().equals(other.surveys, surveys)&&(identical(other.selectedSurvey, selectedSurvey) || other.selectedSurvey == selectedSurvey)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(surveys),selectedSurvey,isLoading,error);

@override
String toString() {
  return 'SurveyState(surveys: $surveys, selectedSurvey: $selectedSurvey, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $SurveyStateCopyWith<$Res>  {
  factory $SurveyStateCopyWith(SurveyState value, $Res Function(SurveyState) _then) = _$SurveyStateCopyWithImpl;
@useResult
$Res call({
 List<Survey> surveys, Survey? selectedSurvey, bool isLoading, String? error
});


$SurveyCopyWith<$Res>? get selectedSurvey;

}
/// @nodoc
class _$SurveyStateCopyWithImpl<$Res>
    implements $SurveyStateCopyWith<$Res> {
  _$SurveyStateCopyWithImpl(this._self, this._then);

  final SurveyState _self;
  final $Res Function(SurveyState) _then;

/// Create a copy of SurveyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surveys = null,Object? selectedSurvey = freezed,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
surveys: null == surveys ? _self.surveys : surveys // ignore: cast_nullable_to_non_nullable
as List<Survey>,selectedSurvey: freezed == selectedSurvey ? _self.selectedSurvey : selectedSurvey // ignore: cast_nullable_to_non_nullable
as Survey?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SurveyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurveyCopyWith<$Res>? get selectedSurvey {
    if (_self.selectedSurvey == null) {
    return null;
  }

  return $SurveyCopyWith<$Res>(_self.selectedSurvey!, (value) {
    return _then(_self.copyWith(selectedSurvey: value));
  });
}
}


/// Adds pattern-matching-related methods to [SurveyState].
extension SurveyStatePatterns on SurveyState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurveyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurveyState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurveyState value)  $default,){
final _that = this;
switch (_that) {
case _SurveyState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurveyState value)?  $default,){
final _that = this;
switch (_that) {
case _SurveyState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Survey> surveys,  Survey? selectedSurvey,  bool isLoading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurveyState() when $default != null:
return $default(_that.surveys,_that.selectedSurvey,_that.isLoading,_that.error);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Survey> surveys,  Survey? selectedSurvey,  bool isLoading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _SurveyState():
return $default(_that.surveys,_that.selectedSurvey,_that.isLoading,_that.error);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Survey> surveys,  Survey? selectedSurvey,  bool isLoading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _SurveyState() when $default != null:
return $default(_that.surveys,_that.selectedSurvey,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _SurveyState implements SurveyState {
  const _SurveyState({final  List<Survey> surveys = const [], this.selectedSurvey, this.isLoading = false, this.error}): _surveys = surveys;
  

 final  List<Survey> _surveys;
@override@JsonKey() List<Survey> get surveys {
  if (_surveys is EqualUnmodifiableListView) return _surveys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_surveys);
}

@override final  Survey? selectedSurvey;
@override@JsonKey() final  bool isLoading;
@override final  String? error;

/// Create a copy of SurveyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurveyStateCopyWith<_SurveyState> get copyWith => __$SurveyStateCopyWithImpl<_SurveyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurveyState&&const DeepCollectionEquality().equals(other._surveys, _surveys)&&(identical(other.selectedSurvey, selectedSurvey) || other.selectedSurvey == selectedSurvey)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_surveys),selectedSurvey,isLoading,error);

@override
String toString() {
  return 'SurveyState(surveys: $surveys, selectedSurvey: $selectedSurvey, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$SurveyStateCopyWith<$Res> implements $SurveyStateCopyWith<$Res> {
  factory _$SurveyStateCopyWith(_SurveyState value, $Res Function(_SurveyState) _then) = __$SurveyStateCopyWithImpl;
@override @useResult
$Res call({
 List<Survey> surveys, Survey? selectedSurvey, bool isLoading, String? error
});


@override $SurveyCopyWith<$Res>? get selectedSurvey;

}
/// @nodoc
class __$SurveyStateCopyWithImpl<$Res>
    implements _$SurveyStateCopyWith<$Res> {
  __$SurveyStateCopyWithImpl(this._self, this._then);

  final _SurveyState _self;
  final $Res Function(_SurveyState) _then;

/// Create a copy of SurveyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surveys = null,Object? selectedSurvey = freezed,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_SurveyState(
surveys: null == surveys ? _self._surveys : surveys // ignore: cast_nullable_to_non_nullable
as List<Survey>,selectedSurvey: freezed == selectedSurvey ? _self.selectedSurvey : selectedSurvey // ignore: cast_nullable_to_non_nullable
as Survey?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SurveyState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurveyCopyWith<$Res>? get selectedSurvey {
    if (_self.selectedSurvey == null) {
    return null;
  }

  return $SurveyCopyWith<$Res>(_self.selectedSurvey!, (value) {
    return _then(_self.copyWith(selectedSurvey: value));
  });
}
}

// dart format on

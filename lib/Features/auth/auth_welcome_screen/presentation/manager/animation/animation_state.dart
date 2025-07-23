part of 'animation_cubit.dart';

@immutable
sealed class AnimationState {}

final class AnimationInitial extends AnimationState {}

final class ButtonMovedDown extends AnimationState {}

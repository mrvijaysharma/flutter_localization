import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class LanguageEvent extends Equatable {}

final class ChangeLanguageEvent extends LanguageEvent {
  final Locale local;
  ChangeLanguageEvent(this.local);

  @override
  List<Object?> get props => [local];
}

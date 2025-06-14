import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState(Locale('en'))) {
    on<ChangeLanguageEvent>((event, emit) => emit(LanguageState(event.local)));
  }
}

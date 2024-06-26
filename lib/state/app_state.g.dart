// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppState on _AppState, Store {
  Computed<ObservableList<Reminder>>? _$sortedListComputed;

  @override
  ObservableList<Reminder> get sortedList => (_$sortedListComputed ??=
          Computed<ObservableList<Reminder>>(() => super.sortedList,
              name: '_AppState.sortedList'))
      .value;

  late final _$currentScreenAtom =
      Atom(name: '_AppState.currentScreen', context: context);

  @override
  AppScreen get currentScreen {
    _$currentScreenAtom.reportRead();
    return super.currentScreen;
  }

  @override
  set currentScreen(AppScreen value) {
    _$currentScreenAtom.reportWrite(value, super.currentScreen, () {
      super.currentScreen = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AppState.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$currentUserAtom =
      Atom(name: '_AppState.currentUser', context: context);

  @override
  User? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$authErrorAtom =
      Atom(name: '_AppState.authError', context: context);

  @override
  AuthError? get authError {
    _$authErrorAtom.reportRead();
    return super.authError;
  }

  @override
  set authError(AuthError? value) {
    _$authErrorAtom.reportWrite(value, super.authError, () {
      super.authError = value;
    });
  }

  late final _$reminderAtom =
      Atom(name: '_AppState.reminder', context: context);

  @override
  ObservableList<Reminder> get reminder {
    _$reminderAtom.reportRead();
    return super.reminder;
  }

  @override
  set reminder(ObservableList<Reminder> value) {
    _$reminderAtom.reportWrite(value, super.reminder, () {
      super.reminder = value;
    });
  }

  late final _$deleteAsyncAction =
      AsyncAction('_AppState.delete', context: context);

  @override
  Future<bool> delete(Reminder rem) {
    return _$deleteAsyncAction.run(() => super.delete(rem));
  }

  late final _$deleteAccountAsyncAction =
      AsyncAction('_AppState.deleteAccount', context: context);

  @override
  Future<bool> deleteAccount() {
    return _$deleteAccountAsyncAction.run(() => super.deleteAccount());
  }

  late final _$logOutAsyncAction =
      AsyncAction('_AppState.logOut', context: context);

  @override
  Future<void> logOut() {
    return _$logOutAsyncAction.run(() => super.logOut());
  }

  late final _$addReminderAsyncAction =
      AsyncAction('_AppState.addReminder', context: context);

  @override
  Future<bool> addReminder(String text) {
    return _$addReminderAsyncAction.run(() => super.addReminder(text));
  }

  late final _$modifyAsyncAction =
      AsyncAction('_AppState.modify', context: context);

  @override
  Future<bool> modify(Reminder rem, {required bool isDone}) {
    return _$modifyAsyncAction.run(() => super.modify(rem, isDone: isDone));
  }

  late final _$initializationAsyncAction =
      AsyncAction('_AppState.initialization', context: context);

  @override
  Future<void> initialization() {
    return _$initializationAsyncAction.run(() => super.initialization());
  }

  late final _$_loadRemindersAsyncAction =
      AsyncAction('_AppState._loadReminders', context: context);

  @override
  Future<bool> _loadReminders() {
    return _$_loadRemindersAsyncAction.run(() => super._loadReminders());
  }

  late final _$_registerOrLoginAsyncAction =
      AsyncAction('_AppState._registerOrLogin', context: context);

  @override
  Future<bool> _registerOrLogin(
      {required LoginOrRegisterFunction fn,
      required String email,
      required String password}) {
    return _$_registerOrLoginAsyncAction.run(
        () => super._registerOrLogin(fn: fn, email: email, password: password));
  }

  late final _$_AppStateActionController =
      ActionController(name: '_AppState', context: context);

  @override
  void goTo(AppScreen screen) {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.goTo');
    try {
      return super.goTo(screen);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<bool> register({required String email, required String password}) {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.register');
    try {
      return super.register(email: email, password: password);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<bool> login({required String email, required String password}) {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.login');
    try {
      return super.login(email: email, password: password);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentScreen: ${currentScreen},
isLoading: ${isLoading},
currentUser: ${currentUser},
authError: ${authError},
reminder: ${reminder},
sortedList: ${sortedList}
    ''';
  }
}

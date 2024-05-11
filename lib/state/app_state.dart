import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_flutter/auth/auth_error.dart';
import 'package:mobx_flutter/state/reminder.dart';

part 'app_state.g.dart';

class AppState = _AppState with _$AppState;

abstract class _AppState with Store {
  @observable
  AppScreen currentScreen = AppScreen.loginScreen;

  @observable
  bool isLoading = false;

  @observable
  User? currentUser;

  @observable
  AuthError? authError;

  @observable
  ObservableList<Reminder> reminder = ObservableList<Reminder>();

  @computed
  ObservableList<Reminder> get sortedList =>
      ObservableList.of(reminder.sorted());

  @action
  void goTo(AppScreen screen) {
    currentScreen = screen;
  }

  @action
  Future<bool> delete(Reminder rem) async {
    isLoading = true;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      isLoading = false;
      return false;
    }
    final uid = user.uid;
    final collection = await FirebaseFirestore.instance.collection(uid).get();
    try {
      final firebaseRemider =
          collection.docs.firstWhere((element) => element.id == rem.id);
      await firebaseRemider.reference.delete();
      reminder.removeWhere((element) => element.id == rem.id);
      isLoading = false;
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> deleteAccount() async {
    isLoading = true;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      isLoading = false;
      return false;
    }
    final uid = user.uid;
    try {
      final store = FirebaseFirestore.instance;
      final collection = await store.collection(uid).get();
      final operation = store.batch();
      for (var document in collection.docs) {
        operation.delete(document.reference);
      }

      await operation.commit();
      await user.delete();
      await FirebaseAuth.instance.signOut();

      currentScreen = AppScreen.loginScreen;
      return true;
    } on FirebaseAuthException catch (e) {
      AuthError.from(e);
      return false;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> logOut() async {
    isLoading = true;
    try {
      await FirebaseAuth.instance.signOut();
      currentScreen = AppScreen.loginScreen;
      isLoading = false;
    } catch (_) {
      isLoading = false;
    }
    reminder.clear();
  }

  @action
  Future<bool> addReminder(String text) async {
    isLoading = true;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      isLoading = false;
      return false;
    }
    final uid = user.uid;
    try {
      final creationDate = DateTime.now();
      //create Firebase Reminder
      final firebaseReminder =
          await FirebaseFirestore.instance.collection(uid).add({
        _DocumentKeys.creationDate: creationDate,
        _DocumentKeys.isDone: false,
        _DocumentKeys.text: text,
      });

      //create local reminder
      Reminder re = Reminder(
        id: firebaseReminder.toString(),
        creationDate: creationDate,
        isDone: false,
        text: text,
      );
      reminder.add(re);
      isLoading = false;
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> modify(Reminder rem, {required bool isDone}) async {
    var userId = currentUser?.uid;

    if (userId == null) {
      return false;
    }
    // update reminder at remote
    try {
      await FirebaseFirestore.instance
          .collection(userId)
          .doc(rem.id)
          .update({_DocumentKeys.isDone: isDone});
      //update loacally reminder
      reminder.firstWhere((element) => element.id == rem.id).isDone = isDone;
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> initialization() async {
    isLoading = true;
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final collection =
          await FirebaseFirestore.instance.collection(currentUser!.uid).get();
      await _loadReminders();
      currentScreen = AppScreen.reminderScreen;
      isLoading = false;
    } else {
      isLoading = false;
      currentScreen = AppScreen.loginScreen;
    }
  }

  @action
  Future<bool> _loadReminders() async {
    final collection =
        await FirebaseFirestore.instance.collection(currentUser!.uid).get();
    final reminders = collection.docs.map<Reminder>(
      (e) => Reminder(
        id: e.id,
        creationDate: DateTime.parse(e[_DocumentKeys.creationDate] as String),
        isDone: e[_DocumentKeys.isDone] as bool,
        text: e[_DocumentKeys.text] as String,
      ),
    );
    reminder = ObservableList<Reminder>.of(reminders);
    return true;
  }

  @action
  Future<bool> _registerOrLogin({
    required LoginOrRegisterFunction fn,
    required String email,
    required String password,
  }) async {
    try {
      await fn(
        password: password,
        email: email,
      );
      await _loadReminders();
      return true;
    } on FirebaseAuthException catch (e) {
      currentUser = null;
      authError = AuthError.from(e);
      return false;
    } finally {
      isLoading = false;
      if (currentUser != null) {
        currentScreen = AppScreen.reminderScreen;
      }
    }
  }

  @action
  Future<bool> register({
    required String email,
    required String password,
  }) =>
      _registerOrLogin(
        fn: FirebaseAuth.instance.createUserWithEmailAndPassword,
        email: email,
        password: password,
      );
  @action
  Future<bool> login({
    required String email,
    required String password,
  }) =>
      _registerOrLogin(
        fn: FirebaseAuth.instance.signInWithEmailAndPassword,
        email: email,
        password: password,
      );
}

abstract class _DocumentKeys {
  static const text = 'text';
  static const creationDate = 'creationDate';
  static const isDone = 'is_done';
}

typedef LoginOrRegisterFunction = Future<UserCredential> Function({
  required String email,
  required String password,
});

extension ToInt on bool {
  int toInteger() => this ? 1 : 0;
}

extension Sorted on List<Reminder> {
  List<Reminder> sorted() => [...this]..sort((lhs, rhs) {
      final isDone = lhs.isDone.toInteger().compareTo(rhs.isDone.toInteger());
      if (isDone != 0) {
        return isDone;
      }
      return lhs.creationDate.compareTo(rhs.creationDate);
    });
}

enum AppScreen {
  loginScreen,
  registerScreen,
  reminderScreen,
}

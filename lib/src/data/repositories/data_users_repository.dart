import '../../app/SharedPreferencesKeys.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/users_repository.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DataUsersRepository extends UsersRepository {
  List<User> users;

  static DataUsersRepository _instance = DataUsersRepository._internal();

  DataUsersRepository._internal() {
    users = <User>[];
  }
  factory DataUsersRepository() => _instance;

  @override
  Future<List<User>> getAllUsers() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    String username;
    if (preferences.getKeys().contains(SharedPreferencesKeys.username)) {
      username = 'Guest';
      preferences.setString(SharedPreferencesKeys.username, username);
    } else {
      username = preferences.get(SharedPreferencesKeys.username);
    }
    return users;
  }

  @override
  Future<User> getUser(String uid) async {
    return users.firstWhere((user) => user.uid == uid);
  }
}

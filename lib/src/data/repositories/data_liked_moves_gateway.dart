import 'package:salsa_coach/src/app/shared_preferences_keys.dart';
import 'package:salsa_coach/src/domain/entities/move.dart';
import 'package:salsa_coach/src/domain/repositories/liked_moves_gateway.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataLikedMovesGateway implements LikedMovesGateway {

  @override
  Future<bool> isLikedMove(Move move) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      var value = preferences.getBool(_keyForMove(move));
      return value != null ? value : false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> setLikedMove(Move move, bool isLiked) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    var status = await preferences.setBool(_keyForMove(move), isLiked);
    return status;
  }

  String _keyForMove(Move move) {
    return SharedPreferencesKeys.likedMove + move.name;
  }

}
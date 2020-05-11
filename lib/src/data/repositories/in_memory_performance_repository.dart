import 'package:salsa_memo/src/app/SharedPreferencesKeys.dart';
import 'package:salsa_memo/src/domain/entities/performance_score.dart';
import 'package:salsa_memo/src/domain/repositories/performance_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(key);
    var decoded = json.decode(value);
    return decoded;
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

class SharedPreferencesPerformanceRepository extends PerformanceRepository {

  final SharedPref _sharedPref = SharedPref();

  @override
  Future<bool> add(Performance performance) async {
    int performanceCount;
    try {
      performanceCount = await _sharedPref.read(SharedPreferencesKeys.performanceCount);
    } catch (e) {
      performanceCount = 0;
    }
    performanceCount++;
    await _sharedPref.save(SharedPreferencesKeys.performanceCount, performanceCount);

    var key = _makePerformanceKey(performanceCount);
    await _sharedPref.save(
      key, 
      performance
    );

    // var value = await _sharedPref.read(key);

    // print("KEY = $key");
    // print("VALUE = ${value["id"]}");
    // try {
    //   Performance perf = Performance.fromJson(value);
    //   print("perf $perf");
    // } catch (e) {

    // }
    

    return true;
  }
  
  @override
  Future<List<Performance>> all() async {
    var perfs = <Performance>[];
    int performanceCount;
    try {
      performanceCount = await _sharedPref.read(SharedPreferencesKeys.performanceCount);
    } catch (e) {
      return [];
    }
    
    // for (var i = 0 ; i < performanceCount ; i++) {
    //   var key = _makePerformanceKey(i);
    //   var perf = await _sharedPref.read(key);
    //   perfs.add(perf);
    // }
    try {
      print("AAAAA");
      var perfJson = await _sharedPref.read(_makePerformanceKey(1));
      var perf = Performance.fromJson(perfJson);

      perfs.add(perf);
      print("BBBBB $perf");
    } catch (e) {
      print("EEEEE");
    }
    

    return perfs;
  }

  String _makePerformanceKey(int count) {
    return SharedPreferencesKeys.performance + count.toString();
  }

}

class InMemoryPerformanceRepository extends PerformanceRepository {
  List<Performance> _perfs;
  InMemoryPerformanceRepository(this._perfs);

  @override
  Future<bool> add(Performance performance) async {
    this._perfs.add(performance);
    return true;
  }
  
  @override
  Future<List<Performance>> all() async {
    return _perfs;
  }
  
}
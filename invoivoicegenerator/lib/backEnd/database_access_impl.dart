import '../model/settings.dart';
import '../database_helper.dart';

class DataBaseAccess {
  Future<List<Settings>> getSettings() async {
    return await DatabaseHelper.instance.getUsers();
  }

  Future<bool> userAvailabel() async {
    bool available = await DatabaseHelper.instance.settingsAvailable();
    return available;
  }

  Future<int?> getUserCount() async {
    int? available = await DatabaseHelper.instance.getCount();
    return available;
  }

  Future<List<String>> getUserNames() async {
    List<Settings> settings = await getSettings();
    List<String> names = [];
    for (var setting in settings) {
      names.add(setting.name);
    }

    return names;
  }

  Future<Settings> getUserByName(String? name) async {
    return DatabaseHelper.instance.getUserByName(name);
  }
}

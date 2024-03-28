import '../model/settings.dart';
import '../database_helper.dart';

class SettingsPageLogic {
  Future<List<Settings>> getSettings() async {
    return await DatabaseHelper.instance.getUsers();
  }

  Future<bool> userAvailabel() async {
    bool available = await DatabaseHelper.instance.settingsAvailable();
    return available;
  }
}

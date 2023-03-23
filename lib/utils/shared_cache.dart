import 'package:app_waiter/dtos/response/mesero_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedCache {
  Future<WaiterResponseDto?> getWaiterFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final waiterName = prefs.getString('waiter_name');
    final waiterLastName = prefs.getString('waiter_last_name');
    final waiterId = prefs.getString('waiter_id');

    if (waiterName != null && waiterLastName != null && waiterId != null) {
      final waiterBirthDay =
          DateTime.parse(prefs.getString('waiter_birthday') ?? "12/01/2022");
      final waiterCreatedAt =
          DateTime.parse(prefs.getString('waiter_created') ?? "12/01/2022");
      final waiterAge = prefs.getInt('waiter_age') ?? 0;
      return WaiterResponseDto(
        name: waiterName,
        lastName: waiterLastName,
        id: waiterId,
        birthdate: waiterBirthDay,
        age: waiterAge,
        createdAt: waiterCreatedAt,
      );
    } else {
      return null;
    }
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> saveWaiterToCache(WaiterResponseDto? waiter) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('waiter_name', waiter!.name);
    prefs.setString('waiter_last_name', waiter.lastName);
    prefs.setString('waiter_id', waiter.id);
    prefs.setString('waiter_birthday', waiter.birthdate.toString());
    prefs.setString('waiter_created', waiter.createdAt.toString());
    prefs.setInt('waiter_age', waiter.age);
  }
}

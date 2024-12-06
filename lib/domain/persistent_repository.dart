abstract class PersistentRepo {
  saveUserToken(String token);

  String? getUserToken();
}

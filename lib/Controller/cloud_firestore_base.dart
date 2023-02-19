abstract class MyCloudStoreBase {
  // registering user data to database
  Future registerUser(String? uid, String name, String email, int phoneNumber);
}

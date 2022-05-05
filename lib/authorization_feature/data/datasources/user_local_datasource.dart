import 'package:authorization_test_project/authorization_feature/data/models/user_model.dart';
import 'package:authorization_test_project/authorization_feature/data/exception/exception.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String userBoxKey = 'user_box';

class UserLocalDataSource {
  late Box<String> box;

  UserLocalDataSource({required this.box});

  UserModel? get(String login) {
    validateBox();

    if (box.isNotEmpty) {
      try {
        String? password = box.get(login);

        if (password == null) {
          return null;
        }

        return UserModel(login: login, password: password);
      } catch (e) {
        throw OperationException();
      }
    }
  }

  Future<void> save(UserModel model) async {
    validateBox();

    try {
      await box.put(model.login, model.password);
    } catch (e) {
      throw OperationException();
    }
  }

  Future<void> update(UserModel model) async {
    validateBox();

    try {
      await box.delete(model.login);
      await box.put(model.login, model.password);
    } catch (e) {
      OperationException();
    }
  }

  bool isExisting(UserModel model) {
    validateBox();

    if (box.isEmpty || !contains(model.login)) {
      return false;
    }

    try {
      String? password = box.get(model.login);

      return password == model.password;
    } catch (e) {
      OperationException();
    }

    return false;
  }

  bool contains(String login) {
    validateBox();

    if (box.isNotEmpty) {
      try {
        String? password = box.get(login);

        return password != null;
      } catch (e) {
        throw OperationException();
      }
    } else {
      return false;
    }
  }

  void validateBox() {
    if (!box.isOpen) {
      throw DatabaseException();
    }
  }
}

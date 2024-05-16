import 'package:flutter/material.dart';
import 'package:ta_peersupervision/api/logic/psusers_logic.dart';
import 'package:ta_peersupervision/api/repository/psusers_repository.dart';

class PSUserNotifier with ChangeNotifier {
  List<PSUser> _users = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<PSUser> get users => _users;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  final PSUsersRepository _repository = PSUsersRepository();

  Future<void> fetchActiveUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _users = await _repository.fetchUsers();
      _errorMessage = '';
    } catch (e) {
      _users = [];
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

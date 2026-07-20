import 'dart:convert';

import 'package:cristalteacher/features/authentication/domain/entities/login_entity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ValueNotifier<int> itemTapBehaviorNotifier = ValueNotifier<int>(1);

class SharedPreferenceHelper {
  static const String _baseUrlKey = 'base_url';
  static const String _tokenKey = 'auth_token';
  static const String _databaseNameKey = 'database_name';
  static const String _loginDataKey = 'login_data';
  static const String _isSchoolRegisteredKey = 'is_school_registered';
  static const String _branchDataKey = 'branch_data';
  static const String _playStoreVersionKey = 'playstore_version';
  static const String _appStoreVersionKey = 'appstore_version';
  static const String _schoolCodeKey = 'school_code';
  static const String _schoolNameKey = 'school_name';
  static const String _classWithDivisionKey = 'class_with_division';

  /// ------------------ SAVE FULL BRANCH DATA ------------------
  Future<void> saveBranchData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(data);
    await prefs.setString(_branchDataKey, jsonString);
  }

  /// ------------------ GET FULL BRANCH DATA ------------------
  Future<Map<String, dynamic>?> getBranchData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_branchDataKey);

    if (jsonString == null) return null;

    return jsonDecode(jsonString);
  }

  /// ------------------ SCHOOL REGISTER ------------------
  Future<void> saveSchoolRegistered(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isSchoolRegisteredKey, value);
  }

  Future<bool> isSchoolRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isSchoolRegisteredKey) ?? false;
  }
  // static const String _vatStatusKey = 'vat_status';
  // static const String _vatTypeKey = 'vat_type';
  // static const _itemTapBehaviorKey = 'itemTapBehavior';
  // static const _paymentOptionKey = 'payment_option';
  // // ✅ GLOBAL NOTIFIER (this is what HomeScreen listens to)

  /// ------------------ BASE URL ------------------
  Future<void> setBaseUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_baseUrlKey, url);
  }

  Future<String?> getBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_baseUrlKey);
  }

  /// ------------------ Play store version ------------------
  Future<void> setPlayStoreVersion(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_playStoreVersionKey, url);
  }

  Future<String?> getPlayStoreVersion() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_playStoreVersionKey);
  }

  /// ------------------ App store version ------------------
  Future<void> setAppStoreVersion(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_appStoreVersionKey, url);
  }

  Future<String?> getAppStoreVersion() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_appStoreVersionKey);
  }

  /// ------------------ School Code version ------------------
  Future<void> setSchoolCode(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_schoolCodeKey, url);
  }

  Future<String?> getSchoolCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_schoolCodeKey);
  }

  /// ------------------ School Name version ------------------
  Future<void> setSchoolName(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_schoolNameKey, url);
  }

  Future<String?> getSchoolName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_schoolNameKey);
  }

  /// ------------------ TOKEN ------------------
  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// ------------------ Class And Division ------------------
  Future<void> saveClassAndDivision(String classWithDivision) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_classWithDivisionKey, classWithDivision);
  }

  Future<String?> getClassAndDivision() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_classWithDivisionKey);
  }

  /// ------------------ BranchID ------------------
  Future<bool> setBranchId(String branchId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString("branchId", branchId);
  }

  Future<String> getBranchId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("branchId") ?? '';
  }

  Future<void> setDatabaseName(String dbName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_databaseNameKey, dbName);
  }

  Future<String?> getDatabaseName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_databaseNameKey);
  }

  // //logindata
  // Future<void> saveLoginResponse(LoginData response) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final jsonString = jsonEncode(response.toJson());
  //   await prefs.setString(_loginDataKey, jsonString);
  // }

  // Future<LoginData?> getLoginResponse() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final jsonString = prefs.getString(_loginDataKey);

  //   if (jsonString == null) return null;

  //   final jsonMap = jsonDecode(jsonString);
  //   return LoginData.fromJson(jsonMap);
  // }
  /// ------------------ LOGIN RESPONSE ------------------

  Future<void> saveLoginResponse(LoginEntity response) async {
    final prefs = await SharedPreferences.getInstance();

    final String jsonString = jsonEncode(response.toJson());

    await prefs.setString(_loginDataKey, jsonString);

    debugPrint('Login response saved: $jsonString');
  }

  Future<LoginEntity?> getLoginResponse() async {
    final prefs = await SharedPreferences.getInstance();

    final String? jsonString = prefs.getString(_loginDataKey);

    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    return LoginEntity.fromJson(jsonMap);
  }
  // Future<void> clearLoginData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove(_loginDataKey);
  //   await prefs.remove(_tokenKey);
  // }

  // //Save Account list while switch

  // static Future<void> saveNewAccount(AccountDetails account) async {
  //   final prefs = await SharedPreferences.getInstance();

  //   List<String> data = prefs.getStringList('accounts') ?? [];
  //   print('dataInsertion ${data}');

  //   bool exists = data.any((item) {
  //     final decoded = jsonDecode(item);
  //     return decoded['admissionNo'] == account.admissionNo;
  //   });

  //   if (!exists) {
  //     data.add(jsonEncode(account.toJson()));
  //     await prefs.setStringList('accounts', data);
  //   }
  // }

  // // Clear on logout
  // static Future<void> clearSavedAccount() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   await prefs.remove('accounts');
  // }
  // //fetch List

  // Future<List<AccountDetails>> getAccounts() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   List<String> data = prefs.getStringList('accounts') ?? [];

  //   return data.map((e) => AccountDetails.fromJson(jsonDecode(e))).toList();
  // }

  // //Clear account details
  // static Future<void> clearAccounts() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setStringList('accounts', []);
  // }
  // //printer
  // Future<bool> saveSelectedPrinter(String selectedPrinter) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.setString("selectedPrinter", selectedPrinter);
  // }

  // Future<String?> loadSelectedPrinter() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("selectedPrinter");
  // }

  // //printer
  // Future<bool> saveSelectedPrinterSize(String printerSize) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.setString("printerSize", printerSize);
  // }

  // Future<String?> loadSelectedPrinterSize() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("printerSize");
  // }

  // /// ------------------ VAT STATUS ------------------
  // Future<void> setVatStatus(bool status) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool(_vatStatusKey, status);
  // }

  // Future<bool> getVatStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool(_vatStatusKey) ?? false;
  // }

  // /// ------------------ VAT TYPE ------------------
  // Future<void> setVatType(String type) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(_vatTypeKey, type);
  // }

  // Future<String> getVatType() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_vatTypeKey) ?? '';
  // }

  // /// ------------------ LEDGERS ------------------
  // Future<void> saveLedgers({
  //   required int cashLedgerId,
  //   required String cashLedgerName,
  //   required int cardLedgerId,
  //   required String cardLedgerName,
  //   required int bankLedgerId,
  //   required String bankLedgerName,
  // }) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('cashLedgerId', cashLedgerId);
  //   await prefs.setString('cashLedgerName', cashLedgerName);
  //   await prefs.setInt('cardLedgerId', cardLedgerId);
  //   await prefs.setString('cardLedgerName', cardLedgerName);
  //   await prefs.setInt('bankLedgerId', bankLedgerId);
  //   await prefs.setString('bankLedgerName', bankLedgerName);
  // }

  // Future<Map<String, dynamic>> getLedgers() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return {
  //     'cashLedgerId': prefs.getInt('cashLedgerId'),
  //     'cashLedgerName': prefs.getString('cashLedgerName'),
  //     'cardLedgerId': prefs.getInt('cardLedgerId'),
  //     'cardLedgerName': prefs.getString('cardLedgerName'),
  //     'bankLedgerId': prefs.getInt('bankLedgerId'),
  //     'bankLedgerName': prefs.getString('bankLedgerName'),
  //   };
  // }

  // Future<void> saveItemTapBehavior(int value) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt(_itemTapBehaviorKey, value);
  //   // ✅ update instantly for live screens
  //   itemTapBehaviorNotifier.value = value;
  // }

  // Future<int> getItemTapBehavior() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final v = prefs.getInt(_itemTapBehaviorKey) ?? 1;
  //   itemTapBehaviorNotifier.value = v;
  //   return v;
  // }

  // Future<void> savePaymentOption(int value) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt(_paymentOptionKey, value);
  // }

  // Future<int> getPaymentOption() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getInt(_paymentOptionKey) ?? 0; // CASH default
  // }
}

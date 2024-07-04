import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

class CustomFunctions {
  static bool isAndroid() {
    return false;
    if (kIsWeb) {
      return false;
    } else if (Platform.isAndroid) {
      return true;
    } else {
      return false;
    }
  }

  static String generateChatRoomId(
      {required String user1Email, required String user2Email}) {
    List<String> sortedEmails = [user1Email, user2Email]..sort();
    String concatenatedEmails = sortedEmails.join();
    String hashedId =
        sha256.convert(utf8.encode(concatenatedEmails)).toString();
    return hashedId;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please, enter your email";
    }
    String pattern = r'^[^@]+@[^@]+\.[^@]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value.trim())) {
      return "Please, enter a valid email";
    }
    return null;
  }
}

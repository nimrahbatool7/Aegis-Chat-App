// lib/core/security/encryption_service.dart

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:math';
import '../errors/exceptions.dart';

class EncryptionService {
  // Generate a random encryption key
  encrypt.Key generateKey() {
    return encrypt.Key.fromSecureRandom(32);
  }

  // Generate IV (Initialization Vector)
  encrypt.IV generateIV() {
    return encrypt.IV.fromSecureRandom(16);
  }

  // Encrypt text message
  String encryptMessage(String plainText, String keyString) {
    try {
      final key = encrypt.Key.fromBase64(keyString);
      final iv = generateIV();
      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      
      // Combine IV and encrypted data
      return '${iv.base64}:${encrypted.base64}';
    } catch (e) {
      throw EncryptionException('Failed to encrypt message: $e');
    }
  }

  // Decrypt text message
  String decryptMessage(String cipherText, String keyString) {
    try {
      final parts = cipherText.split(':');
      if (parts.length != 2) {
        throw const EncryptionException('Invalid cipher text format');
      }

      final iv = encrypt.IV.fromBase64(parts[0]);
      final encrypted = encrypt.Encrypted.fromBase64(parts[1]);
      final key = encrypt.Key.fromBase64(keyString);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));

      return encrypter.decrypt(encrypted, iv: iv);
    } catch (e) {
      throw EncryptionException('Failed to decrypt message: $e');
    }
  }

  // Hash password
  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Generate random OTP
  String generateOTP({int length = 6}) {
    final random = Random.secure();
    String otp = '';
    for (int i = 0; i < length; i++) {
      otp += random.nextInt(10).toString();
    }
    return otp;
  }

  // Generate session token
  String generateSessionToken() {
    final random = Random.secure();
    final values = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }

  // Verify hash
  bool verifyHash(String input, String hash) {
    return hashPassword(input) == hash;
  }
}

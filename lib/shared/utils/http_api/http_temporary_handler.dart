/*
!Note
Seluruh class Api, seharusnya memiliki callback berupa timeout, error, response ok, dll.
Dikarenakan saat ini ada sekitar 122 bagian yang perlu di refactor dengan hati-hati.

::: bisa di cari dengan search "await http." :::

Class ini dibuat sebagai solusi kasar sementara.
Yaitu:
1. Setiap kali ada timeout, error, maintenance, null response dan issue lainnya, otomatis
aplikasi akan kembali ke halaman awal (halaman login), dengan menampilkan pesan error.

2. Future.delayed(Duration(days: 99999)) digunakan sebagai solusi sementara, agar
kode sebelumnya yang belum selesai (tidak di eksekusi).
*/
import 'package:pos_app/core.dart';
import 'package:pos_app/main_mobile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as httpx;
import 'package:overlay_support/overlay_support.dart';

class HttpTemporaryHandler {
  static handle(url, method, httpx.Response response) async {
    if (kIsWeb) return;

    if (response == null) {
      debugPrint("Null Response at httpRequest");
      debugPrint("URL -> $method -> $url");
      runApp(MobileApp());
      debugPrint("Application Restart at ${DateTime.now()}");

      analyzeNullIssue(url, method, response);

      await Future.delayed(Duration(days: 9999999));
      return;
    }
  }

  static spesificHandle(url, method, String message) async {
    if (kIsWeb) return;

    analyzeSpesificIssue(url, method, message);
    await Future.delayed(Duration(days: 9999999));
    return;
  }

  static analyzeNullIssue(String url, method, httpx.Response response) {
    if (url.contains("/translation/version")) {
      showErrorMessage("Gagal mendapatkan versi Translate");
    } else if (response == null) {
      showErrorMessage("Koneksi Bermasalah");
    } else {
      showErrorMessage("Error");
    }
  }

  static analyzeSpesificIssue(String url, method, String message) {
    if (message == "TimeoutException") {
      showErrorMessage("Request Time Out");
    } else if (message == "SocketException") {
      showErrorMessage("Connection Problem");
    } else {
      showErrorMessage("Undefined Error");
    }
  }

  static showErrorMessage(message) {
    showSimpleNotification(
      Container(
        child: Row(
          children: <Widget>[
            Icon(
              FontAwesomeIcons.sadCry,
              color: Colors.white,
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(trans(message)),
            ),
          ],
        ),
      ),
      background: ButtonType.danger,
    );
  }
}

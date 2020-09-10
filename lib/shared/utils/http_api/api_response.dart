import 'package:pos_app/core.dart';













enum ApiStatus {
  success, 
  error,
  socketError,
  timeout,
  clientError, 
  serverError, 
  undefinedError,

  
  siteMaintenance, 

  
  invalidJsonFormat,

  /*
  Sebagai penanda jika Request Api gagal karena stuatu hal,
  Misalnya cek versi pada Login gagal,
  Mendapatkan Data Organisasi gagal,
  dan lainnya.

  Atau bisa juga dikarenakan ada salah satu Api yang gagal.

  Seluruh issue yang sifatnya 'failed',
  Alert-nya di handle dengan Alert.

  Status failed bisa di pastikan tidak di set oleh class http.
  Tapi class Api.
  */

  failed,
}

class ApiResponse {
  ApiStatus status;
  dynamic data;
  String message;

  String url;

  ApiResponse({
    @required this.status,
    this.data,
    this.message,
    this.url,
  });
}

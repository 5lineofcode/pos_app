import 'package:pos_app/core.dart';
import 'package:pos_app/shared/utils/http_api/https.dart';

class DynamicSubmitter {
  static create(String datasource, postData) async {
    var url = "${AppSession.baseUrl}$datasource";
    await https.post(
      url,
      postData: postData,
    );
  }
}

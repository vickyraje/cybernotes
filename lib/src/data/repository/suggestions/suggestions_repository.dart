import 'package:cybernotes/src/common/api_services.dart';
import 'package:cybernotes/src/common/app_config.dart';
import 'package:cybernotes/src/common/http_client.dart';
import 'package:cybernotes/src/data/models/suggestions/base_model.dart';

class SuggestionsRepository {
  Future<BaseModel> sendRequest(req) async {
    final Map json = await HTTPClient().postJSONRequest(
      url: AppConfig.baseUrl + ApiServices.suggest,
      data: req,
    );
    return BaseModel.fromJson(json);
  }
}

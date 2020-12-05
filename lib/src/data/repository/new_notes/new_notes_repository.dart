import 'package:cybernotes/src/common/api_services.dart';
import 'package:cybernotes/src/common/app_config.dart';
import 'package:cybernotes/src/common/http_client.dart';
import 'package:cybernotes/src/constants/app_constants.dart';
import 'package:cybernotes/src/data/models/suggestions/base_model.dart';

class NewNotesRepository {
  Future<BaseModel> sendRequest(req, path) async {
    // final Map json = await HTTPClient().sendFormData(path);
    // BaseModel fileBasemodel = BaseModel.fromJson(json);
    // if (fileBasemodel.status == AppConstants.SUCCESS) {
    // req['file'] = fileBasemodel.data;
    final Map json = await HTTPClient().postJSONRequest(
      url: AppConfig.baseUrl + ApiServices.saveNote,
      data: req,
    );
    return BaseModel.fromJson(json);
    // } else {
    //   return BaseModel.fromJson(json);
    // }
  }

  Future<BaseModel> updateRequest(req, path) async {
    final Map json = await HTTPClient().postJSONRequest(
      url: AppConfig.baseUrl + ApiServices.editNote,
      data: req,
    );
    return BaseModel.fromJson(json);
  }
}

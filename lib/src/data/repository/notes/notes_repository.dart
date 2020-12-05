import 'package:cybernotes/src/common/api_services.dart';
import 'package:cybernotes/src/common/app_config.dart';
import 'package:cybernotes/src/common/http_client.dart';
import 'package:cybernotes/src/data/models/notes/notes_model.dart';

class NotesRepository {
  Future<NotesModel> sendRequest(req) async {
    final Map json = await HTTPClient().postJSONRequest(
      url: AppConfig.baseUrl + ApiServices.openNote,
      data: req,
    );
    return NotesModel.fromJson(json);
  }
}

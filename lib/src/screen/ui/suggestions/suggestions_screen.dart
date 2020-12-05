import 'package:cybernotes/src/constants/app_constants.dart';
import 'package:cybernotes/src/data/models/suggestions/base_model.dart';
import 'package:cybernotes/src/data/repository/suggestions/suggestions_repository.dart';
import 'package:cybernotes/src/data/store/app_store.dart';
import 'package:cybernotes/src/screen/widgets/app_widget_size.dart';
import 'package:cybernotes/src/screen/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:cybernotes/src/screen/styles/app_colors.dart';

class SuggestionsScreen extends StatefulWidget {
  SuggestionsScreen({Key key}) : super(key: key);

  @override
  _SuggestionsScreenState createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController suggestionsController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> sendButtonPressed() async {
    String subject = subjectController.text.trim();
    String suggestion = suggestionsController.text.trim();
    if (subject == '') {
      scaffoldKey.currentState.showSnackBar(
        const SnackBar(
          content: Text(AppConstants.SUBJECT_ERRROR_MSG),
        ),
      );
    } else if (suggestion == '') {
      scaffoldKey.currentState.showSnackBar(
        const SnackBar(
          content: Text(AppConstants.SUGGESTION_ERRROR_MSG),
        ),
      );
    } else {
      Map requestBody = {
        'user_id': AppStore().getUserID(),
        'Subject': subject,
        'decription': suggestion,
      };
      final BaseModel suggestionsModel =
          await SuggestionsRepository().sendRequest(requestBody);
      if (suggestionsModel.status == AppConstants.SUCCESS) {
        subjectController.text = '';
        suggestionsController.text = '';

        scaffoldKey.currentState.showSnackBar(
          const SnackBar(
            content: Text(
              AppConstants.SUGGESTION_SUCCESS_MSG,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Padding(
          child: const Text(AppConstants.SUGGESTIONS),
          padding: const EdgeInsets.only(left: 10, right: 10),
        ),
        backgroundColor: AppColors.darkColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppWidgetSize.bodyPadding),
        child: Column(
          children: [
            TextField(
              controller: subjectController,
              decoration: InputDecoration(
                labelText: AppConstants.SUBJECT,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: AppWidgetSize.dimen_30, bottom: AppWidgetSize.dimen_30),
              child: TextField(
                controller: suggestionsController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: AppConstants.SUGGESTIONS,
                ),
              ),
            ),
            RaisedButton(
              onPressed: sendButtonPressed,
              child: const Text(AppConstants.SEND),
            )
          ],
        ),
      ),
    );
  }
}

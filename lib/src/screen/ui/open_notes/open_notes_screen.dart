import 'package:cybernotes/src/constants/app_constants.dart';
import 'package:cybernotes/src/constants/screen_routes.dart';
import 'package:cybernotes/src/data/models/notes/notes_model.dart';
import 'package:cybernotes/src/data/repository/notes/notes_repository.dart';
import 'package:cybernotes/src/data/store/app_store.dart';
import 'package:cybernotes/src/screen/widgets/app_widget_size.dart';
import 'package:cybernotes/src/screen/widgets/drawer_widget.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter/material.dart';
import 'package:cybernotes/src/screen/styles/app_colors.dart';

class OpenNotesScreen extends StatefulWidget {
  OpenNotesScreen({Key key}) : super(key: key);

  @override
  _OpenNotesScreenState createState() => _OpenNotesScreenState();
}

class _OpenNotesScreenState extends State<OpenNotesScreen> {
  List<Data> notesList = [];

  @override
  void initState() {
    initApiCall();
    super.initState();
  }

  void initApiCall() async {
    Map requestBody = {
      'user_id': AppStore().getUserID(),
    };
    final NotesModel suggestionsModel =
        await NotesRepository().sendRequest(requestBody);
    if (suggestionsModel.status == AppConstants.SUCCESS) {
      setState(() {
        notesList = suggestionsModel.data;
      });
    }
  }

  void voiceNotePressed(item) {
    Navigator.of(context).pushNamed(ScreenRoutes.NOTES_DETAILS,
        arguments: {'notes_details': item});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(AppConstants.NOTES),
        backgroundColor: AppColors.darkColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Icon(Icons.notifications_rounded),
          ),
        ],
      ),
      body: notesList.isNotEmpty
          ? ListView(
              children: List.generate(
                notesList.length,
                (int index) {
                  return buildVoiceCardView(index);
                },
              ),
            )
          : Center(
              child: const Text(AppConstants.EMPTY_SAVED_NOTES),
            ),
    );
  }

  GestureDetector buildVoiceCardView(index) {
    final Data item = notesList[index];
    final String date =
        'Date: ${item.date.split(' ')[0]} Time: ${item.date.split(' ')[1]}';
    return GestureDetector(
      onTap: () => voiceNotePressed(item),
      child: Card(
        margin: EdgeInsets.only(
          top: AppWidgetSize.dimen_15,
          left: AppWidgetSize.dimen_10,
          right: AppWidgetSize.dimen_10,
        ),
        // semanticContainer:false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: Text(
                (index + 1).toString(),
                style: Theme.of(context).textTheme.headline1,
              ),
              title: Text(
                item.title,
                style: Theme.of(context).textTheme.headline1,
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(
                  top: AppWidgetSize.dimen_10,
                ),
                child: Text(
                  date,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:math';
import 'dart:io' as io;
import 'package:cybernotes/src/constants/app_constants.dart';
import 'package:cybernotes/src/constants/screen_routes.dart';
import 'package:cybernotes/src/data/models/notes/notes_model.dart';
import 'package:cybernotes/src/data/models/suggestions/base_model.dart';
import 'package:cybernotes/src/data/repository/new_notes/new_notes_repository.dart';
import 'package:intl/intl.dart';
import 'package:cybernotes/src/data/store/app_store.dart';
import 'package:cybernotes/src/screen/widgets/drawer_widget.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:cybernotes/src/screen/styles/app_colors.dart';

class NewNoteScreen extends StatefulWidget {
  Map arguments;
  NewNoteScreen({this.arguments, Key key}) : super(key: key);

  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  String onChangingText = '';
  String duplicateText = '';
  String storedFinalData = '';
  String combineWord = '';
  TextEditingController speechTextController = TextEditingController();
  TextEditingController _voiceNotesTitleController = TextEditingController();
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String fileName;
  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  LocalFileSystem localFileSystem = LocalFileSystem();
  final f = DateFormat('yyyy-MM-dd hh:mm');
  bool isEdit = false;
  Data data;

  @override
  void initState() {
    super.initState();

    Map arguments = widget.arguments;
    if (arguments != null) {
      data = widget.arguments['data'];
      isEdit = true;
      speechTextController.text = data.description;
      _voiceNotesTitleController.text = data.title;
    }
    initializeSpeech();
  }

  Future<void> initializeSpeech() async {
    bool hasSpeech = await speech.initialize(
      onError: errorListener,
      onStatus: statusListener,
    );

    if (hasSpeech) {
      List<LocaleName> getLocal = [
        LocaleName('ta_IN', 'Tamil'),
        LocaleName('en_IN', 'English'),
      ];
      setState(() {
        _localeNames = getLocal;
        _currentLocaleId = 'ta_IN';
      });
    }
    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    stopListening();
    // Scaffold.of(context).showSnackBar(SnackBar(
    //   content: Text(error.errorMsg),
    //   duration: Duration(seconds: 5),
    // ));
  }

  void statusListener(String status) {
    setState(() {
      lastStatus = '$status';
    });
  }

  void optionActionPressed(String option) {
    if (option == AppConstants.COPY) {}
  }

  void keyboardFocusOut() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Padding(
          child: Text('New Notes'),
          padding: const EdgeInsets.only(left: 10, right: 10),
        ),
        backgroundColor: AppColors.darkColor,
        actions: [
          PopupMenuButton(
            onSelected: onSelectLanguagePressed,
            itemBuilder: (context) {
              List<PopupMenuItem> languageList = [];
              _localeNames.forEach((e) {
                languageList.add(CheckedPopupMenuItem(
                  value: e.localeId,
                  child: Text(e.name),
                  checked: e.localeId == _currentLocaleId,
                ));
              });

              return languageList;
            },
            //icon: Icon(Icons.language),
            child:Padding(
              child: Text('Select Language'),
              padding: const EdgeInsets.only(top: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: PopupMenuButton(
              onSelected: onSelectedOptionPressed,
              itemBuilder: (context) {
                List<PopupMenuItem> optionList = <PopupMenuItem>[
                  PopupMenuItem(
                    value: AppConstants.SAVE,
                    child: Text(AppConstants.SAVE),
                  ),
                  PopupMenuItem(
                    value: AppConstants.PRINT,
                    child: Text(AppConstants.PRINT),
                  ),
                  PopupMenuItem(
                    value: AppConstants.COPY,
                    child: Text(AppConstants.COPY),
                  ),
                  PopupMenuItem(
                    value: AppConstants.SHARE,
                    child: Text(AppConstants.SHARE),
                  ),
                ];
                return optionList;
              },
              icon: Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  child: Text('Start'),
                  onPressed:
                      !_hasSpeech || speech.isListening ? null : startListening,
                ),
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: .26,
                        spreadRadius: speech.isListening ? level * 1.1 : 0,
                        color: Colors.black.withOpacity(.05),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.mic),
                  ),
                ),
                FlatButton(
                  child: Text('Stop'),
                  onPressed: speech.isListening ? stopListening : null,
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 50),
                  color: Theme.of(context).selectedRowColor,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    child: TextField(
                      maxLines: null,
                      onChanged: (text) {
                        combineWord = text;
                      },
                      controller: speechTextController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Speech to Text',
                      ),
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 10,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Text(
                            'Dot',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          onPressed: () {
                            speechTextController.text =
                                speechTextController.text + '.';
                            combineWord = speechTextController.text;
                          },
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Text(
                            'Comma',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          onPressed: () {
                            speechTextController.text =
                                speechTextController.text + ',';
                            combineWord = speechTextController.text;
                          },
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Text(
                            'Next',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          onPressed: () {
                            speechTextController.text =
                                speechTextController.text + '\n';
                            combineWord = speechTextController.text;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(vertical: 20),
          //   color: Theme.of(context).backgroundColor,
          //   child: Center(
          //     child: speech.isListening
          //         ? Text(
          //             onChangingText,
          //             style: TextStyle(fontWeight: FontWeight.bold),
          //           )
          //         : Text(
          //             'Not listening',
          //             style: TextStyle(fontWeight: FontWeight.bold),
          //           ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();

    return directory.path;
  }

  void startListening() {
    keyboardFocusOut();
    lastError = '';
    speech.listen(
      onResult: resultListener,
      localeId: _currentLocaleId,
      onSoundLevelChange: soundLevelListener,
      cancelOnError: false,
      listenMode: ListenMode.confirmation,
    );
  }

  void stopListening() {
    keyboardFocusOut();
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    if (result.finalResult) {
      storedFinalData = result.recognizedWords;

      combineWord =
          (combineWord != '' ? (combineWord + ' ') : '') + storedFinalData;
      speechTextController
        ..text = combineWord
        ..selection = TextSelection.collapsed(offset: combineWord.length);
      keyboardFocusOut();
    } else {
      speechTextController
        ..text = (combineWord != '' ? combineWord + ' ' : '') +
            result.recognizedWords
        ..selection =
            TextSelection.collapsed(offset: result.recognizedWords.length);
    }
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print('sound level $level: $minSoundLevel - $maxSoundLevel ');
    setState(() {
      this.level = level;
    });
  }

  void onSelectLanguagePressed(dynamic selectedVal) {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    setState(() {
      _currentLocaleId = selectedVal;
    });
    print(selectedVal);
  }

  Future<void> doneButtonPressed() async {
    Navigator.of(context).pop();
    String voiceNotes = _voiceNotesTitleController.text.trim();
    final String textString = speechTextController.text.trim();
    final DateTime dateValue = DateTime.now();
    String currentDate = f.format(dateValue);
    if (voiceNotes == '') {
      showAlert(AppConstants.VOICE_NOTE_TITLE_ERROR_MSG);
    } else {
      // stop(callBack: (String path) async {
      Map requestBody = {
        'user_id': AppStore().getUserID(),
        'title': voiceNotes,
        'description': textString,
        'date': currentDate,
        'file': ''
      };
      final BaseModel suggestionsModel =
          await NewNotesRepository().sendRequest(requestBody, '');
      if (suggestionsModel.status == AppConstants.SUCCESS) {
        showAlert(AppConstants.SAVE_NOTE_SUCCESS_MSG, callBack: () {
          Navigator.of(context).pushReplacementNamed(ScreenRoutes.OPEN_NOTES);
        });
      } else {
        showAlert(suggestionsModel.data);
      }
      // });
    }
  }

  Future<void> showAlert(String msg, {Function callBack}) async {
    scaffoldKey.currentState
        .showSnackBar(
          SnackBar(
            content: Text(msg),
          ),
        )
        .closed
        .then((SnackBarClosedReason onValue) {
      if (callBack != null) {
        callBack();
      }
    });
  }

  Future<void> onSelectedOptionPressed(dynamic selectedVal) async {
    final String textString = speechTextController.text.trim();
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

    if (textString != null && textString != '') {
      if (selectedVal == AppConstants.COPY) {
        Clipboard.setData(ClipboardData(text: textString));
        showAlert(AppConstants.CLIPBOARD_COPY_MSG);
      } else if (selectedVal == AppConstants.SHARE) {
        Share.share(textString);
      } else if (selectedVal == AppConstants.PRINT) {
        final path = await _localPath;
        final namPath = '$path/text_file.text';
        final io.File fileDetails = io.File(namPath);
        fileDetails.writeAsString(textString);
        Share.shareFiles([namPath]);
        // final doc = pw.Document();
        // final ByteData font =
        //     await rootBundle.load('lib/src/assets/fonts/Catamaran-Regular.ttf');
        // final pw.Font ttf = pw.Font.ttf(font);
        // doc.addPage(
        //   pw.Page(
        //     theme: pw.ThemeData.withFont(base: ttf),
        //     pageFormat: PdfPageFormat.a4,
        //     build: (pw.Context context) {
        //       return pw.Container(
        //         child: pw.Text(textString),
        //       );
        //     },
        //   ),
        // );
        // await Printing.layoutPdf(
        //     onLayout: (PdfPageFormat format) async => doc.save());
      } else {
        if (!isEdit) {
          _voiceNotesTitleController.clear();
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext bct) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter updateState) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                    child: _buildTitleWidget(bct, updateState),
                  );
                },
              );
            },
          );
        } else {
          Map requestBody = data.toJson();
          requestBody['description'] = textString;
          final BaseModel suggestionsModel =
              await NewNotesRepository().updateRequest(requestBody, '');
          if (suggestionsModel.status == AppConstants.SUCCESS) {
            showAlert(suggestionsModel.data, callBack: () {
              Navigator.of(context)
                  .pushReplacementNamed(ScreenRoutes.OPEN_NOTES);
            });
          } else {
            showAlert(suggestionsModel.data);
          }
        }
      }
    } else {
      showAlert(AppConstants.EMPTY_NOTES);
    }
  }

  Widget _buildTitleWidget(BuildContext context, StateSetter updateState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          AppConstants.VOICE_NOTES_TITLE,
          style: Theme.of(context).textTheme.headline2,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
          ),
          child: TextField(
            style: Theme.of(context).textTheme.headline3,
            // autofocus: true,
            controller: _voiceNotesTitleController,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).pop(), // closing showModalBottomSheet
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    AppConstants.CANCEL,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
              GestureDetector(
                onTap: doneButtonPressed,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text(
                    AppConstants.DONE,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

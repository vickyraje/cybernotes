import 'package:audioplayers/audioplayers.dart';
import 'package:cybernotes/src/common/app_config.dart';
import 'package:cybernotes/src/constants/app_constants.dart';
import 'package:cybernotes/src/constants/screen_routes.dart';
import 'package:cybernotes/src/data/models/notes/notes_model.dart';
import 'package:cybernotes/src/screen/widgets/app_widget_size.dart';
import 'package:cybernotes/src/screen/widgets/player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share/share.dart';
import 'package:pdf/pdf.dart';
import 'dart:io' as io;
import 'package:cybernotes/src/screen/styles/app_colors.dart';

class NoteDetailsScreen extends StatefulWidget {
  Map arguments;
  NoteDetailsScreen(this.arguments, {Key key}) : super(key: key);

  @override
  _NoteDetailsScreenState createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  Data noteDetails;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    noteDetails = widget.arguments['notes_details'];
    super.initState();
  }

  Future<void> showAlert(String msg, {Function callBack}) async {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
    if (callBack != null) {
      callBack();
    }
  }

  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();

    return directory.path;
  }

  Future<void> onSelectedOptionPressed(dynamic selectedVal) async {
    final String textString = noteDetails.description;
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
      } else if (selectedVal == AppConstants.PLAY) {
        String url = AppConfig.baseUrl + noteDetails.file;

        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          builder: (BuildContext context) {
            return PlayerWidget(url: url);
          },
        );
      } else if (selectedVal == AppConstants.EDIT) {
        Navigator.of(context).pushNamed(ScreenRoutes.NEW_NOTE,
            arguments: {'type': AppConstants.EDIT, 'data': noteDetails});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          noteDetails.title,
        ),
        backgroundColor: AppColors.darkColor,
        actions: [
          PopupMenuButton(
            onSelected: onSelectedOptionPressed,
            itemBuilder: (context) {
              List<PopupMenuItem> optionList = <PopupMenuItem>[
                PopupMenuItem(
                  value: AppConstants.EDIT,
                  child: Text(AppConstants.EDIT),
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
                  value: AppConstants.SEND,
                  child: Text(AppConstants.SEND),
                ),
                PopupMenuItem(
                  value: AppConstants.DELETE,
                  child: Text(AppConstants.DELETE),
                ),
              ];
              return optionList;
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(AppWidgetSize.dimen_16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: AppWidgetSize.dimen_10,
                  bottom: AppWidgetSize.dimen_15,
                ),
                child: Text(
                  AppConstants.NOTES,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Text(
                noteDetails.description,
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

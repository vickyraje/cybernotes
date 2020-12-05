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
import 'package:cybernotes/src/screen/styles/app_colors.dart';
import 'package:pdf/pdf.dart';
import 'dart:io' as io;

class PrivacyScreen extends StatefulWidget {
  PrivacyScreen({Key key}) : super(key: key);

  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Privacy & Policy'),
        backgroundColor: AppColors.darkColor,
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
                child: Text('We value and protect your privacy to higher extend at technical prospects. We dont take or keep any data that is not for the sole purpose of what this app does, but, we do use your devices speech recognition services, which are provided by other unaffiliated companies, which might use your speech according to their own policies. In order to transcribe your voice, we use your devices Androids built-in SpeechRecognizer. Therefore, everything you say might be sent to any Speech Recognition Service enabled on your Android device, and these services might use that speech according to their own independent policies. We are not and cannot be, in any way, responsible to how these speech recognition services enabled on your device use your speech. (On most devices you should be able to view and change your devices speech recognition services through your devices Settings.) Your notes and preferences are stored on the devices storage, therefore are accessible to anyone who has access to your device or its storage. \n We do our best to develop the best apps, but, as with any software, we might have errors and furthermore, we rely on Google as our service provider, and Android as our speech recognition engine. \nDisclaimers and Limitations of Liability \n THE APP IS PROVIDED AS IS ON AS AVAILABLE; BASIS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE DEVELOPERS OR AUTHORS OR COPYRIGHT HOLDERS OR DISTRIBUTORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE APP OR THE USE OR OTHER DEALINGS IN THE APP.\n The use of this app and services are at your own risk. The makers, owners and distributors of the app make no warranty and disclaim all responsibility and liability for any direct or indirect cost or damage caused by using this app or service, including but not limited to: (1) lost content (2) damage to your device (3) deletion or failure to store content or information (4) errors in the service (5) errors in content (6) availability or security of the service.',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

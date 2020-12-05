import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cybernotes/src/screen/Widget/bezierContainer.dart';
import 'package:cybernotes/src/screen/ui/payment/paymentPage.dart';
import 'package:cybernotes/src/screen/ui/login/loginPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:device_info/device_info.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool visible = false; String deviceId = '';

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  @override
  void initState() {
    _getId();
    super.initState();
  }

  _getId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    deviceId = androidDeviceInfo.androidId; // unique ID on Android
  }

  Future newRegister() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });
    // Getting value from Controller
    String name = nameController.text;
    String address = addressController.text;
    String city = cityController.text;
    String email = emailController.text;
    String mobile = mobileController.text;
    String password = passwordController.text;
    String confirm = confirmController.text;
    if(mobile.length==10){
      // SERVER LOGIN API URL
      var url = 'https://lemongrocer.com/app/voice_insert.php';
      // Store all data with Param Name.
      var data = { 'name': name, 'address': address, 'city': city, 'email': email, 'mobile': mobile, 'password': password, 'confirm': confirm, 'deviceid': deviceId,'type':''};
      // Starting Web API Call.
      var response = await http.post(url, body: json.encode(data));
      // Getting Server response into variable.
      final messages = jsonDecode(response.body);print(messages);
      final res = messages['message'];
      // If the Response Message is Matched.
      if (res == 'Success') {
        // Hiding the CircularProgressIndicator.
        setState(() {
          visible = false;
        });
        // ignore: non_constant_identifier_names
        var HtmlCode = messages['paymentLink'];
        // Navigate to Profile Screen & Sending Email to Next Screen.
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => paymentPage(HtmlCode)));
      } else {
        print(messages);
        // If Email or Password did not Matched.
        // Hiding the CircularProgressIndicator.
        setState(() {
          visible = false;
        });
        // Showing Alert Dialog with Response JSON Message.
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(messages['message']),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });
      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Mobile No must be 10 Digits'),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future newFreeRegister() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });
    // Getting value from Controller
    String name = nameController.text;
    String address = addressController.text;
    String city = cityController.text;
    String email = emailController.text;
    String mobile = mobileController.text;
    String password = passwordController.text;
    String confirm = confirmController.text;
    // SERVER LOGIN API URL
    var url = 'https://lemongrocer.com/app/voice_insert.php';
    // Store all data with Param Name.
    var data = { 'name': name, 'address': address, 'city': city, 'email': email, 'mobile': mobile, 'password': password, 'confirm': confirm, 'deviceid': deviceId,'types':'Free Trial'};
    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    final messages = jsonDecode(response.body);
    var res = messages['message'];
    // If the Response Message is Matched.
    if (res == 'Success') {
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });
      // ignore: non_constant_identifier_names
      // Navigate to Profile Screen & Sending Email to Next Screen.
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });
      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(res),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(TextEditingController cont1, String title,
      {bool isPassword = false}) {
    var Types='';
    /*if(title=='Mobile') { Types = TextInputType.number; } else { Types = TextInputType.text; }*/
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: cont1,
              //keyboardType: Types,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: RaisedButton(
          onPressed: () {
            newRegister();
          },
          color: Color((0xfbb44800)),
          child: Text(
            'Register & Pay',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ));
  }

  Widget _freeTrialButton() {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: RaisedButton(
          onPressed: () {
            newFreeRegister();
          },
          color: Color((0xfbb44800)),
          child: Text(
            'Take Free Trial',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ));
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Cy',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'ber',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'not',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
            TextSpan(
              text: 'es',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField(nameController, "Name"),
        _entryField(addressController, "Address"),
        _entryField(cityController, "City"),
        _entryField(emailController, "Email"),
        _entryField(mobileController, "Mobile"),
        _entryField(passwordController, "Password", isPassword: true),
        _entryField(confirmController, "Confirm Password", isPassword: true),
      ],
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    SizedBox(height: 10),
                    _divider(),
                    _freeTrialButton(),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
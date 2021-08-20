import 'package:flutter/material.dart';
import 'package:women_safety_app/helper_functions/shared_preference.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _messageHead;
  int _sosDelayTime;
  int _sosRepeatInterval;
  TextEditingController _messageHeadController;
  TextEditingController _sosDelayTimeController;
  TextEditingController _sosRepeatIntervalController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildMessageHead() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'SOS Message'),
      maxLength: 160,
      controller: _messageHeadController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'SOS Message is Required';
        }
        return null;
      },
      onSaved: (String value) async {
        _messageHead = value;
        await SharedPreferenceHelper.saveMessageHead(value);
      },
    );
  }

  Widget _buildSOSdelayTime() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'SOS delay time (seconds)'),
      keyboardType: TextInputType.number,
      controller: _sosDelayTimeController,
      validator: (String value) {
        int sosDelayTime = int.tryParse(value);

        if (sosDelayTime == null || sosDelayTime <= 0) {
          return 'SOS delay time must be greater than 0';
        }

        return null;
      },
      onSaved: (String value) async {
        _sosDelayTime = int.tryParse(value);
        await SharedPreferenceHelper.saveSOSdelayTime(int.tryParse(value));
      },
    );
  }

  Widget _buildSOStimeInterval() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'SOS time Interval (seconds)'),
      keyboardType: TextInputType.number,
      controller: _sosRepeatIntervalController,
      validator: (String value) {
        int sosTimeInterval = int.tryParse(value);

        if (sosTimeInterval == null || sosTimeInterval <= 0) {
          return 'SOS time Interval must be greater than 0';
        }

        return null;
      },
      onSaved: (String value) async {
        _sosRepeatInterval = int.tryParse(value);
        await SharedPreferenceHelper.saveSOSrepeatInterval(int.tryParse(value));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    SharedPreferenceHelper.getMessageHead().then((value) async {
      if (value != null) {
        print('MessageHead is $value');
      } else {
        print('MessageHead is $value');
        value = "I'm in trouble, plz help me. Reach this location:";
        SharedPreferenceHelper.saveMessageHead(value);
      }
      setState(() {
        _messageHead = value;
      });
      _messageHeadController = TextEditingController(text: _messageHead);
    });

    SharedPreferenceHelper.getSOSdelayTime().then((value) async {
      if (value != null) {
        print('SOSdelayTime is $value');
      } else {
        print('SOSdelayTime is $value');
        value = 10;
        SharedPreferenceHelper.saveSOSdelayTime(value);
      }
      setState(() {
        _sosDelayTime = value;
      });
      _sosDelayTimeController = TextEditingController(text: _sosDelayTime.toString());
    });

    SharedPreferenceHelper.getSOSrepeatInterval().then((value) async {
      if (value != null) {
        print('SOS repeat interval is $value');
      } else {
        print('SOS repeat interval is $value');
        value = 120;
        SharedPreferenceHelper.saveSOSrepeatInterval(value);
      }
      setState(() {
        _sosRepeatInterval = value;
      });
      _sosRepeatIntervalController = TextEditingController(text: _sosRepeatInterval.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildMessageHead(),
                _buildSOSdelayTime(),
                _buildSOStimeInterval(),
                SizedBox(height: 100),
                RaisedButton(
                  child: Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    _formKey.currentState.save();

                    SharedPreferenceHelper.saveMessageHead(_messageHead);
                    SharedPreferenceHelper.saveSOSdelayTime(_sosDelayTime);
                    SharedPreferenceHelper.saveSOSrepeatInterval(_sosRepeatInterval);
                  },
                ),
                // RaisedButton(
                //   child: Text(
                //     'RESET Shared Prefs',
                //     style: TextStyle(color: Colors.blue, fontSize: 16),
                //   ),
                //   onPressed: () {
                //     SharedPreferenceHelper.clearData();
                //   },
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

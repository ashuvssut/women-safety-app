import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:women_safety_app/services/shared_preferences.dart';
import 'package:women_safety_app/services/sos_methods.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _messageHead = SosMethods.messageHead;
  int _sosDelayTime = SosMethods.sosDelayTime;
  int _sosRepeatInterval = SosMethods.sosRepeatInterval;
  TextEditingController? _messageHeadController;
  TextEditingController? _sosDelayTimeController;
  TextEditingController? _sosRepeatIntervalController;

  final _formKey = GlobalKey<FormState>();

  Widget _buildMessageHead() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'SOS Message'),
      maxLength: 160,
      controller: _messageHeadController,
      validator: (value) {
        if (value == null || value.isEmpty) return 'SOS Message is Required';
        return null;
      },
      onSaved: (value) async {
        if (value == null || value.isEmpty) value = SosMethods.messageHead;
        _messageHead = value;
        await SharedPreferenceHelper.saveMessageHead(value);
      },
    );
  }

  Widget _buildSOSdelayTime() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'SOS delay time (seconds)'),
      keyboardType: TextInputType.number,
      controller: _sosDelayTimeController,
      validator: (value) {
        int? sosDelayTime = int.tryParse(value!);
        if (sosDelayTime == null || sosDelayTime <= 0) {
          return 'SOS delay time must be greater than 0';
        }
        return null;
      },
      onSaved: (value) async {
        int? val = int.tryParse(value!);
        if (val == null || val <= 0) {
          Fluttertoast.showToast(
              msg:
                  'Invalid SOS delay time, setting to default value ${SosMethods.sosDelayTime} seconds');
          val = SosMethods.sosDelayTime;
        }
        _sosDelayTime = val;
        await SharedPreferenceHelper.saveSOSdelayTime(_sosDelayTime);
      },
    );
  }

  Widget _buildSosTimeInterval() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'SOS time Interval (seconds)'),
      keyboardType: TextInputType.number,
      controller: _sosRepeatIntervalController,
      validator: (value) {
        int? sosTimeInterval = int.tryParse(value!);
        if (sosTimeInterval == null || sosTimeInterval <= 0) {
          return 'SOS time Interval must be greater than 0';
        }
        return null;
      },
      onSaved: (value) async {
        int? val = int.tryParse(value!);
        if (val == null || val <= 0) {
          Fluttertoast.showToast(
            msg:
                'Invalid SOS time Interval, setting to default value ${SosMethods.sosRepeatInterval} seconds',
          );
          val = SosMethods.sosRepeatInterval;
        }
        _sosRepeatInterval = val;
        await SharedPreferenceHelper.saveSOSrepeatInterval(_sosRepeatInterval);
      },
    );
  }

  @override
  void initState() {
    super.initState();

    SosMethods.initializeMessageHead().then((value) {
      setState(() => _messageHead = value);
      _messageHeadController = TextEditingController(text: value);
    });
    SosMethods.initializeSosDelayTime().then((value) {
      setState(() => _sosDelayTime = value);
      _sosDelayTimeController = TextEditingController(text: value.toString());
    });
    SosMethods.initializeSosRepeatInterval().then((value) {
      setState(() => _sosRepeatInterval = value);
      _sosRepeatIntervalController = TextEditingController(text: value.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Settings", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildMessageHead(),
                _buildSOSdelayTime(),
                // _buildSOStimeInterval(),
                const SizedBox(height: 100),
                ElevatedButton(
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    _formKey.currentState!.save();

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

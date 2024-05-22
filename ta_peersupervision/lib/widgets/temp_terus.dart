import 'package:flutter/material.dart';

class DataWidget extends StatefulWidget {
  @override
  _DataWidgetState createState() => _DataWidgetState();
}

class _DataWidgetState extends State<DataWidget> {
  String _data = "Initial Data";

  void _updateData() {
    setState(() {
      _data = "Updated Data";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_data),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            _showPopup(context);
          },
        ),
      ],
    );
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Popup"),
          content: Text("Press the button to update data"),
          actions: <Widget>[
            TextButton(
              child: Text("Update"),
              onPressed: () {
                Navigator.of(context).pop();
                _updateData();
              },
            ),
          ],
        );
      },
    );
  }
}

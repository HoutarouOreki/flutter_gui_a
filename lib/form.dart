import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gui_a/my_text_field.dart';

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final _keyA = GlobalKey<FormFieldState>();
  final _keyB = GlobalKey<FormFieldState>();
  final _keyC = GlobalKey<FormFieldState>();

  bool _aOk = false;
  bool _bOk = false;
  bool _cOk = false;

  void sprawdzFormularz() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.

      // ngl to .. jest piękne <3
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Formularz ok')),
        );
    }
  }

  String wyswietlBladToastOrazPrzekaz(String t) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(t)),
    );
    return t;
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          MyTextField(
            fieldKey: _keyA,
            validator: (value) {
              if (value == null || value.isEmpty) {
                setState(() {
                  _aOk = false;
                });
                return wyswietlBladToastOrazPrzekaz("Imię nie może być puste");
              }
              setState(() {
                _aOk = true;
              });
              return null;
            },
            labelText: "Imię",
          ),
          MyTextField(
            fieldKey: _keyB,
            validator: (value) {
              if (value == null || value.isEmpty) {
                setState(() {
                  _bOk = false;
                });
                return wyswietlBladToastOrazPrzekaz(
                    "Nazwisko nie może być puste");
              }
              setState(() {
                _bOk = true;
              });
              return null;
            },
            labelText: "Nazwisko",
          ),
          MyTextField(
            fieldKey: _keyC,
            validator: (value) {
              if (value == null || value.isEmpty) {
                setState(() {
                  _cOk = false;
                });
                return wyswietlBladToastOrazPrzekaz(
                    'Musisz wprowadzić liczbę ocen.');
              }
              int? liczba = int.tryParse(value);
              if (liczba == null) {
                setState(() {
                  _cOk = false;
                });
                return wyswietlBladToastOrazPrzekaz(
                    'Musisz wprowadzić liczbę ocen');
              }
              if (liczba < 5 || liczba > 15) {
                setState(() {
                  _cOk = false;
                });
                return wyswietlBladToastOrazPrzekaz(
                    'Liczba ocen musi być z przedziału [5;15]');
              }
              setState(() {
                _cOk = true;
              });
              return null;
            },
            labelText: "Liczba ocen",
            textInputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          SizedBox.fromSize(size: const Size(0, 20)),
          Visibility(
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                sprawdzFormularz();
              },
              child: const Text("Oceny"),
            ),
            maintainState: false,
            maintainAnimation: false,
            maintainInteractivity: false,
            visible: () {
              return _aOk && _bOk && _cOk;
            }(),
            replacement: ElevatedButton(
              onPressed: sprawdzFormularz,
              child: const Text("Sprawdź"),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepOrange)),
            ),
          ),
          SizedBox.fromSize(size: const Size(0, 50))
        ],
      ),
    );
  }
}

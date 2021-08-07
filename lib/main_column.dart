import 'package:datos_03/helpers/user_preference.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  UserPreference userPreference = UserPreference(); // new
  await userPreference.initPrefers();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final ageController = TextEditingController();

  List<String> myMusic = [];

  Column column = Column(
    children: [],
  );

  UserPreference userPreference = UserPreference();

  @override
  void initState() {
    UserPreference userPreference = UserPreference();

    nameController.text = userPreference.name;
    surnameController.text = userPreference.surname;
    ageController.text = "${userPreference.age}";

    myMusic = userPreference.favoriteMusic;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print("build");

    formTop();
    musicCheckbox();
    formFooter();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("App para guardar datos 03"),
        ),
        body: Container(
          child: column,
          padding: EdgeInsets.all(8),
        ),
      ),
    );
  }

  formTop() {
    column.children.addAll(
      [
        TextField(
          controller: nameController,
          onChanged: (String value) {
            userPreference.name = value;
          },
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(4), hintText: "Nombre"),
        ),
        TextField(
          controller: surnameController,
          onChanged: (String value) {
            userPreference.surname = value;
          },
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(4), hintText: "Apellido"),
        ),
        TextField(
          controller: ageController,
          onChanged: (String value) {
            try {
              userPreference.age = int.parse(value);
            } catch (e) {}
          },
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(4), hintText: "Edad"),
        ),
        DropdownButton(
            value: userPreference.married,
            isExpanded: true,
            items: [
              DropdownMenuItem(
                child: Text('Casado'),
                value: true,
              ),
              DropdownMenuItem(
                child: Text('Soltero'),
                value: false,
              ),
            ],
            onChanged: (bool? value) {
              setState(() {
                userPreference.married = value!;
              });
            }),
      ],
    );
  }

  musicCheckbox() {
    List<String> music = ['Rock', 'Pop', 'Clásica', 'Remix'];

    column.children.addAll(
      music
          .map(
            (m) => CheckboxListTile(
                title: Text(m),
                secondary: Icon(Icons.music_note),
                activeColor: Colors.redAccent,
                //checkColor: Colors.orange,
                value: myMusic.indexOf(m) >= 0,
                onChanged: (_) {
                  if (myMusic.indexOf(m) < 0) {
                    myMusic.add(m);
                  } else {
                    myMusic.remove(m);
                  }

                  userPreference.favoriteMusic = myMusic;

                  setState(() {});
                }),
          )
          .toList(),
    );
  }

  formFooter() {
    column.children.addAll([
      Spacer(),
      FlatButton(
          textColor: Colors.white,
          color: Colors.red,
          //onPressed: userPreference.clean,
          onPressed: () {
            setState(() {
              nameController.text = "";
              surnameController.text = "";
              ageController.text = "0";
              myMusic = [];
              userPreference.clean();
            });
          },
          child: Text("Limpiar"))
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserState()),
        ChangeNotifierProvider(create: (_) => SettingsState()),
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MainHeader(),
      ),
      body: MainBody(),
    );
  }
}

class MainHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(
      builder: (context, userState, _) {
        return Text(
          'This is Header for ${userState.user}',
        );
      },
    );
  }
}

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Consumer<UserState>(
            builder: (context, userState, _) {
              return TextField(
                onChanged: (value) {
                  print(value);
                  userState.setUser(value);
                },
              );
            },
          ),
          Consumer<UserState>(
            builder: (context, userState, _) {
              return Text(
                'This is body for ${userState.user}',
              );
            },
          ),
          Admin(),
          Consumer<SettingsState>(
            builder: (context, settingsState, _) {
              return Checkbox(
                value: settingsState.admin,
                onChanged: (value) {
                  settingsState.toggleAdmin();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provider.of<SettingsState>(context).admin
          ? Text('User is admin')
          : Text('User is NOT admin'),
    );
  }
}

class UserState with ChangeNotifier {
  String user = 'Avinash Utekar';

  void setUser(String name) {
    user = name;
    notifyListeners();
  }
}

class SettingsState with ChangeNotifier {
  bool admin = false;

  void toggleAdmin() {
    admin = !admin;
    notifyListeners();
  }
}

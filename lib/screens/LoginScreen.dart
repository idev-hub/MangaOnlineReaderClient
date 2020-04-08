import 'package:flutter/material.dart';
import 'package:mangaonline/screens/ExploreScreen.dart';
import 'package:mangaonline/services/users/UserService.dart';
import 'package:mangaonline/widgets/others/MangaOnlineAppBar.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controllerEmail;
  TextEditingController _controllerPassword;
  List<String> _errors = [];

  @override
  void initState() {
    super.initState();

    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
  }

  void dispose() {
    super.dispose();

    _controllerEmail.dispose();
    _controllerPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          MangaOnlineAppBar(
            titleText: 'Авторизация',
            backButton: true,
            actions: <Widget>[],
          ),
          Container(
            height: MediaQuery.of(context).size.height - 180,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  controller: _controllerEmail,
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Пароль'),
                  controller: _controllerPassword,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        flex: 8,
                        child: Text(
                          'Нет аккаунта в сервисе манга.онлайн? Создайте новый! Это очень быстро',
                          style: Theme.of(context).textTheme.body1,
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: IconButton(
                          icon: Icon(Icons.chevron_right),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: OutlineButton(
                    child: Text('Войти'),
                    onPressed: () {
                      login(_controllerEmail.text.trim().toLowerCase(), _controllerPassword.text.trim())
                          .then((user) {
                        if (user.containsKey('errors')) {
                          List<String> __errors = [];
                          (user['errors'] as Map).forEach((key, val){
                            __errors.add(val.toString().replaceAll('[', '').replaceAll(']', ''));
                          });

                          setState(() {
                            _errors = __errors;
                          });
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExploreScreen()));
                        }
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: (_errors.length>0)?_errors.map((error){
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(error),
                      );
                    }).toList():[],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

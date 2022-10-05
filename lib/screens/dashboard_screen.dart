import 'package:flutter/material.dart';
import 'package:pm2022/provider/theme_screen.dart';
import 'package:pm2022/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  Future<void> sesionClose(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? ban = prefs.getBool('ban');
    print('Este es el valor de ban en el dash $ban');
    await prefs.setBool('ban', false);
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return LoginScreen();
    }), (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 207, 189, 131),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/cup3.jpg'),
                        fit: BoxFit.cover)),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/cuphead.png'),
                  backgroundColor: Color.fromARGB(255, 207, 189, 131),
                ),
                accountName: Text(
                  'Andrés Morales Martínez',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                accountEmail: Text('18030666@itcelaya.edu.mx')),
            ListTile(
              leading: Image.asset('assets/smartphone.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Base de datos'),
              onTap: () {
                
              },
            ),
            ListTile(
              leading: Image.asset('assets/smartphone.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('List Task'),
              onTap: () {
                Navigator.pushNamed(context, '/task');
              },
            ),
            ListTile(
              leading: Image.asset('assets/smartphone.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Popular Movies'),
              onTap: () {
                Navigator.pushNamed(context, '/popular');
              },
            ),
            ListTile(
              leading: Image.asset('assets/logout.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Log Out'),
              onTap: () {
                sesionClose(context);
              },
            ),
          ],
        ),
      ),
      body: ThemeScreen(),
    );
  }
}

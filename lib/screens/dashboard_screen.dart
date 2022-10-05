import 'package:flutter/material.dart';
import 'package:pm2022/provider/theme_screen.dart';
import 'package:pm2022/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
                        image: AssetImage('assets/cup3.jpg'), //Portada
                        fit: BoxFit.cover)),
                currentAccountPicture: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => HeroScreen(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child){
                        return child;
                      }
                    ),
                  ),
                  child: Hero(
                    tag: 's2',
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/cuphead.png'),  //Perfil
                      backgroundColor: Color.fromARGB(255, 207, 189, 131),
                    ),
                  ),
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

class HeroScreen extends StatefulWidget {
  const HeroScreen({Key? key}) : super(key: key);

  @override
  State<HeroScreen> createState() => _HeroScreenState();
}

class _HeroScreenState extends State<HeroScreen> {
  final double coverHeight = 280;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
        ],
        ),
    );
  }

  Widget buildTop(){
    final bottom = profileHeight/2;
    final top = coverHeight - profileHeight/2;
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: bottom),
            child: buildCoverImage()
            ),
          Positioned(
            top: top,
            child: buildProfileImage()
            ),
        ],
      );
  }

  Widget buildCoverImage() => Container(
    child: Image.network('https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/cd3e8e66-eda2-4f0d-be39-bc552489c1c4/ddyoev8-83bead08-4664-4818-b06a-0d4123ba15f6.jpg/v1/fill/w_1275,h_626,q_70,strp/cuphead___elder_kettle_s_indoor_house_background_by_berryviolet_ddyoev8-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NjI5IiwicGF0aCI6IlwvZlwvY2QzZThlNjYtZWRhMi00ZjBkLWJlMzktYmM1NTI0ODljMWM0XC9kZHlvZXY4LTgzYmVhZDA4LTQ2NjQtNDgxOC1iMDZhLTBkNDEyM2JhMTVmNi5qcGciLCJ3aWR0aCI6Ijw9MTI4MCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.MCMctYA9P6SHmjY30-XcQJOU6eKly4rnmSPY4U01kHU',
    width: double.infinity,
    height: coverHeight,
    fit: BoxFit.cover,
    ),
  );

  Widget buildProfileImage() => 
  Hero(
    tag: 's2',
    child: CircleAvatar(
      radius: profileHeight/2,
      backgroundImage: AssetImage('assets/cuphead.png'),
    ),
  );

  Widget buildContent() => Column(
    children: [
      const SizedBox(height: 8),
      Text(
        "Andrés Morales Martínez", 
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      const SizedBox(height: 8),
      Text(
        "18030666@itcelaya.edu.mx", 
        style: TextStyle(fontSize: 20, color: Colors.black54),
        ),
      const SizedBox(height: 8),
      Text(
        "4612917743", 
        style: TextStyle(fontSize: 20, color: Colors.black54),
        ),
      const SizedBox(height: 8),
      Text(
        "https://github.com/andresLM20/PM2022", 
        style: TextStyle(fontSize: 20, color: Colors.black54),
        ),
        const SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _launchUrl('https://www.facebook.com/logands20'),
              child: CircleAvatar(
                radius: 25,
                child: Center(child: Icon(FontAwesomeIcons.facebook,size: 32,),),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => _launchUrl('https://github.com/andresLM20'),
              child: CircleAvatar(
                radius: 25,
                child: Center(child: Icon(FontAwesomeIcons.github,size: 32,),),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => _launchUrl('https://www.instagram.com/logan_ds20/'),
              child: CircleAvatar(
                radius: 25,
                child: Center(child: Icon(FontAwesomeIcons.instagram,size: 32,),),
              ),
            ),
          ],
        )
    ]
  );

  _launchUrl(String url) async{
    await launch(url);
  }
}
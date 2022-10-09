import 'package:flutter/material.dart';
import 'package:pm2022/screens/dashboard_screen.dart';
import 'package:pm2022/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}):super(key:key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller=PageController();
  bool isLastPage = false;
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  Widget buildPage({
    required Color color,
    required String urlImage,
    required String title,
    required String subtitle,
  })=> Container(
    color : color ,
    child : Column (
    mainAxisAlignment : MainAxisAlignment.center ,
      children : [
        Image.asset (
          urlImage ,
          fit : BoxFit.cover ,
          width : double.infinity ,
        ),
        const SizedBox ( height : 64 ),
        Text (
          title,
          style : TextStyle (
            color : Color.fromARGB(255, 0, 0, 0),
            fontSize : 32 ,
            fontWeight : FontWeight.bold,
          ),
        ),
        const SizedBox ( height : 24 ) ,
        Container (
          padding : const EdgeInsets.symmetric (horizontal:20),
          child : Text (
            subtitle ,
            style : TextStyle (color: Color.fromARGB(255, 0, 0, 0),fontSize: 17),
          ) , 
        ) ,
      ],
    ),
  );


  @override
  Widget build(BuildContext context) => Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index){
            setState(
              ()=> isLastPage = index == 2
            );
          },
          children:[
            buildPage(
              color : Color.fromARGB(255, 241, 236, 78),
              urlImage : 'assets/img1.png',
              title : 'CUPHEAD',
              subtitle :
                  'Cuphead es un juego de acción clásico estilo "dispara y corre" que se centra en combates contra el jefe. Inspirado en los dibujos animados de los años 30, los aspectos visual y sonoro están diseñados con esmero empleando las mismas técnicas de la época.',
            ),
            buildPage(
              color : Color.fromARGB(255, 241, 236, 78),
              urlImage : 'assets/img2.png',
              title : 'BATALLAS',
              subtitle :
                  'Sin ninguna duda las batallas contra estos jefes son uno de los puntos más destacados de Cuphead. En total son cerca de 20 combates los que libraremos durante todo el juego.',
            ),
            buildPage(
              color : Color.fromARGB(255, 241, 236, 78),
              urlImage : 'assets/img3.png',
              title : 'JUEGA AHORA',
              subtitle :
                  'Juega como Cuphead o Mugman (en modo de un jugador o cooperativo) y cruza mundos extraños, adquiere nuevas armas, aprende poderosos supermovimientos y descubre secretos ocultos mientras procuras saldar tu deuda con el diablo.',
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
      ? TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            primary: Colors.white,
            backgroundColor: Color.fromARGB(255, 164, 170, 8),
            minimumSize: Size.fromHeight(80),
        ),
        child: Text('Get Started', style: TextStyle(fontSize: 24, color: Colors.black),),
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('showHome', true);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: ((context) => MainScreen()))
          );
        },
      )
      : Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => controller.jumpToPage(2),
              child: Text("Skip",style: TextStyle(color: Color.fromARGB(255, 164, 170, 8)))
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(
                  spacing: 16,
                  dotColor: Colors.black26,
                  activeDotColor: Color.fromARGB(255, 164, 170, 8),
                ),
                onDotClicked: (index) => controller.animateToPage(
                  index, 
                  duration: Duration(milliseconds: 500), 
                  curve: Curves.easeIn),
              ),
            ),
            TextButton(
              onPressed: () => controller.nextPage(
                duration: Duration(milliseconds: 500), 
                curve: Curves.easeInOut), 
              child: Text("Next",style: TextStyle(color: Color.fromARGB(255, 164, 170, 8)),),
            ),
        ]),
      ),
    );
  }
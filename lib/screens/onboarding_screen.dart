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
            color : Colors.teal.shade700,
            fontSize : 32 ,
            fontWeight : FontWeight.bold,
          ),
        ),
        const SizedBox ( height : 24 ) ,
        Container (
          padding : const EdgeInsets.symmetric (horizontal:20),
          child : Text (
            subtitle ,
            style : TextStyle (color: Colors.teal.shade700),
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
              color : Colors.green.shade100,
              urlImage : 'assets/page1.png',
              title : 'REDUCE',
              subtitle :
                  ' Lorem ipsum dolor sit amet , consectetur ad',
            ),
            buildPage(
              color : Colors.green.shade100,
              urlImage : 'assets/page2.png',
              title : 'RECYCLE',
              subtitle :
                  ' Lorem ipsum dolor sit amet , consectetur ad',
            ),
            buildPage(
              color : Colors.green.shade100,
              urlImage : 'assets/page3.png',
              title : 'REUSE',
              subtitle :
                  ' Lorem ipsum dolor sit amet , consectetur ad',
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
            backgroundColor: Colors.teal.shade700,
            minimumSize: Size.fromHeight(80),
        ),
        child: Text('Get Started', style: TextStyle(fontSize: 24),),
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
              child: Text("Skip")
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(
                  spacing: 16,
                  dotColor: Colors.black26,
                  activeDotColor: Colors.teal.shade700,
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
              child: Text("Next")
            ),
        ]),
      ),
    );
  }
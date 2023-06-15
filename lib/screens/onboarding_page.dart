import 'package:flutter/material.dart';
import 'package:flutter_art_sense/screens/main_page.dart';
import 'package:introduction_slider/introduction_slider.dart';
import 'package:flutter_art_sense/widgets/text_widget.dart';



class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionSlider(
        items:  [
          IntroductionSliderItem(
            logo: Text("ArtSense", style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),),
            title: Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextDecoration( fontWeight: FontWeight.bold, fontSize: 25, title: "Welcome to ArtSense",),
                  ),
                ],
              )),
            
            subtitle:  Expanded(
    
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextDecoration(
                title:  "Discover the world's most exquisite art pieces, immerse yourself in the beauty of different art forms, and explore the rich history of art.",
                   fontSize: 17),
              ),
            ),
          
             backgroundImageDecoration:BackgroundImageDecoration(
              image: AssetImage("assets/img/image1.png"),
               colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.4),
        BlendMode.darken,
      ),
            fit: BoxFit.cover,
            opacity: 1.0,
              ),
          ),
          IntroductionSliderItem(
            title: Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextDecoration(title:"Immerse Yourself in Art" , fontSize: 25, fontWeight: FontWeight.bold,),
                  ),
                ],
              )),
           
            subtitle: Expanded(
               flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextDecoration(title: 'Browse through thousands of artworks from various eras and genres', 
                fontSize: 17),
              ),
            ),
           
            backgroundImageDecoration: BackgroundImageDecoration(
              image: AssetImage("assets/img/image2.jpg"),
                  colorFilter: ColorFilter.mode(
               Colors.black.withOpacity(0.4),
                BlendMode.darken,
                ),
            fit: BoxFit.cover,
            opacity: 1.0,
              ),
          ),
          IntroductionSliderItem(
              title: Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(child: Text("Discover the Artists Behind the Art", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),)),
                    ),
                  ],
                )),
                
              subtitle: Expanded(
                flex: 1,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(' Learn about the artists who created the masterpieces you love. Discover their unique styles, inspirations, and techniques',
                    style: TextStyle(color: Colors.white,fontSize: 17),
                    ),
                  ),
                ),
              ),
              backgroundImageDecoration: BackgroundImageDecoration(
                image: AssetImage('assets/img/image3.jpg'),
                     colorFilter: ColorFilter.mode(
               Colors.black.withOpacity(0.4),
                BlendMode.darken,
                ),
            fit: BoxFit.cover,
            opacity: 1.0,
                ),
          ),
    
        ], 
        done: Done(child:Icon(Icons.done, color: Colors.white,), home: MainPage()),
        next: Next(child: Icon(Icons.arrow_forward, color: Colors.white,)),
        back: Back(child: Icon(Icons.arrow_back,color: Colors.white,)),
          dotIndicator: DotIndicator(
            unselectedColor: Colors.white.withOpacity(0.3),
            selectedColor: Colors.white,
    
          ),
          
        ),
    );

  }

  
}
import 'package:flutter/material.dart';
import 'package:flutter_art_sense/screens/main_page.dart';
import 'package:flutter_html/flutter_html.dart';
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
            logo: Text(
             "ArtSense", 
             style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
               color: Colors.white,
               fontFamily: 'PlayfairDisplay-ExtraBold',
               ),),
            title: Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text( 
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay-Bold',
                        fontWeight: FontWeight.bold, 
                         fontSize: 25, 
                         color: Colors.white,
                        ),
                      "Welcome to ArtSense",
                      
                      ),
                  ),
                ],
              )),
            
            subtitle:  Expanded(
    
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "     Discover the world's most exquisite art        pieces, immerse yourself in the beauty of       different art forms, and explore the rich history of art.",
                   style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'PlayfairDisplay-SemiBold',
                    color: Colors.white,
                   ),
                   ),
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
                    child: Text(
                  "Immerse Yourself in Art" ,
                  style: TextStyle(
                     fontSize: 25, 
                     fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay-Bold',
                    color: Colors.white
                  ),
                 ),
                  ),
                ],
              )),
           
            subtitle: Expanded(
               flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Browse through thousands of artworks      from various eras and genres', 
                  style: TextStyle(
                     fontSize: 17,
                     color: Colors.white,
                     fontFamily: 'PlayfairDisplay-SemiBold',
                  ),
               ),
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
                      child: Center(child: Text(
                        "Discover the Artists Behind                           the Art", 
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 25, 
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PlayfairDisplay-Bold',
                          ),)),
                    ),
                  ],
                )),
                
              subtitle: Expanded(
                flex: 1,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(' Learn about the artists who created the masterpieces you love. Discover their unique styles, inspirations, and techniques',
                    style: TextStyle(
                      color: Colors.white,fontSize: 17,
                      fontFamily: 'PlayfairDisplay-SemiBold',
                      ),
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
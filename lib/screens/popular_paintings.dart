import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PopularPaintingScreen extends StatefulWidget {
  const PopularPaintingScreen({super.key});

  @override
  State<PopularPaintingScreen> createState() => _PopularPaintingScreenState();
}

class _PopularPaintingScreenState extends State<PopularPaintingScreen> {

  @override
  Widget build(BuildContext context) {
      var size = MediaQuery.of(context).size;
      final double itemHeight = (size.height - kToolbarHeight - 90) / 2;
      final double itemWidth = size.width / 2;

    return Scaffold(
      body: Expanded(
        child: TabBarView(
          children: [
            Container(
              child:  MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: (){},
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Ca,
                        ),
                      ),

                    ],
                  );
                },
                
              ),
            ),
          ],
        ),
        
        ),
    );
  }
}
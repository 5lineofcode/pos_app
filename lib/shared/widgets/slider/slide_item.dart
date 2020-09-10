import 'package:flutter/cupertino.dart';
import 'package:pos_app/core.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            sliderArrayList[index].sliderImageUrl,
            width: 450,
          ),
          
          
          
          
          
          
          
          
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          sliderArrayList[index].sliderHeading,
          style: TextStyle(
            
            fontWeight: FontWeight.w700,
            fontSize: 20.5,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              sliderArrayList[index].sliderSubHeading,
              style: TextStyle(
                
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
                fontSize: 17,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              sliderArrayList[index].sliderContent,
              style: TextStyle(
                
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
                fontSize: 12.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 100.0,
        ),
      ],
    );
  }
}

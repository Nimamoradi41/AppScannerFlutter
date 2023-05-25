import 'package:appcontact/TextApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BoxIndictor extends StatelessWidget {


  String CountItem;


  BoxIndictor(this.CountItem);

  @override
  Widget build(BuildContext context) {
    return   Container(
       width: 50,
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(8)
       ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 4,),
          SvgPicture.asset('assets/sho.svg',
            width: 40,
            height: 40,
            color: Color(
              0xff3a3a3a),),
          SizedBox(height: 4,),
          Container(
            width: 50,
            margin: EdgeInsets.symmetric(horizontal: 2,vertical: 2),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(6),
                color: Colors.redAccent
            ),
            child: Center(child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(CountItem,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16),),
            )),
          ),

        ],
      ),
    );
  }
}

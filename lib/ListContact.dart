
 import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'ApiService.dart';

 class ListContact extends StatefulWidget {
   const ListContact({Key? key}) : super(key: key);

  @override
  State<ListContact> createState() => _ListContactState();
}

class _ListContactState extends State<ListContact> {
   Future<Null> GetDataRef()async{


     // var Data=await ApiService.Login();

     // print(Data.toJson().toString());



   }

   @override
  void initState() {
    super.initState();
    GetDataRef();
  }
   @override
   Widget build(BuildContext context) {
     return Container(
       color: Color(0xff2F2F2F),
       child: RefreshIndicator(
         onRefresh: GetDataRef,
         child: ListView.builder(
           itemCount: 5,
           itemBuilder: (ctx,item){
             return Container(
               margin: EdgeInsets.all(8),
               width: double.infinity,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(16),
                 border: Border.all(color: Color(0xffD4D4D4),width: 2)
               ),
               child: Padding(
                 padding: const EdgeInsets.symmetric(vertical: 8.0),
                 child: Row(
                   children: [
                     Expanded(child: Row(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                         SizedBox(width: 8,),
                         Expanded(child: Row(
                           crossAxisAlignment: CrossAxisAlignment.end,
                           children: [
                             SvgPicture.asset('assets/call1.svg',width: 25,height: 25,),
                             SizedBox(width: 16,),
                             SvgPicture.asset('assets/del1.svg',width: 25,height: 25,color: Colors.white,),
                             SizedBox(width: 16,),
                             SvgPicture.asset('assets/edit1.svg',width: 25,height: 25,),
                           ],
                         )),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.end,
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Text('نيما مرادي',
                               textAlign:TextAlign.end,
                               style: TextStyle(color: Colors.white,fontSize: 14,),),
                             SizedBox(height: 16,),
                             Text('09909439787',style: TextStyle(color: Color(0xffC9C9C9),fontSize: 14,),),
                           ],
                         )
                       ],
                     )),
                     Container(
                       width: 55,
                       height: 55,
                       margin: EdgeInsets.all(8),
                       decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           color: Color(0xffFF6D60)
                       ),
                       child: Center(child: Text('ن',style: TextStyle(fontSize: 35,color: Colors.white),)),
                     )
                   ],
                 ),
               ),
             );
           },
         ),
       ),
     );
   }
}

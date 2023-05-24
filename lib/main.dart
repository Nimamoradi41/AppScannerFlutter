




import 'dart:async';
import 'dart:ffi';

import 'package:appcontact/AddContact.dart';
import 'package:appcontact/ListContact.dart';
import 'package:appcontact/TextApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'ApiService.dart';
import 'Models/TempOrder.dart';
import 'QRScannerOverlay.dart';

void main() {
  runApp(  MyApp());
}

class MyApp extends StatefulWidget {


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  int _selectedIndex = 1;

  String NameProduct="";
  String Price="0.0";



  String MSg="";
  bool FlaLoading=false;
  Future Run(String S)async{
    FlaLoading=true;
    var s=await ApiService.Login(S);
    print('Eeeroror');
    if(s!=null)
      {
        if(s.success)
          {
            setState(() {
              FlagError=false;
              Price=s.priceKala.toString();
              NameProduct=s.naka.toString();
            });

          }else{
          setState(() {
            FlagError=true;
            MSg=s.msg;
            startTimer();
          });



        }

      }else{
      setState(() {
        startTimer();
        MSg="مشكلي در ارتباط با سرور به وجود آمده";
        FlagError=true;
      });


    }


    FlaLoading=false;
  }




  Future RunDialog()async{
    showModalBottomSheet(context: context, builder: (ctx){
      return Column(

      );
    });
  }
  String SplitPrice2(dynamic price){
    var f = NumberFormat("###,###,###,###", "en_US");
    return   f.format(price).toString();
  }


  late Timer _timer;
  int _start = 5;
  bool FlagError=false;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            FlagError=false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }


  int SumAll=0;
  int Count=0;

  List<TempOrder> Products=[];
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MobileScannerController mobileScannerController=MobileScannerController();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'IranSans',
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Stack(
           children: [
             // MSg.isEmpty?
             Positioned(
               left: 0,
               right: 0,
               top: 0,
               child: Container(
                 height: 50,
                 decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24),bottomRight: Radius.circular(24))
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.end,
                   children: [
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Padding(
                         padding: const EdgeInsets.only(right: 16.0),
                         child: TextApp(MSg, 16,Colors.redAccent,true),
                       ),
                     ),
                   ],
                 ),
               ),
             ),
                 // :Container(),
             MobileScanner(
               controller: mobileScannerController,
               startDelay: false,
               onDetect: (BarcodeCapture barcodes)  async{
                 if(FlaLoading==false)
                   {
                     FlaLoading=true;
                     String Bar="";
                     for (final barcode in barcodes.barcodes) {
                       Bar=barcode.rawValue.toString();
                     }


                     Run(Bar);
                   }

                 // var Data=await ApiService.Login(barcodes.raw.toString());
                 // print(Data.toJson().toString());
               },),
             QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5),),
             // NameProduct.isEmpty?Container():
             // Positioned(
             //   left: 0,
             //   right: 0,
             //   bottom: 0,
             //   child: Container(
             //     decoration: BoxDecoration(
             //         color: Colors.white,
             //       borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24))
             //     ),
             //     child: Column(
             //       crossAxisAlignment: CrossAxisAlignment.end,
             //       children: [
             //          Row(
             //            children: [
             //              Padding(
             //                padding: const EdgeInsets.all(8.0),
             //                child:  TextApp('تومان', 12,Color(0xff626262),false),
             //              ),
             //              Padding(
             //                padding: const EdgeInsets.all(8.0),
             //                // child: TextApp('14,000,000', 16,Colors.redAccent,true),
             //                child: TextApp(SplitPrice2(int.parse(5000.toString())), 16,Color(0xff000000),true),
             //              ),
             //              Spacer(),
             //              Padding(
             //                padding: const EdgeInsets.only(right: 16.0),
             //                child: TextApp('آخرين کالای اسكن شده', 10,Colors.black.withOpacity(0.8),false),
             //              ),
             //            ],
             //          ),
             //         Padding(
             //           padding: const EdgeInsets.all(8.0),
             //           child: Padding(
             //             padding: const EdgeInsets.only(right: 16.0),
             //             // child: TextApp(NameProduct, 16,Colors.black.withOpacity(0.8),true),
             //             child: TextApp('ظرف نشكن اعلا', 16,Colors.black.withOpacity(0.8),true),
             //
             //           ),
             //         ),
             //         Container(
             //           width: double.infinity,
             //           color: Colors.black12.withOpacity(0.1),
             //           height: 1,
             //           margin: EdgeInsets.all(8),
             //         ),
             //
             //         Count!=0?
             //             Column(
             //               children: [
             //                 SizedBox(height: 16,),
             //                 Row(
             //                   children: [
             //                     SizedBox(width: 8,),
             //                     TextApp('تومان', 12,Color(0xff626262),false),
             //                     SizedBox(width: 8,),
             //                     // TextApp(SplitPrice2(int.parse(Priceee)), 16,Color(0xff3CCF4E),true),
             //                     // TextApp(SplitPrice2(int.parse(1545484854445.toString())), 16,Color(0xff3d3d3d),true),
             //                     TextApp(SplitPrice2(SumAll), 16,Color(0xff3d3d3d),true),
             //                     Spacer(),
             //                     TextApp('قيمت تمام شده', 10,Colors.redAccent,false),
             //                     SizedBox(width: 16,)
             //                   ],
             //                 )
             //               ],
             //             )
             //        :Container(),
             //
             //
             //
             //         SizedBox(height: 16,),
             //         Row(
             //           children: [
             //             SizedBox(width: 8,),
             //             InkWell(
             //                 onTap: (){
             //                   if(Count!=1)
             //                     {
             //                       Count=Count-1;
             //                       SumAll=Count*5000;
             //                     }else
             //                       {
             //                         Count=0;
             //                         SumAll=0;
             //                       }
             //
             //                   setState(() {
             //
             //                   });
             //                 },
             //                 child: SvgPicture.asset('assets/min.svg',width: 50,height: 50,color: Colors.black38)),
             //             SizedBox(width: 16,),
             //             TextApp(Count.toString(), 24, Colors.black, true),
             //             SizedBox(width: 16,),
             //             InkWell(
             //                 onTap: (){
             //                   Count=Count+1;
             //                   SumAll=Count*5000;
             //                   setState(() {
             //                   });
             //                 },
             //                 child: SvgPicture.asset('assets/addplus.svg',width: 50,height: 50,color: Colors.redAccent,)),
             //             SizedBox(width: 8,),
             //
             //             Expanded(child: ElevatedButton(
             //               style: ElevatedButton.styleFrom(
             //                 primary: Colors.white,
             //                 side: BorderSide(color: Colors.black38, width: 2),
             //               ),
             //               onPressed: (){},
             //               child: Text('انصراف',style: TextStyle(color:Colors.black38,fontWeight: FontWeight.bold),),
             //             )),
             //             SizedBox(width: 8,),
             //             Expanded(child: ElevatedButton(
             //               style: ElevatedButton.styleFrom(
             //                 primary: Colors.redAccent,
             //               ),
             //               onPressed: (){
             //                 if(Count!=0)
             //                   {
             //                     TempOrder s=TempOrder();
             //                     s.SumAll=SumAll;
             //                     // s.Name=NameProduct;
             //                     s.Name='ظرف نشكن اعلا';
             //                     s.Coka=125;
             //                     s.Count=Count;
             //                     s.Price=5000;
             //                     Products.add(s);
             //                     SumAll=0;
             //                     Count=0;
             //                     MSg="با موفقيت به سبد خريد اضافه شد";
             //                     setState(() {
             //
             //                     });
             //                   }
             //
             //
             //               },
             //               child: Text('ثبت'),
             //             )),
             //             SizedBox(width: 8,),
             //           ],
             //         )
             //
             //       ],
             //     ),
             //   ),
             // ),
           ],
        ),
      ),

    );
  }
}






import 'dart:async';
import 'dart:ffi';

import 'package:appcontact/AddContact.dart';
import 'package:appcontact/BoxIndictor.dart';
import 'package:appcontact/ListContact.dart';
import 'package:appcontact/ListOrders.dart';
import 'package:appcontact/TextApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'ApiService.dart';
import 'Models/TempOrder.dart';
import 'QRScannerOverlay.dart';

void main() {
  runApp(  MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'IranSans',
        primarySwatch: Colors.blue,
      ),
      home: MyApp()));
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
    var s=await ApiService.Login(S,FlaLoading);
    print(s);
    print('NimaMoradi');
    if(s!=null)
      {
        if(s.success)
          {
            // setState(() {
            //   FlagError=false;
            //   Price=s.priceKala.toString();
            //   NameProduct=s.naka.toString();
            // });


            FlagError=false;
            Price=s.priceKala.toString();
            NameProduct=s.naka.toString();
            Shka=s.shka;
            RunDialog();

          }else{
          setState(() {
            FlaLoading=false;
            FlagIsGreen=false;
            FlagError=true;
            MSg=s.msg;
            startTimer();
          });
        }

      }else{
      setState(() {
        FlaLoading=false;
        FlagIsGreen=false;
        startTimer();
        MSg="مشكلي در ارتباط با سرور به وجود آمده";
        FlagError=true;
      });


    }



  }




  String EditNumber(String num)
  {

    var data='';

    if(num.isNotEmpty)
      {
        data =double.tryParse(36545.000.toString())!.toStringAsFixed(0);
      }else{
      data='0';
    }




    return data;
  }
  Future RunDialog()async{
    FlaLoading=true;
   await showModalBottomSheet(context: context,
        // isScrollControlled: true,
        builder: (ctx){
         return Container(
           child: Column(
             mainAxisSize: MainAxisSize.min,
             crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                StatefulBuilder(
               builder: (context,state){
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:  TextApp('تومان', 12,Color(0xff626262),false),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              // child: TextApp('14,000,000', 16,Colors.redAccent,true),
                              child: TextApp(SplitPrice2(int.parse(EditNumber(Price))), 16,Color(0xff000000),true),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: TextApp('آخرين کالای اسكن شده', 10,Colors.black.withOpacity(0.8),false),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: TextApp(NameProduct, 16,Colors.black.withOpacity(0.8),true),
                            // child: TextApp('ظرف نشكن اعلا', 16,Colors.black.withOpacity(0.8),true),

                          ),
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.black12.withOpacity(0.1),
                          height: 1,
                          margin: EdgeInsets.all(8),
                        ),
                        Count!=0?
                        Column(
                          children: [
                            SizedBox(height: 16,),
                            Row(
                              children: [
                                SizedBox(width: 8,),
                                TextApp('تومان', 12,Color(0xff626262),false),
                                SizedBox(width: 8,),
                                // TextApp(SplitPrice2(int.parse(Priceee)), 16,Color(0xff3CCF4E),true),
                                // TextApp(SplitPrice2(int.parse(1545484854445.toString())), 16,Color(0xff3d3d3d),true),
                                TextApp(SplitPrice2(SumAll), 16,Color(0xff3d3d3d),true),
                                Spacer(),
                                TextApp('قيمت تمام شده', 10,Colors.redAccent,false),
                                SizedBox(width: 16,)
                              ],
                            )
                          ],
                        ) :Container(),
                        SizedBox(height: 16,),
                        Row(
                          children: [
                            SizedBox(width: 8,),
                            InkWell(
                                onTap: (){
                                  if(Count!=1&&Count!=0)
                                  {
                                    Count=Count-1;
                                    SumAll=Count*5000;
                                  }else
                                  {
                                    Count=0;
                                    SumAll=0;
                                  }

                                  state(() {});
                                },
                                child: SvgPicture.asset('assets/min.svg',width: 50,height: 50,color: Colors.black38)),
                            SizedBox(width: 16,),
                            TextApp(Count.toString(), 24, Colors.black, true),
                            SizedBox(width: 16,),
                            InkWell(
                                onTap: (){
                                  Count=Count+1;
                                  SumAll=Count*5000;
                                  state(() {
                                  });
                                },
                                child: SvgPicture.asset('assets/addplus.svg',width: 50,height: 50,color: Colors.redAccent,)),
                            SizedBox(width: 8,),

                            Expanded(child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                side: BorderSide(color: Colors.black38, width: 2),
                              ),
                              onPressed: (){
                                MSg='';
                                FlagIsGreen=false;
                                SumAll=0;
                                Count=0;
                                state(() {

                                });
                              },
                              child: Text('انصراف',style: TextStyle(color:Colors.black38,fontWeight: FontWeight.bold,fontSize: 14),),
                            )),
                            SizedBox(width: 8,),
                            Expanded(child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent,
                              ),
                              onPressed: (){
                                if(Count!=0)
                                {
                                  var Finded=Products.any((element) => element.shka==Shka);
                                  if(Finded)
                                    {
                                      var s3=Products.indexWhere((element) => element.shka==Shka);
                                      TempOrder s=TempOrder();
                                      FlagError=true;
                                      s.SumAll=SumAll;
                                      s.Name=NameProduct;
                                      // s.Name='ظرف نشكن اعلا';
                                      s.Coka=Bar;
                                      s.Count=Count;
                                      s.shka=Shka;
                                      s.Price=double.tryParse(EditNumber(Price))!;
                                      Products[s3]=s;
                                      SumAll=0;
                                      Count=0;
                                      MSg="با موفقيت به سبد خريد اضافه شد";
                                      FlagIsGreen=true;
                                      startTimer();
                                      tempOrder=s;
                                      state(() {

                                      });
                                      Navigator.pop(context);
                                    }else{
                                    TempOrder s=TempOrder();
                                    FlagError=true;
                                    s.SumAll=SumAll;
                                    s.Name=NameProduct;
                                    // s.Name='ظرف نشكن اعلا';
                                    s.Coka=Bar;
                                    s.Count=Count;
                                    s.shka=Shka;
                                    s.Price=double.tryParse(EditNumber(Price))!;
                                    Products.add(s);
                                    SumAll=0;
                                    Count=0;
                                    MSg="با موفقيت به سبد خريد اضافه شد";
                                    FlagIsGreen=true;
                                    startTimer();
                                    tempOrder=s;
                                    state(() {

                                    });
                                    Navigator.pop(context);
                                  }
                                 
                                }


                              },
                              child: Text('ثبت',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                            )),
                            SizedBox(width: 8,),
                          ],
                        ),
                        SizedBox(height: 16,)
                      ],
                    ),
                  );
           }

                )
              ],
      ),
         );
    });

   print('object'+'Nima');
   FlaLoading=false;


  }
  String SplitPrice2(dynamic price){
    // var f = NumberFormat("###,###,###,###", "en_US");
    var f = NumberFormat("###,###,###,###", "en_US");
    return   f.format(price).toString();
  }





  late Timer _timer;
  int _start = 4;
  bool FlagError=false;





  void startTimer() {
    _start=4;
    print('NIma + '+_start.toString());
    const oneSec = const Duration(seconds: 1);
    _timer =   Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          timer.cancel();
          _timer.cancel();
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


  double SumAll=0;
  int Count=0;
  String Shka="";

  List<TempOrder> Products=[];
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }






  late TempOrder tempOrder;
  void DelItem()
  {
      Products.removeLast();
  }



  String Bar="";
  bool FlagIsGreen=false;
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
      // home:ListOrders([]));
      home:

      SafeArea(
        child: Scaffold(
          body: Stack(
             children: [
               MobileScanner(
                 controller: mobileScannerController,
                 startDelay: true,
                 onDetect: (BarcodeCapture barcodes)  async{

                   print('FlaLoading'+FlaLoading.toString());
                   if(FlaLoading==false)
                     {
                       FlaLoading=true;
                       String Bar2="";
                       for (final barcode in barcodes.barcodes) {
                         Bar2=barcode.rawValue.toString();
                       }


                       Bar=Bar2;
                       print('Bar : '+Bar);
                       Run(Bar);
                     }

                   // var Data=await ApiService.Login(barcodes.raw.toString());
                   // print(Data.toJson().toString());
                 },),
               QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5),),
               MSg.isNotEmpty&&FlagError?
               Positioned(
                 left: 0,
                 right: 0,
                 bottom: 0,
                 child: Container(
                   width: double.infinity,
                   decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24))
                   ),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.end,
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Padding(
                           padding: const EdgeInsets.only(right: 16.0),
                           child: Row(

                             children: [
                               SizedBox(width: 8,),
                               FlagIsGreen?
                                   Row(
                                     children: [
                                       ElevatedButton(
                                         style: ElevatedButton.styleFrom(
                                           primary: Colors.white,
                                           side: BorderSide(color: Colors.black38, width: 2),
                                         ),
                                         onPressed: (){
                                           MSg='';
                                           FlagIsGreen=false;
                                           SumAll=0;
                                           Count=0;
                                           DelItem();
                                           setState(() {

                                           });
                                         },
                                         child: Text('انصراف',style: TextStyle(color:Colors.black38,fontWeight: FontWeight.bold),),
                                       ),

                                     ],
                                   ):Container(),
                               Spacer(),
                               TextApp(MSg, 14,FlagIsGreen?Color(0xff21AA58):Colors.redAccent,true),
                             ],
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
               )
               :Container(),
               Products.isNotEmpty?
               Positioned(
                   top: 16,
                   left: 16,
                   child: InkWell(
                     onTap: () async{
                       var ss=await Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) =>   ListOrders(Products)),
                       );
                       setState(() {

                       });
                     },
                     child: Container(
                         child: BoxIndictor(Products.length.toString())),
                   )):Container()
                   // :Container(),
               //
               // NameProduct.isEmpty?Container():

             ],
          ),
        ),
      ),

    );

  }
}


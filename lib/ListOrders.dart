import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:appcontact/TextApp.dart';
import 'package:appcontact/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui' as ui;
import 'Models/TempOrder.dart';

class ListOrders extends StatefulWidget {


  List<TempOrder> mains=[];


  ListOrders(this.mains){
    TempOrder ss=TempOrder();
    ss.Price=5000;
    ss.Count=2;
    ss.Coka=15425.toString();
    ss.SumAll=10000;
    ss.Name='اسپري تاخيري زمان دار';


    TempOrder ss2=TempOrder();
    ss2.Price=2000;
    ss2.Count=3;
    ss2.Coka=8518485.toString();
    ss2.SumAll=6000;
    ss2.Name='ماست سطلي';



    mains.add(ss);
    mains.add(ss2);


  }

  @override
  State<ListOrders> createState() => _ListOrdersState();
}

class _ListOrdersState extends State<ListOrders> {
  String SplitPrice2(dynamic price){
    // var f = NumberFormat("###,###,###,###", "en_US");
    var f = NumberFormat("###,###,###,###", "en_US");
    return   f.format(price).toString();
  }
  GlobalKey _globalKey = new GlobalKey();



  Future _capturePng(bool Flag) async {

    try {


      final RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject()!
      as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
//create file
      final String dir = (await getApplicationDocumentsDirectory()).path;
   var   imagePath = '$dir/file_name${DateTime.now()}.png';
   var   capturedFile = File(imagePath);
      await capturedFile.writeAsBytes(pngBytes);
      print(capturedFile.path);
      final result = await ImageGallerySaver.saveImage(pngBytes,
          quality: 100,
          name: "file_name${DateTime.now()}");
      if(Flag)
        {
          Share.shareFiles([capturedFile.path], text: 'Great picture');
        }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content:Row(
              children: [
                SizedBox(width: 8,),
                SvgPicture.asset('assets/tickk.svg',color: Color(0xff21AA58),width: 30,height: 30,),
                Spacer(),
                Text('عكس در گالری ذخیره شد',textAlign: TextAlign.end,style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'IranSans'
                ),)
              ],
            ),
              behavior: SnackBarBehavior.floating,)
        );
      }



    } catch (e) {
      print(e);
    }
  }

  double SumAllFactor=0;
  @override
  Widget build(BuildContext context) {
    widget.mains.forEach((element) {
      SumAllFactor=SumAllFactor+element.SumAll;
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffe7e7e7),
        appBar: AppBar(
          title: Text('سبد خرید',style: TextStyle(color: Colors.redAccent),),
          backgroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: true,
          actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: RotatedBox(
                    quarterTurns: 90,
                    child: SvgPicture.asset('assets/backk.svg',width: 25,height: 25,)),
              )
          ],
        ),
        body: Stack(
          children: [
            RepaintBoundary(
              key:_globalKey ,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: widget.mains.length,
                      // itemCount: 10,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (ctx,item){
                        return Container(
                          margin:  EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white10,
                                blurRadius: 2,
                                spreadRadius: 2,
                                offset: Offset(0,0)
                              )
                            ]
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 8,),
                              Row(
                                children: [
                                  Expanded(child: Align(
                                      alignment: Alignment.centerRight,
                                      child: TextApp(widget.mains[item].Name, 14, Colors.black54, true))),
                                      // child: TextApp('wid', 14, Colors.black54, true))),
                                  TextApp(' : نام كالا  ', 12, Colors.black38, true),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                                height: 1,
                                color: Colors.black12,
                              ),
                              Row(
                                children: [
                                  Expanded(child: Row(
                                    children: [
                                      Expanded(child: Align(
                                          alignment: Alignment.centerRight,
                                          child: TextApp(widget.mains[item].Coka.toString(), 12, Colors.black54, true))),
                                          // child: TextApp('widget.m ', 12, Colors.black54, true))),
                                      TextApp(' : كد كالا ', 14, Colors.black38, true),
                                    ],
                                  )),
                                  Container(
                                    color: Colors.black12,
                                    width: 1,
                                    height: 25,
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                  ),
                                  Expanded(child: Row(
                                    children: [
                                      Expanded(child: Align(
                                          alignment: Alignment.centerRight,
                                          child: TextApp(SplitPrice2(widget.mains[item].Price), 12, Colors.black54, true))),
                                          // child: TextApp('SplitPrice ', 12, Colors.black54, true))),
                                      TextApp(' : قيمت ', 14, Colors.black38, true),
                                    ],
                                  )),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                                height: 1,
                                color: Colors.black12,
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 8,),
                                  InkWell(
                                      onTap: (){
                                        if(widget.mains[item].Count==1)
                                          {
                                            widget.mains.removeAt(item);
                                          }else{
                                          widget.mains[item].Count=widget.mains[item].Count-1;
                                        }

                                        setState(() {

                                        });
                                      },
                                      child: SvgPicture.asset('assets/min.svg',width: 50,height: 50,color: Colors.black38)),
                                  SizedBox(width: 16,),
                                  // TextApp(widget.mains[item].Count.toString(), 24, Colors.black, true),
                                  TextApp('w', 20, Colors.black, true),
                                  SizedBox(width: 16,),

                                  InkWell(
                                      onTap: (){
                                        widget.mains[item].Count=widget.mains[item].Count+1;
                                        setState(() {

                                        });
                                      },
                                      child: SvgPicture.asset('assets/addplus.svg',width: 50,height: 50,color: Colors.redAccent,)),
                                  SizedBox(width: 8,),
                                  Expanded(child: Row(
                                    children: [
                                      Expanded(child: Align(
                                          alignment: Alignment.centerRight,
                                          child: TextApp(SplitPrice2(widget.mains[item].SumAll), 12, Colors.black54, true))),
                                          // child: Expanded(child: TextApp('SplitPrice2( ', 12, Colors.black54, true)))),
                                      TextApp(' : جمع كل ', 14, Colors.black38, true),
                                    ],
                                  )),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.1),
                            offset: Offset(0,0),
                            blurRadius: 2,
                            spreadRadius: 2
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 8,),
                              Expanded(child: TextApp(SplitPrice2(SumAllFactor),18,Colors.black12,true)),
                              SizedBox(width: 8,),
                              TextApp(' : جمع كل مبلغ ',18,Colors.black12,true),
                              SizedBox(width: 8,),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.black12,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 8,),
                              Expanded(child: TextApp(SplitPrice2(SumAllFactor),18,Colors.black12,true)),
                              SizedBox(width: 8,),
                              TextApp(' : جمع كل مبلغ ',18,Colors.black12,true),
                              SizedBox(width: 8,),
                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 128,)
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16,
              bottom: 16,
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      _capturePng(true);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0,0)
                          )
                        ],
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset('assets/sharee.svg',width: 35,height: 35,color: Colors.white,),
                      ) ,
                    ),
                  ),
                  SizedBox(width: 16,),
                  InkWell(
                    onTap: (){
                      _capturePng(false);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: Offset(0,0)
                          )
                        ],
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset('assets/savee.svg',width: 35,height: 35,color: Colors.white,),
                      ) ,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import '../models/shoe.dart';
import '../pages/pages.dart';
import '../widgets/widgets.dart';

class ShoesAppHome extends StatelessWidget {
  const ShoesAppHome({Key? key}) : super(key: key);

  static const _shoe = Shoe.shoe;

  void _navigate(BuildContext context) {
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const ShoesAppDetail(shoe: _shoe);

          //*Para cambiar el status bar entre pantallas
          // return const AnnotatedRegion<SystemUiOverlayStyle>(
          //   value: SystemUiOverlayStyle.light,
          //   child: ShoesAppDetail(shoe: _shoe)
          // );
        },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //----------------------------
      // AppBar
      //----------------------------
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: const Text('For You'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),

      //----------------------------
      // Body
      //----------------------------
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //----------------------------
          // Shoe Viewer And Info
          //----------------------------
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: Column(
                children: [
                  //----------------------------
                  // Show Viewer
                  //----------------------------
                  GestureDetector(
                    onTap: () => _navigate(context),
                    child: const SizedBox(
                      height: 350,
                      child: ShoeViewerHome(shoe: _shoe),
                    )
                  ),
                  const SizedBox(height: 20),
                  //----------------------------
                  // Show Info
                  //----------------------------
                  const ShoeInfo(
                    shoe: _shoe,
                    paragraphs: 3,
                  ),
                ],
              ),
            )
          ),

          //----------------------------
          // Shoe Button
          //----------------------------
          Container(
            margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 20,
                  spreadRadius: 2.5
                )
              ]
            ),
            child: ShoePrice(
              text: 'Add to cart',
              buttonPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              shoe: _shoe, 
              onTapBuy: () => _navigate(context)
            ),
          )
        ],
      ),
    );
  }
}



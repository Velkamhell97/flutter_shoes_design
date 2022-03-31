import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:shoes_app/src/models/shoe.dart';
import 'package:shoes_app/src/models/shoe_notifier.dart';
import 'package:shoes_app/src/widgets/widgets.dart';

class ShoesAppDetail extends StatefulWidget {
  final Shoe shoe;

  const ShoesAppDetail({Key? key, required this.shoe}) : super(key: key);

  @override
  State<ShoesAppDetail> createState() => _ShoesAppDetailState();
}

class _ShoesAppDetailState extends State<ShoesAppDetail> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _buttonAnimation;

  static const _delayDuration = 0;
  static const _slideDuration = 400;
  static const _staggerDuration = 100;
  static const _delayButtonDuration = 200;
  static const _buttonDuration = 1000;
  final _duration =  _delayDuration + _slideDuration + (_staggerDuration * (_colors.length - 1)) + _delayButtonDuration + _buttonDuration;

  final List<Interval> _intervals = [];
  late Interval _buttonInterval;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _duration)
    );

    _fillIntervals();

    _buttonAnimation = CurvedAnimation(
      parent: _controller,
      curve: _buttonInterval
    );

    //-Al parecer para notar el cambio es necesario un pequeño delay (min 300 ??)
    Future.delayed(const Duration(milliseconds: 300)).then((_) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light)
      );
    });

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _controller.forward(from: 0.0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _fillIntervals(){
    for (int i = 0; i < _colors.length; i++) {
      final begin = _delayDuration +  (_staggerDuration * i);
      final end = begin + _slideDuration;

      _intervals.add(Interval(
        begin/_duration,
        end/_duration,
      ));
    }

    final buttonBegin = _duration - _buttonDuration;
    _buttonInterval = Interval( 
      buttonBegin/_duration,
      1.0, //siempre termina en 1
      curve: Curves.bounceOut
    );
  }

  static const _colors = [
    Color(0xff364D56),
    Color(0xff2099F1),
    Color(0xffFFAD29),
    Color(0xffC6D642),
  ];

  @override
  Widget build(BuildContext context) {
    final shoeProvider = Provider.of<ShoeNotifier>(context, listen: false);

    return Scaffold(
      body: Column(
        children: [
          //----------------------------
          // Shoe Viewer
          //----------------------------
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              height: 300,
              child: Stack(
                children: [
                  ShowViewerDetail(shoe: widget.shoe),
                  const Align(
                    alignment: Alignment(-0.95, -0.8),
                    child: BackButton(color: Colors.white),
                  )
                ],
              ),
            ),
          ),

          //----------------------------
          // Shoe Details
          //----------------------------
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              child: Column(
                children: [
                  //----------------------------
                  // Shoe Info
                  //----------------------------
                  ShoeInfo(shoe: widget.shoe),
                  const SizedBox(height: 15.0),

                  //----------------------------
                  // Shoe Price
                  //----------------------------
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final value = _buttonAnimation.value;
                      final slide = value < 0.5 ? value : 1 - value;
            
                      return ShoePrice(
                        text: 'Buy now',
                        buttonPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                        shoe: widget.shoe, 
                        onTapBuy: () => Navigator.of(context).pop(),
                        animation: -slide * 25,
                      );
                    },
                  ),
                  const SizedBox(height: 15.0),

                  //----------------------------
                  // Shoe Options
                  //----------------------------
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //----------------------------
                        // Shoe Palette
                        //----------------------------
                        RotatedBox(
                          quarterTurns: 2,
                          child: Row(
                            children: List.generate(_colors.length, (index) {
                              final reversedIndex = _colors.length - 1 - index;
                          
                              return AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) {
                                  //Con el curves.transform, se le agrega una curva 
                                  final animationPercent = _intervals[reversedIndex].transform(_controller.value);
                                  final slideDistance = (1 - animationPercent) * 150;
                            
                                  return Transform.translate(
                                    offset: Offset(slideDistance, 0.0),
                                    child: child,
                                  );
                                },
                                child: GestureDetector(
                                  onTap: () => shoeProvider.selectedColor = reversedIndex,
                                  child: Align(
                                    widthFactor: 0.65,
                                    child: CircleAvatar(
                                      backgroundColor: _colors[reversedIndex],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),

                        //----------------------------
                        // Shoe Disable Button
                        //----------------------------
                        IgnorePointer(
                          child: Opacity(
                            opacity: 0.5,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                                shape: const StadiumBorder(),
                              ),
                              onPressed: (){}, 
                              child: const Text('More ralted items')
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  //----------------------------
                  // Shoe Circular Buttons
                  //----------------------------
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: NavigationButtons()
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}




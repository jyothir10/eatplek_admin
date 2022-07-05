import 'package:flutter/material.dart';

class MenuChangeScreen extends StatefulWidget {
  static const String id = '/MenuChange';
  const MenuChangeScreen({Key? key}) : super(key: key);

  @override
  State<MenuChangeScreen> createState() => _MenuChangeScreenState();
}

class _MenuChangeScreenState extends State<MenuChangeScreen> {
  bool expanded1 = false;
  bool expanded2 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xff1A191A),
          ),
        ),
        centerTitle: true,
        title: Text('Menu Change',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'SFUIText',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: Color(0xfffff5f5),
            height: MediaQuery.of(context).size.height * .0475,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: (){
                  setState((){
                    if(expanded1 == true){
                      expanded1 = false;
                    }
                    else {
                      expanded1 = true;
                    }
                  });
                },
                child: Row(
                  children: [
                    Icon(expanded1?Icons.keyboard_arrow_down_outlined:Icons.keyboard_arrow_right_outlined,
                    size: 18,),
                     const Text('Adding New item',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.387463569641113,
                        fontFamily: 'SFUIText',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * .235,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text('Name',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'SFUIText',
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            color: Color(0xfffff5f5),
            height: MediaQuery.of(context).size.height * .0475,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: (){
                  setState((){
                    if(expanded2 == true){
                      expanded2 = false;
                    }
                    else {
                      expanded2 = true;
                    }
                  });
                },
                child: Row(
                  children:  [
                    Icon(expanded2?Icons.keyboard_arrow_down_outlined:Icons.keyboard_arrow_right_outlined,
                      size: 18,),
                    const Text('Change Exisiting Iteam Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.387463569641113,
                        fontFamily: 'SFUIText',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

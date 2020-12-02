import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class CustomAppBar extends StatelessWidget {

  final String title;
  final double height;
  final double marginLeft;
  final double marginRight;
  final double marginTop;
  final bool isVisible;
  const CustomAppBar({this.title = "", this.isVisible = true, this.height = 52,this.marginLeft = 8, this.marginRight = 8, this.marginTop = 6});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: (isVisible) ? 1 : 0,
        child: Container(
        height: this.height + marginTop,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {},
                child: Card(
            elevation: 2,
            margin: EdgeInsets.fromLTRB(this.marginLeft, this.marginTop, this.marginRight, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: Color(0xFFc2c2c2).withOpacity(0.7),
                width: 1
              )
            ),
            child: Row(
              children: <Widget>[
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(
                    OMIcons.accountCircle,
                    size: 28,
                    color: Color(0xFF0A70BA),
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: 12),
                Text(
                  this.title,
                  style: TextStyle(
                    fontSize: 16,
                  )
                ),
                Spacer(),
                SizedBox(
                  child: IconButton(
                    icon: Column(
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 3.3,
                              backgroundColor: Color(0xFF0A70BA),
                              child: CircleAvatar(
                                radius: 2,
                                backgroundColor: Colors.white,
                              ),
                            )
                          ]
                        ),
                        SizedBox(height: 1.0),
                        Stack(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 3.3,
                              backgroundColor: Color(0xFF0A70BA),
                              child: CircleAvatar(
                                radius: 2,
                                backgroundColor: Colors.white,
                              ),
                            )
                          ]
                        ),
                        SizedBox(height: 1.0),
                        Stack(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 3.3,
                              backgroundColor: Color(0xFF0A70BA),
                              child: CircleAvatar(
                                radius: 2,
                                backgroundColor: Colors.white,
                              ),
                            )
                          ]
                        ),
                      ],
                    ),
                  onPressed: () {},
                  ),
                ),
                SizedBox(width: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

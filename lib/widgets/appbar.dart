import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path/path.dart';
class CustomAppBar extends StatelessWidget {
 AnimationController animationController;
 Animation colortween, icontween, drawertween, hometween, yogatween;
 Function()? onPressed;
 CustomAppBar({required this.animationController,required this.colortween,required this.drawertween,required this.hometween,required this.icontween,required this.onPressed,required this.yogatween});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child)=>AppBar(
            elevation: 0,
            backgroundColor: colortween.value,
            leading: IconButton(
              icon: Icon(Icons.dehaze, color: icontween.value,),
              onPressed: onPressed,
            ),
            title: Row(
              children: [
                Text("HOME", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: hometween.value)),
                SizedBox(width: 6),
                Text("YOGA", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: yogatween.value)),
              ],
            ),
            actions: [
              IconButton(color: icontween.value, onPressed: (){
                showSimpleNotification(Text("No New Notifications"),background: Colors.grey);
    }
              , icon: Icon(Icons.notifications),),
              SizedBox(width: 15,)
            ],
          )
      ),
    );
  }
}

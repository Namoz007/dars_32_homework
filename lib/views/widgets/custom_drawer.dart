import 'package:flutter/material.dart';
import 'package:working/views/screens/home_screen.dart';
import 'package:working/views/screens/notes.dart';


class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 30,),
          
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }, icon: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Kontaktlar",style: TextStyle(fontSize: 22),),
                Icon(Icons.keyboard_arrow_right,size: 25,)
              ],
            ),
          )),

          SizedBox(height: 20,),

          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Notes()));
          }, icon: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Notes",style: TextStyle(fontSize: 22),),
                Icon(Icons.keyboard_arrow_right,size: 25,)
              ],
            ),
          )),

          SizedBox(height: 20,),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/settings';
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'),),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 18.0,top: 8),
            child: Text('Settings',style: TextStyle(color: Colors.grey,fontSize: 20),),
          ),

         Card(
           child: Column(
             children: [
               ListTile(
                 onTap: () {},
                 leading: const CircleAvatar(child: Icon(Icons.language)),
                 title: const Text('Language'),
                 trailing: Row(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     Text('English',style: TextStyle(color: Colors.grey),),
                     const Icon(Icons.keyboard_arrow_right),
                   ],
                 )
               ),
               ListTile(
                 onTap: () {},
                 leading: const CircleAvatar(child: Icon(Icons.support)),
                 title: const Text('Support'),
                 trailing: const Icon(Icons.keyboard_arrow_right),
               ),
               ListTile(
                 onTap: () {},
                 leading: const CircleAvatar(child: Icon(Icons.privacy_tip)),
                 title: const Text('Privacy'),
                 trailing: const Icon(Icons.keyboard_arrow_right),
               ),
             ],
           ),

         ),
          const Padding(
            padding: EdgeInsets.only(left: 18.0,top: 8),
            child: Text('Settings Change',style: TextStyle(color: Colors.grey,fontSize: 20),),
          ),
         Card(
           child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               ListTile(
                 onTap: () {},
                 leading: const CircleAvatar(child: Icon(Icons.notifications)),
                 title: const Text('Notification'),
                 trailing: Container(
                   height: 100,width: 100,
                   child: FlutterSwitch(
                     width: 60.0,
                     height: 35.0,
                     toggleSize: 30.0,
                     value: status,
                     borderRadius: 30.0,
                     toggleColor: Colors.white,
                     toggleBorder: Border.all(
                       color: Colors.white,
                       width: 2.0,
                     ),
                     activeColor: Colors.green,
                     inactiveColor: Colors.black38,
                     onToggle: (val) {
                       setState(() {
                         status = val;
                       });
                     },
                   ),
                 ),
               ),
               ListTile(
                 onTap: () {},
                 leading: const CircleAvatar(child: Icon(Icons.lock)),
                 title: const Text('Password'),
                 trailing: const Icon(Icons.keyboard_arrow_right),
               ),
             ],
           ),

         ),

        ],
      ),
    );
  }
}

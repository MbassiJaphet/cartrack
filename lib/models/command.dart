import 'package:cartrack/routes/home/commands/commands.dart';
import 'package:flutter/material.dart';


class Command{
  String name;
  Widget icon;
  bool running = false;
  // get isRunning => this.running;
  void isRunning(bool running) {
    this.running = running;
  }
  Command(this.name,{@required this.icon});
}

class CommandCard extends StatelessWidget {
  bool isRunningCommand;
  Command command;
  CommandsPanel popup;

  CommandCard(this.command, this.popup, {this.isRunningCommand = false});

  Widget buildCommandCard(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        borderRadius:  BorderRadius.circular(8),
        onTap: () {this.command.running = true; popup.refreshRunningCommands();},
        child: Card(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color(0xFF64dd17).withOpacity(0.8),
                width: 2.5
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                this.command.icon,
                SizedBox(height: 4),
                Text(this.command.name, style: TextStyle(color: Colors.white))
              ]
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRunningCommandCard(BuildContext context){
    return Container(
      padding: EdgeInsets.fromLTRB(24, 12, 12, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 6),
                child: Row(
                  children: <Widget>[
                    this.command.icon,
                    SizedBox(width: 8),
                    Text(this.command.name, style: TextStyle(fontSize: 16,color: Colors.white)),
                  ],
                ),
              ),
              Spacer(),
              FlatButton(
                padding: EdgeInsets.all(0),
                child: Text('Interrupt', style: TextStyle(color: Colors.white)),
                color: Color(0xFF64dd17).withOpacity(0.35),
                onPressed: () {this.command.running = false; popup.refreshRunningCommands();},
              ),
            ],
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    if(this.isRunningCommand){
      return buildRunningCommandCard(context);
    }
    else{
      return buildCommandCard(context);
    }
  }
}

var Commands = [
 Command('Ignition Alert',icon: Icon(Icons.whatshot, size: 20, color: Colors.white)),
 Command('Activate Engine',icon: Icon(Icons.ac_unit, size: 20, color: Colors.white)),
 Command('Showk Alert',icon: Icon(Icons.warning, size: 20, color: Colors.white)),
 Command('Speed Alert',icon: Icon(Icons.directions_run, size: 20, color: Colors.white)),
 Command('Sensors Alert',icon: Icon(Icons.warning, size: 20, color: Colors.white)),
 Command('Set Geo Fence',icon: Icon(Icons.trip_origin, size: 20, color: Colors.white)),
];

import 'package:flutter/material.dart';

class Group extends StatefulWidget {
  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {
  String valuechoose;
  List listItem = ["All","SIT","FIBO","ENE","SC","ECT","ME","SODA",];
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16),
        child: DropdownButton(
            hint: Text("group"),
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 36,
            isExpanded: true,
            style: TextStyle(
              color: Colors.black, 
              fontSize: 15
            ),
            value: valuechoose,
            onChanged: (newValue){
              setState(() {
                valuechoose = newValue;
              });
            },
            items: listItem.map((valueItem){
              return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem),

              );
            }
            ).toList(),
          
        ),
      ),
    );
  }
}
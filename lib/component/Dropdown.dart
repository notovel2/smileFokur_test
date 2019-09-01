import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smile_fokus_test/constant/Color.dart';

class Dropdown<T> extends StatefulWidget{
  Dropdown({
    @required this.dropdownlist,
    @required this.onChanged
  });
  final List<T> dropdownlist;
  final void Function(T) onChanged;

  @override
  _DropdownState createState() => _DropdownState();

}

class _DropdownState<T> extends State<Dropdown> {
  T _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = (widget.dropdownlist.length > 0) ? widget.dropdownlist[0] : _selectedValue;
  }

  void _onDropdownChanged(value) {
    setState(() {
      _selectedValue =  value;
      widget.onChanged(value);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: CustomColors.border.color,
          style: BorderStyle.solid,
          width: 1.5,
        )
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: _selectedValue,
          onChanged: _onDropdownChanged,
          icon: Container(
            margin: EdgeInsets.only(left: 10,),
            child: Image.asset("assets/dropdown_icon.png"),
          ),
          items: widget.dropdownlist.map<DropdownMenuItem<T>>((dropdownItem) => 
            DropdownMenuItem<T>(
              value: dropdownItem,
              child: Text(dropdownItem.title),
            )
          ).toList(),
        ),
      ),
    );
  }
  
}
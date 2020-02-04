//import 'dart:convert';
//
//import 'package:bierzaehler/objects/size.dart';
//
//class Use {
//  Size _size;
//  DateTime _date;
//
//  Use(this._size, {int microsecondsSinceEpoch}) {
//    if (microsecondsSinceEpoch == null) {
//      this._date = DateTime.now();
//    } else {
//      this._date = DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);
//    }
//  }
//
//  Use.fromJSON(Map<String, dynamic> data){
//    if (data["size"] != null) {
//      Map<String, dynamic> m = jsonDecode(data["size"]);
//      this._size = new Size.fromJSON(m);
//    }else {
//      throw ArgumentError("size was invalid!");
//    }
//    if (data["date"] != null) {
//      this._date = DateTime.fromMicrosecondsSinceEpoch(int.parse(data["date"]));
//    }else {
//      throw ArgumentError("date was invalid!");
//    }
//  }
//
//  Map<String, dynamic> toJson()=>{
//    "size": jsonEncode(_size),
//    "date": _date.microsecondsSinceEpoch.toString()
//  };
//
//  DateTime get date{
//    return _date;
//  }
//
//  Size get size{
//    return _size;
//  }
//}

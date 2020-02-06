//class Size{
//  double _value;
//
//  Size(this._value);
//
//  ///Creates the Size from JSON.
//  ///
//  ///[data] the data in Map format.
//  ///Throws an [ArgumentError] if the data is invalid.
//  Size.fromJSON(Map<String, dynamic> data){
//    if (data["value"] != null) {
//      this._value = double.parse(data["value"]);
//    }else {
//      throw ArgumentError("value was invalid!");
//    }
//  }
//
//  Map<String, dynamic> toJson()=>{
//    "value": _value.toString()
//  };
//
//  get value{
//    return _value;
//  }
//
//
//}
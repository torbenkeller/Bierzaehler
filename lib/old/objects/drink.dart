//import 'dart:convert';
//
//import 'package:bierzaehler/objects/size.dart';
//import 'package:bierzaehler/objects/use.dart';
//
/////Represents a Drink.
//class Drink {
//  String _name;
//  double _alcohol;
//
//  List<Size> _sizes;
//  List<Use> _uses;
//
//  ///Creates the object.
//  ///
//  ///[_name] the name of the drink.
//  ///[_alcohol] the vol% of the drink.
//  ///[_sizes] a list of sizes where belong to the drink.
//  ///[_uses] a list of uses of the drink.
//  Drink(drinkName, drinkAlcohol, drinkSizes, drinkUses) {
//    name = drinkName;
//    alcohol = drinkAlcohol;
//    _drinkSizes = drinkSizes;
//    _drinkUses = drinkUses;
//  }
//
//  ///Creates the drink and all child old.objects from JSON.
//  ///
//  ///[data] the data in Map format.
//  ///Throws an [ArgumentError] if the data is invalid.
//  Drink.fromJSON(Map<String, dynamic> data) {
//    if (data["name"] != null && data["name"] is String) {
//      this._name = data["name"];
//    } else {
//      throw ArgumentError("name was invalid!");
//    }
//    if (data["alcohol"] != null && data["alcohol"] is String) {
//      this._alcohol = double.parse(data["alcohol"]);
//    } else {
//      throw ArgumentError("alcohol was invalid!");
//    }
//    if (data["sizes"] != null) {
//      Iterable l = jsonDecode(data["sizes"]);
//      _sizes = l.map((model) => Size.fromJSON(model)).toList();
//    } else {
//      throw ArgumentError("sizes was invalid!");
//    }
//    if (data["uses"] != null) {
//      Iterable l = jsonDecode(data["uses"]);
//      _uses = l.map((model) => Use.fromJSON(model)).toList();
//    } else {
//      throw ArgumentError("sizes was invalid!");
//    }
//  }
//
//  Map<String, dynamic> toJson() => {
//        "name": _name,
//        "alcohol": _alcohol.toString(),
//        "sizes": jsonEncode(_sizes),
//        "uses": jsonEncode(_uses)
//      };
//
//  //-------------------------------
//  //PUBLIC METHODS
//  //-------------------------------
//
//  ///Drink now a specific amount.
//  ///
//  ///[sizeIndex] the index of the Size in the sizes list.
//  ///Throws an [ArgumentError] if sizeIndex is invalid.
//  void doUse(int sizeIndex) {
//    if (sizeIndex < 0 || sizeIndex >= _sizes.length) {
//      throw ArgumentError(
//          "sizeIndex out of boundaries! sizeIndex: " + sizeIndex.toString());
//    }
//    _uses.add(new Use(_sizes[sizeIndex]));
//  }
//
//  ///Adds a the size to the list of sizes.
//  ///
//  ///[size] the size to add.
//  ///Throws an [ArgumentError] if size is null or
//  ///size is already in the list.
//  void addSize(Size size) {
//    if (size == null) {
//      throw ArgumentError('size is null');
//    }
//    for (Size sizeA in _sizes) {
//      if (identical(size, sizeA)) {
//        throw ArgumentError('size is already in array');
//      }
//    }
//    _sizes.add(size);
//  }
//
//  ///Removes the size from the list.
//  ///
//  /// [size] the size to delete.
//  /// Throws an [ArgumentError] if the size is null or
//  /// the size is not in the list.
//  void removeSize(Size size) {
//    if (size == null) {
//      throw ArgumentError("size is null");
//    }
//    if (!_sizes.remove(size)) {
//      throw ArgumentError("The size was not in the list!");
//    }
//  }
//
//  ///Removes the size on index [sizeIndex] from the list.
//  ///
//  /// [sizeIndex] the size on sizeIndex to delete.
//  /// Throws an [ArgumentError] if the sizeIndex is invalid.
//  void removeSizeAt(int sizeIndex) {
//    if (_sizes.removeAt(sizeIndex) == null) {
//      throw ArgumentError("The size was not in the list!");
//    }
//  }
//
//  ///Replaces the size on [sizeIndex] with [size].
//  ///
//  /// [sizeIndex] the size on sizeIndex to replace.
//  /// Throws an [ArgumentError] if the sizeIndex is invalid.
//  void editSize(int sizeIndex, Size size){
//    if(sizeIndex >= _sizes.length){
//      throw ArgumentError("The size was not in the list!");
//    }
//    this._sizes[sizeIndex] = size;
//  }
//
//  ///Set the Name.
//  ///
//  ///[name] the name to set.
//  set name(String name) {
//    if (name == null) {
//      throw ArgumentError("name was null!");
//    }
//    this._name = name;
//  }
//
//  ///Set the Alcohol.
//  ///
//  ///[alcohol] the alcohol to set.
//  set alcohol(double alcohol) {
//    if (alcohol == null) {
//      throw ArgumentError("alcohol was null!");
//    }
//    this._alcohol = alcohol;
//  }
//
//  ///Removes the last Element of the list of uses.
//  bool removeLastUse() {
//    if (this.uses.length > 0) {
//      return (this._uses.removeLast() != null);
//    }
//    return false;
//  }
//
//  String get name => _name;
//
//  double get alcohol => _alcohol;
//
//  List<Use> get uses {
//    return new List<Use>.from(_uses);
//  }
//
//  List<Size> get sizes {
//    return new List<Size>.from(_sizes);
//  }
//
//  ///The total amount of the drink in liters.
//  double get drunkenTotalVol {
//    double result = 0.0;
//    for (Use use in _uses) {
//      result += use.size.value;
//    }
//    return result;
//  }
//
//  ///The total amount of drunken alcohol in gram.
//  double get drunkenTotalAlk {
//    return drunkenTotalVol * 10 * 0.8 * alcohol;
//  }
//
//  ///The days since the first drink.
//  int get daysSinceFirstDrink {
//    DateTime firstDay = DateTime.now();
//    for (Use use in _uses) {
//      if (use.date.millisecondsSinceEpoch < firstDay.millisecondsSinceEpoch) {
//        firstDay = use.date;
//      }
//    }
//    DateTime today = DateTime.now();
//    return today.difference(firstDay).inDays;
//  }
//
//  ///calculates the average drunken volume of the drink in liters
//  ///for the time [time] in liter.
//  double averageDayVol(AverageTime time) {
//    switch (time) {
//      case AverageTime.TODAY:
//        double result = 0.0;
//        DateTime today = DateTime.now().subtract(Duration(days: 0, hours: 0));
//        for (Use use in _uses) {
//          if (today.difference(use.date).inDays == 0) {
//            result += use.size.value;
//          }
//        }
//        return result;
//      case AverageTime.YESTERDAY:
//        double result = 0.0;
//        DateTime yesterday = DateTime.now();
//        yesterday = yesterday.subtract(Duration(
//          days: 1,
//        ));
//
//        for (Use use in _uses) {
//          if (yesterday.difference(use.date).inHours < 24 &&
//              yesterday.difference(use.date).inHours >= 0) {
//            result += use.size.value;
//          }
//        }
//        return result;
//      case AverageTime.WEEK:
//        double result = 0.0;
//        DateTime today = DateTime.now();
//        for (Use use in _uses) {
//          if (today.difference(use.date).inDays < 7) {
//            result += use.size.value;
//          }
//        }
//        return result / 7.0;
//      case AverageTime.MONTH:
//        double result = 0.0;
//        DateTime today = DateTime.now();
//        for (Use use in _uses) {
//          if (today.difference(use.date).inDays < 31) {
//            result += use.size.value;
//          }
//        }
//        return result / 31.0;
//      case AverageTime.YEAR:
//        double result = 0.0;
//        DateTime today = DateTime.now();
//        for (Use use in _uses) {
//          if (today.difference(use.date).inDays < 365) {
//            result += use.size.value;
//          }
//        }
//        return result / 365.0;
//      default:
//        return -1.0;
//    }
//  }
//
//  double averageMonthVol(AverageTime time) {
//    return averageDayVol(time) * 31.0;
//  }
//
//  double averageYearVol(AverageTime time) {
//    return averageDayVol(time) * 365.0;
//  }
//
//  ///calculates the average drunken alk of the drink in liters
//  ///for the time [time] in gram.
//  double averageDayAlk(AverageTime time) {
//    return averageDayVol(time) * 10.0 * 0.8 * alcohol;
//  }
//
//  double averageMonthAlk(AverageTime time) {
//    return averageMonthVol(time) * 10.0 * 0.8 * alcohol;
//  }
//
//  double averageYearAlk(AverageTime time) {
//    return averageYearVol(time) * 10.0 * 0.8 * alcohol;
//  }
//
//  //--------------------------------------
//  //PRIVATE FUNCTIONS
//  //--------------------------------------
//
//  ///Set the Uses
//  ///
//  ///[uses] the list of uses to set.
//  ///Throws an [ArgumentError] if uses is null or
//  ///if uses is an unmodifiable list.
//  set _drinkUses(List<Use> uses) {
//    if (uses != null) {
//      Use use = new Use(new Size(0.0));
//      uses.add(use);
//      if (!uses.remove(use)) {
//        throw ArgumentError("uses list is unmodifiable!");
//      }
//      this._uses = uses;
//    } else {
//      throw ArgumentError("uses was null!");
//    }
//  }
//
//  ///Set the Sizes
//  ///
//  ///[uses] the list of uses to set.
//  ///Throws an [ArgumentError] if uses is null or
//  ///if uses is an unmodifiable list.
//  set _drinkSizes(List<Size> sizes) {
//    if (sizes != null) {
//      Size size = new Size(0.0);
//      sizes.add(size);
//      if (!sizes.remove(size)) {
//        throw ArgumentError("sizes list is unmodifiable!");
//      }
//      this._sizes = sizes;
//    } else {
//      throw ArgumentError("sizes was null!");
//    }
//  }
//}
//
//enum AverageTime { TODAY, YESTERDAY, WEEK, MONTH, YEAR }

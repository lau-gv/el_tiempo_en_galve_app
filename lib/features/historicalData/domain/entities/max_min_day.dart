class MaxMinDay{
  final double _value;
  final String _date;

  MaxMinDay({
    required double value,
    required String date,
  }): 
    _date = date,
    _value = value;

  double get value => _value;
  String get day => _date;
    
}
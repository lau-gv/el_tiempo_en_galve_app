class MaxMinDay{
  final double _value;
  final String _date;

  MaxMinDay({
    required double value,
    required String date,
  }): 
    _date = date,
    _value = value;

  double get value => double.parse(_value.toStringAsFixed(2));
  String get day => _date;
    
}
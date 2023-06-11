class MaxMinDay{
  final double _value;
  final String _day;

  MaxMinDay({
    required double value,
    required String day,
  }): 
    _day = day,
    _value = value;

  double get value => _value;
  String get day => _day;
    
}
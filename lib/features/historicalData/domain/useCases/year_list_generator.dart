class YearListGenerator{

  final int minYear = 2023;
  late final List<int> _years;

  YearListGenerator(){
    _years = [];
    _generateSelecteableYears();
  }

  void _generateSelecteableYears(){
    int currentYear = DateTime.now().year;
    _years.add(minYear );
    
    for(int newYear = currentYear; newYear > minYear; newYear--){
      _years.add(newYear);
    }
  }

  List<int> get years => _years;
}
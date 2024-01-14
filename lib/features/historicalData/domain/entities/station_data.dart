class StationData{

  final String _stationId; 
  final int _datadatetime; 
  final double _temperature; 
  final int _humidity; 
  final double _baromrelhpa; 
  final double _baromabshpa; 
  final double _rainrateinmm;
  final double? _eventraininmm;
  final double _hourlyraininmm; 
  final double _dailyraininmm; 
  final double _weeklyraininmm; 
  final double _monthlyraininmm; 
  final double _yearlyraininmm; 
  final double _winddir; 
  final double _windspeedkmh; 
  final double _windguskmh; 
  final double _maxdailygust; 
  final double _solarradiation; 
  final int _uv;
  final double? _dewptfC;
  final double? _windchillC; //Sensación térmica en grados centigrados
  //Datos de dentro:
  final double _indoortempf; 
  final int _indoorhumidity;

  StationData({
    stationId,
    datadatetime,
    temperature,
    humidity,
    baromrelhpa,
    baromabshpa,
    rainrateinmm,
    eventraininmm,
    hourlyraininmm,
    dailyraininmm,
    weeklyraininmm,
    monthlyraininmm,
    yearlyraininmm,
    winddir,
    windspeedkmh,
    windguskmh,
    maxdailygust,
    solarradiation,
    uv,
    dewptfC,
    windchillC,
    indoortempf,
    indoorhumidity,
  }):
  _stationId = stationId,
  _datadatetime = datadatetime,
  _temperature = temperature,
  _humidity = humidity,
  _baromrelhpa = baromrelhpa,
  _baromabshpa = baromabshpa,
  _rainrateinmm = rainrateinmm,
  _eventraininmm = eventraininmm,
  _hourlyraininmm = hourlyraininmm,
  _dailyraininmm = dailyraininmm,
  _weeklyraininmm = weeklyraininmm,
  _monthlyraininmm = monthlyraininmm,
  _yearlyraininmm = yearlyraininmm,
  _winddir = winddir,
  _windspeedkmh = windspeedkmh,
  _windguskmh = windguskmh,
  _maxdailygust = maxdailygust,
  _solarradiation = solarradiation,
  _uv = uv,
  _dewptfC = dewptfC,
  _windchillC = windchillC,
  _indoortempf = indoortempf,
  _indoorhumidity = indoorhumidity;

  String get stationId => _stationId;
  int get datadatetime => _datadatetime;
  double get temperature => _temperature;
  int get humidity => _humidity;
  double get baromrelhpa => _baromrelhpa;
  double get baromabshpa => _baromabshpa;
  double get rainrateinmm => _rainrateinmm;
  double? get eventraininmm => _eventraininmm;
  double get hourlyraininmm => _hourlyraininmm;
  double get dailyraininmm => _dailyraininmm;
  double get weeklyraininmm => _weeklyraininmm;
  double get monthlyraininmm => _monthlyraininmm;
  double get yearlyraininmm => _yearlyraininmm;
  double get winddir => _winddir;
  double get windspeedkmh => _windspeedkmh;
  double get windguskmh => _windguskmh;
  double get maxdailygust => _maxdailygust;
  double get solarradiation => _solarradiation;
  int get uv => _uv;
  double? get dewptfC => _dewptfC;
  double? get windchillC => _windchillC;
  double get indoortempf => _indoortempf;
  int get indoorhumidity => _indoorhumidity;

  double getHoras(){
    int horas = (_datadatetime % 1000000) ~/ 10000;
    int minutos = (_datadatetime % 10000) ~/ 100;

    return (horas) + (minutos / 60.0);
  }
  String getHHMMString(){
    int horas = (_datadatetime % 1000000) ~/ 10000;
    int minutos = (_datadatetime % 10000) ~/ 100;

    return '${horas.toString().padLeft(2, '0')}:${minutos.toString().padLeft(2, '0')}';
  }
}
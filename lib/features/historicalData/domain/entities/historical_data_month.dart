class HistoricalDataMonth{
    //DatosDeFuera.
    final int _datadate; 
    final String _stationId; 
    final int _year;
    final int _month;
    final double _maxTemperature;
    final double _minTemperature;
    final int _maxHumidity; //%
    final int _minHumidity; //%
    final double _maxBaromrelhpa;  //presion relativa (hpa)
    final double _minBaromrelhpa;  //presion relativa (hpa)
    final double _maxBaromabshpa; //presion absoluta (hpa)
    final double _minBaromabshpa; //presion absoluta (hpa)
    final double _maxRainrateinmm; //indica la tasa de precipitación actual en mm por hora. //indica la tasa de precipitación actual en mm por hora.
    final double _minRainrateinmm; //indica la tasa de precipitación actual en mm por hora. //indica la tasa de precipitación actual en mm por hora.
    final double _acumulateDailyraininmm; 
    final double _maxwindspeedkmh;// dirección del viento en grados (°) (59).
    final double _minwindspeedkmh;// dirección del viento en grados (°) (59).
    final double _maxdailygust; //ráfaga máxima diaria de viento en km por hora (mph) (13.65).
    final double _mindailygust; //ráfaga máxima diaria de viento en km por hora (mph) (13.65).
    final double _maxSolarradiation; //radiación solar en vatios por metro cuadrado (W/m2) (567.79).
    final double _minSolarradiation; //radiación solar en vatios por metro cuadrado (W/m2) (567.79).
    final int _maxUv; //índice ultravioleta (UV) (5).
    final int _minUv; //índice ultravioleta (UV) (5).
    //Datos de dentro:
    final double _maxIndoortemp; //Temperatura interior en grados C.
    final double _minIndoortemp; //Temperatura interior en grados C.
    final int _maxIndoorhumidity; //Humedad relativa interior en porcentaje (%).
    final int _minIndoorhumidity;
    
    HistoricalDataMonth({
      required int datadate,
      required String stationId,
      required int year,
      required int month,
      required double maxTemperature,
      required double minTemperature,
      required int maxHumidity,
      required int minHumidity,
      required double maxBaromrelhpa,
      required double minBaromrelhpa,
      required double maxBaromabshpa,
      required double minBaromabshpa,
      required  double maxRainrateinmm,
      required  double minRainrateinmm,
      required  double acumulateDailyraininmm,
      required  double maxwindspeedkmh,
      required  double minwindspeedkmh,
      required  double maxdailygust,
      required   double mindailygust,
      required  double maxSolarradiation,
      required   double minSolarradiation,
      required   int maxUv,
      required   int minUv,
      required   double maxIndoortemp,
      required   double minIndoortemp,
      required   int maxIndoorhumidity,
      required  int minIndoorhumidity,
    }) :
    _datadate = datadate,
    _stationId = stationId,
    _year = year,
    _month = month,
    _maxTemperature = maxTemperature,
    _minTemperature = minTemperature,
    _maxHumidity = maxHumidity,
    _minHumidity = minHumidity,
    _maxBaromrelhpa = maxBaromrelhpa,
    _minBaromrelhpa = minBaromrelhpa,
    _maxBaromabshpa = maxBaromabshpa,
    _minBaromabshpa = minBaromabshpa,
    _maxRainrateinmm = maxRainrateinmm,
    _minRainrateinmm = minRainrateinmm,
    _acumulateDailyraininmm = acumulateDailyraininmm,
    _maxwindspeedkmh = maxwindspeedkmh,
    _minwindspeedkmh = minwindspeedkmh,
    _maxdailygust = maxdailygust,
    _mindailygust = mindailygust,
    _maxSolarradiation = maxSolarradiation,
    _minSolarradiation = minSolarradiation,
    _maxUv = maxUv,
    _minUv = minUv,
    _maxIndoortemp = maxIndoortemp,
    _minIndoortemp = minIndoortemp,
    _maxIndoorhumidity = maxIndoorhumidity,
    _minIndoorhumidity = minIndoorhumidity;

  int get datadate => _datadate;
  String get stationId => _stationId;
  int get year => _year;
  int get month => _month;
  double get maxTemperature => double.parse(_maxTemperature.toStringAsFixed(2));
  double get minTemperature => double.parse(_minTemperature.toStringAsFixed(2));
  int get maxHumidity => _maxHumidity;
  int get minHumidity => _minHumidity;
  double get maxBaromrelhpa => double.parse(_maxBaromrelhpa.toStringAsFixed(2));
  double get minBaromrelhpa => double.parse(_minBaromrelhpa.toStringAsFixed(2));
  double get maxBaromabshpa => double.parse(_maxBaromabshpa.toStringAsFixed(2));
  double get minBaromabshpa => double.parse(_minBaromabshpa.toStringAsFixed(2));
  double get maxRainrateinmm => double.parse(_maxRainrateinmm.toStringAsFixed(2));
  double get minRainrateinmm => double.parse(_minRainrateinmm.toStringAsFixed(2));
  double get acumulateDailyraininmm => double.parse(_acumulateDailyraininmm.toStringAsFixed(2));
  double get maxwindspeedkmh => double.parse(_maxwindspeedkmh.toStringAsFixed(2));
  double get minwindspeedkmh => double.parse(_minwindspeedkmh.toStringAsFixed(2));
  double get maxdailygust => double.parse(_maxdailygust.toStringAsFixed(2));
  double get mindailygust => double.parse(_mindailygust.toStringAsFixed(2));
  double get maxSolarradiation => double.parse(_maxSolarradiation.toStringAsFixed(2));
  double get minSolarradiation => double.parse(_minSolarradiation.toStringAsFixed(2));
  int get maxUv => _maxUv;
  int get minUv => _minUv;
  double get maxIndoortemp => double.parse(_maxIndoortemp.toStringAsFixed(2));
  double get minIndoortemp => double.parse(_minIndoortemp.toStringAsFixed(2));
  int get maxIndoorhumidity => _maxIndoorhumidity;
  int get minIndoorhumidity => _minIndoorhumidity;

  String getDateFormat(){
    String month = _month < 10 ? "0$_month" : "$_month";
    return "$month/$_year";
  }
}

class HistoricalDataDay{
    //DatosDeFuera.
    final int _datadate; 
    final String _stationId; 
    final int _year;
    final int _month;
    final int _day;
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
    final double _acumulateDailyraininmm; // dirección del viento en grados (°) (59).
    final double _maxdailygust; //ráfaga máxima diaria de viento en km por hora (mph) (13.65).
    final double _maxSolarradiation; //radiación solar en vatios por metro cuadrado (W/m2) (567.79).
    final double _minSolarradiation; //radiación solar en vatios por metro cuadrado (W/m2) (567.79).
    final int _maxUv; //índice ultravioleta (UV) (5).
    final int _minUv; //índice ultravioleta (UV) (5).
    //Datos de dentro:
    final double _maxIndoortemp; //Temperatura interior en grados C.
    final double _minIndoortemp; //Temperatura interior en grados C.
    final int _maxIndoorhumidity; //Humedad relativa interior en porcentaje (%).
    final int _minIndoorhumidity;
    
    HistoricalDataDay({
      required datadate,
      required stationId,
      required year,
      required month,
      required day,
      required maxTemperature,
      required minTemperature,
      required maxHumidity,
      required minHumidity,
      required maxBaromrelhpa,
      required minBaromrelhpa,
      required maxBaromabshpa,
      required minBaromabshpa,
      required maxRainrateinmm,
      required minRainrateinmm,
      required acumulateDailyraininmm,
      required maxdailygust,
      required maxSolarradiation,
      required minSolarradiation,
      required maxUv,
      required minUv,
      required maxIndoortemp,
      required minIndoortemp,
      required maxIndoorhumidity,
      required minIndoorhumidity,
    }) :
    _datadate = datadate,
    _stationId = stationId,
    _year = year,
    _month = month,
    _day = day,
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
    _maxdailygust = maxdailygust,
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
  int get day => _day;
  double get maxTemperature => _maxTemperature;
  double get minTemperature => _minTemperature;
  int get maxHumidity => _maxHumidity;
  int get minHumidity => _minHumidity;
  double get maxBaromrelhpa => _maxBaromrelhpa;
  double get minBaromrelhpa => _minBaromrelhpa;
  double get maxBaromabshpa => _maxBaromabshpa;
  double get minBaromabshpa => _minBaromabshpa;
  double get maxRainrateinmm => _maxRainrateinmm;
  double get minRainrateinmm => _minRainrateinmm;
  double get acumulateDailyraininmm => _acumulateDailyraininmm;
  double get maxdailygust => _maxdailygust;
  double get maxSolarradiation => _maxSolarradiation;
  double get minSolarradiation => _minSolarradiation;
  int get maxUv => _maxUv;
  int get minUv => _minUv;
  double get maxIndoortemp => _maxIndoortemp;
  double get minIndoortemp => _minIndoortemp;
  int get maxIndoorhumidity => _maxIndoorhumidity;
  int get minIndoorhumidity => _minIndoorhumidity;
}

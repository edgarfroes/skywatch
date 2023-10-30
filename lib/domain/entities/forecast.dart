import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'forecast.freezed.dart';
part 'forecast.g.dart';

@freezed
class Forecast extends HiveObject with _$Forecast {
  Forecast._();

  @HiveType(typeId: 0, adapterName: "ForecastAdapter")
  factory Forecast({
    @HiveField(0) required String description,
    @HiveField(1) required String countryCode,
    @HiveField(2) required DateTime createdAt,
  }) = _Forecast;
}

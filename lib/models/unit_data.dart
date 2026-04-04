import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'unit_models.dart';

class UnitConstants {
  // Weight units (base: gram)
  static const List<UnitData> weightUnits = [
    UnitData(name: 'Kilogram', symbol: 'kg', conversionFactor: 1000.0, icon: FontAwesomeIcons.weightHanging),
    UnitData(name: 'Gram', symbol: 'g', conversionFactor: 1.0, icon: FontAwesomeIcons.weightHanging),
    UnitData(name: 'Milligram', symbol: 'mg', conversionFactor: 0.001, icon: FontAwesomeIcons.weightHanging),
    UnitData(name: 'Metric Ton', symbol: 't', conversionFactor: 1000000.0, icon: FontAwesomeIcons.truckMoving),
    UnitData(name: 'Pound', symbol: 'lb', conversionFactor: 453.59237, icon: FontAwesomeIcons.dumbbell),
    UnitData(name: 'Ounce', symbol: 'oz', conversionFactor: 28.34952, icon: FontAwesomeIcons.boxOpen),
  ];

  // Length units (base: meter)
  static const List<UnitData> lengthUnits = [
    UnitData(name: 'Meter', symbol: 'm', conversionFactor: 1.0, icon: FontAwesomeIcons.ruler),
    UnitData(name: 'Kilometer', symbol: 'km', conversionFactor: 1000.0, icon: FontAwesomeIcons.road),
    UnitData(name: 'Centimeter', symbol: 'cm', conversionFactor: 0.01, icon: FontAwesomeIcons.rulerHorizontal),
    UnitData(name: 'Millimeter', symbol: 'mm', conversionFactor: 0.001, icon: FontAwesomeIcons.rulerHorizontal),
    UnitData(name: 'Mile', symbol: 'mi', conversionFactor: 1609.344, icon: FontAwesomeIcons.mapMarkerAlt),
    UnitData(name: 'Yard', symbol: 'yd', conversionFactor: 0.9144, icon: FontAwesomeIcons.arrowsAltH),
    UnitData(name: 'Foot', symbol: 'ft', conversionFactor: 0.3048, icon: FontAwesomeIcons.shoePrints),
    UnitData(name: 'Inch', symbol: 'in', conversionFactor: 0.0254, icon: FontAwesomeIcons.rulerCombined),
  ];

  // Volume units (base: liter)
  static const List<UnitData> volumeUnits = [
    UnitData(name: 'Liter', symbol: 'L', conversionFactor: 1.0, icon: FontAwesomeIcons.flask),
    UnitData(name: 'Milliliter', symbol: 'mL', conversionFactor: 0.001, icon: FontAwesomeIcons.vial),
    UnitData(name: 'Cubic Meter', symbol: 'm³', conversionFactor: 1000.0, icon: FontAwesomeIcons.cube),
    UnitData(name: 'Gallon (US)', symbol: 'gal', conversionFactor: 3.78541, icon: FontAwesomeIcons.gasPump),
    UnitData(name: 'Gallon (UK)', symbol: 'gal', conversionFactor: 4.54609, icon: FontAwesomeIcons.gasPump),
    UnitData(name: 'Quart', symbol: 'qt', conversionFactor: 0.946353, icon: FontAwesomeIcons.wineBottle),
    UnitData(name: 'Pint', symbol: 'pt', conversionFactor: 0.473176, icon: FontAwesomeIcons.beer),
    UnitData(name: 'Cup', symbol: 'cup', conversionFactor: 0.236588, icon: FontAwesomeIcons.mugHot),
  ];

  // Temperature units (special handling required)
  static const List<UnitData> temperatureUnits = [
    UnitData(name: 'Celsius', symbol: '°C', conversionFactor: 1.0, icon: FontAwesomeIcons.thermometerHalf),
    UnitData(name: 'Fahrenheit', symbol: '°F', conversionFactor: 1.0, icon: FontAwesomeIcons.thermometerFull),
    UnitData(name: 'Kelvin', symbol: 'K', conversionFactor: 1.0, icon: FontAwesomeIcons.snowflake),
  ];

  // Area units (base: square meter)
  static const List<UnitData> areaUnits = [
    UnitData(name: 'Square Meter', symbol: 'm²', conversionFactor: 1.0, icon: FontAwesomeIcons.thLarge),
    UnitData(name: 'Square Kilometer', symbol: 'km²', conversionFactor: 1000000.0, icon: FontAwesomeIcons.map),
    UnitData(name: 'Square Centimeter', symbol: 'cm²', conversionFactor: 0.0001, icon: FontAwesomeIcons.borderAll),
    UnitData(name: 'Hectare', symbol: 'ha', conversionFactor: 10000.0, icon: FontAwesomeIcons.tree),
    UnitData(name: 'Acre', symbol: 'ac', conversionFactor: 4046.86, icon: FontAwesomeIcons.home),
    UnitData(name: 'Square Mile', symbol: 'mi²', conversionFactor: 2589988.11, icon: FontAwesomeIcons.mapMarkedAlt),
    UnitData(name: 'Square Yard', symbol: 'yd²', conversionFactor: 0.836127, icon: FontAwesomeIcons.expand),
    UnitData(name: 'Square Foot', symbol: 'ft²', conversionFactor: 0.092903, icon: FontAwesomeIcons.home),
    UnitData(name: 'Square Inch', symbol: 'in²', conversionFactor: 0.00064516, icon: FontAwesomeIcons.crop),
  ];

  // Speed units (base: meter per second)
  static const List<UnitData> speedUnits = [
    UnitData(name: 'Meter/Second', symbol: 'm/s', conversionFactor: 1.0, icon: FontAwesomeIcons.tachometerAlt),
    UnitData(name: 'Kilometer/Hour', symbol: 'km/h', conversionFactor: 0.277778, icon: FontAwesomeIcons.car),
    UnitData(name: 'Mile/Hour', symbol: 'mph', conversionFactor: 0.44704, icon: FontAwesomeIcons.carSide),
    UnitData(name: 'Knot', symbol: 'kn', conversionFactor: 0.514444, icon: FontAwesomeIcons.ship),
    UnitData(name: 'Foot/Second', symbol: 'ft/s', conversionFactor: 0.3048, icon: FontAwesomeIcons.running),
  ];

  static const Map<UnitCategory, CategoryData> categories = {
    UnitCategory.weight: CategoryData(
      category: UnitCategory.weight,
      displayName: 'Weight & Mass',
      icon: FontAwesomeIcons.weightHanging,
      units: weightUnits,
    ),
    UnitCategory.length: CategoryData(
      category: UnitCategory.length,
      displayName: 'Length & Distance',
      icon: FontAwesomeIcons.ruler,
      units: lengthUnits,
    ),
    UnitCategory.volume: CategoryData(
      category: UnitCategory.volume,
      displayName: 'Volume & Capacity',
      icon: FontAwesomeIcons.flask,
      units: volumeUnits,
    ),
    UnitCategory.temperature: CategoryData(
      category: UnitCategory.temperature,
      displayName: 'Temperature',
      icon: FontAwesomeIcons.thermometerHalf,
      units: temperatureUnits,
    ),
    UnitCategory.area: CategoryData(
      category: UnitCategory.area,
      displayName: 'Area',
      icon: FontAwesomeIcons.thLarge,
      units: areaUnits,
    ),
    UnitCategory.speed: CategoryData(
      category: UnitCategory.speed,
      displayName: 'Speed',
      icon: FontAwesomeIcons.tachometerAlt,
      units: speedUnits,
    ),
  };
}

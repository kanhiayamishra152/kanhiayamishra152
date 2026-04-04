enum UnitCategory {
  weight,
  length,
  volume,
  temperature,
  area,
  speed,
}

class UnitData {
  final String name;
  final String symbol;
  final double conversionFactor; // Factor to convert to base unit
  final IconData icon;

  const UnitData({
    required this.name,
    required this.symbol,
    required this.conversionFactor,
    required this.icon,
  });
}

class CategoryData {
  final UnitCategory category;
  final String displayName;
  final IconData icon;
  final List<UnitData> units;

  const CategoryData({
    required this.category,
    required this.displayName,
    required this.icon,
    required this.units,
  });
}

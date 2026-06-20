// ═══════════════════════════════════════════════════════
// GREENTRACK — COMPLETE DATA MODELS
// ═══════════════════════════════════════════════════════

import 'package:flutter/material.dart';

// ── ENUMS ──────────────────────────────────────────────

enum CropStatus {
  seedling,
  sprouting,
  vegetative,
  flowering,
  fruiting,
  readyToHarvest,
  harvested,
  concern,
  failed;

  String get label {
    switch (this) {
      case CropStatus.seedling:       return 'Seedling';
      case CropStatus.sprouting:      return 'Sprouting';
      case CropStatus.vegetative:     return 'Vegetative';
      case CropStatus.flowering:      return 'Flowering';
      case CropStatus.fruiting:       return 'Fruiting';
      case CropStatus.readyToHarvest: return 'Ready to Harvest';
      case CropStatus.harvested:      return 'Harvested';
      case CropStatus.concern:        return 'Needs Attention';
      case CropStatus.failed:         return 'Failed';
    }
  }

  String get emoji {
    switch (this) {
      case CropStatus.seedling:       return '🌱';
      case CropStatus.sprouting:      return '🌿';
      case CropStatus.vegetative:     return '🍃';
      case CropStatus.flowering:      return '🌸';
      case CropStatus.fruiting:       return '🫐';
      case CropStatus.readyToHarvest: return '🌾';
      case CropStatus.harvested:      return '✅';
      case CropStatus.concern:        return '⚠️';
      case CropStatus.failed:         return '💀';
    }
  }

  Color get color {
    switch (this) {
      case CropStatus.seedling:       return const Color(0xFF2B6CB0);
      case CropStatus.sprouting:      return const Color(0xFF40916C);
      case CropStatus.vegetative:     return const Color(0xFF27AE60);
      case CropStatus.flowering:      return const Color(0xFF6B46C1);
      case CropStatus.fruiting:       return const Color(0xFFE67E22);
      case CropStatus.readyToHarvest: return const Color(0xFFD4A017);
      case CropStatus.harvested:      return const Color(0xFF1B4332);
      case CropStatus.concern:        return const Color(0xFFC0392B);
      case CropStatus.failed:         return const Color(0xFF718096);
    }
  }

  Color get bgColor => color.withOpacity(0.1);

  double get progressValue {
    switch (this) {
      case CropStatus.seedling:       return 0.1;
      case CropStatus.sprouting:      return 0.25;
      case CropStatus.vegetative:     return 0.45;
      case CropStatus.flowering:      return 0.60;
      case CropStatus.fruiting:       return 0.75;
      case CropStatus.readyToHarvest: return 0.92;
      case CropStatus.harvested:      return 1.0;
      case CropStatus.concern:        return 0.5;
      case CropStatus.failed:         return 0.0;
    }
  }
}

enum CropCategory {
  vegetable, fruit, herb, rootCrop, leafy, grain, legume, flower;

  String get label {
    switch (this) {
      case CropCategory.vegetable: return 'Vegetable';
      case CropCategory.fruit:     return 'Fruit';
      case CropCategory.herb:      return 'Herb';
      case CropCategory.rootCrop:  return 'Root Crop';
      case CropCategory.leafy:     return 'Leafy Green';
      case CropCategory.grain:     return 'Grain';
      case CropCategory.legume:    return 'Legume';
      case CropCategory.flower:    return 'Flower';
    }
  }

  String get emoji {
    switch (this) {
      case CropCategory.vegetable: return '🥦';
      case CropCategory.fruit:     return '🍇';
      case CropCategory.herb:      return '🌿';
      case CropCategory.rootCrop:  return '🥕';
      case CropCategory.leafy:     return '🥬';
      case CropCategory.grain:     return '🌾';
      case CropCategory.legume:    return '🫘';
      case CropCategory.flower:    return '🌺';
    }
  }
}

enum HarvestDestination {
  consumed, sold, donated, stored, composted;

  String get label {
    switch (this) {
      case HarvestDestination.consumed:  return 'Consumed at Home';
      case HarvestDestination.sold:      return 'Sold at Market';
      case HarvestDestination.donated:   return 'Donated';
      case HarvestDestination.stored:    return 'Stored / Preserved';
      case HarvestDestination.composted: return 'Composted';
    }
  }

  String get emoji {
    switch (this) {
      case HarvestDestination.consumed:  return '🍽️';
      case HarvestDestination.sold:      return '🛒';
      case HarvestDestination.donated:   return '❤️';
      case HarvestDestination.stored:    return '📦';
      case HarvestDestination.composted: return '♻️';
    }
  }

  Color get color {
    switch (this) {
      case HarvestDestination.consumed:  return const Color(0xFF40916C);
      case HarvestDestination.sold:      return const Color(0xFFD4A017);
      case HarvestDestination.donated:   return const Color(0xFF2B6CB0);
      case HarvestDestination.stored:    return const Color(0xFF95D5B2);
      case HarvestDestination.composted: return const Color(0xFF718096);
    }
  }
}

enum WateringFrequency {
  daily, everyTwoDays, twiceWeekly, weekly, asNeeded;

  String get label {
    switch (this) {
      case WateringFrequency.daily:        return 'Daily';
      case WateringFrequency.everyTwoDays: return 'Every 2 Days';
      case WateringFrequency.twiceWeekly:  return 'Twice a Week';
      case WateringFrequency.weekly:       return 'Weekly';
      case WateringFrequency.asNeeded:     return 'As Needed';
    }
  }
}

enum SunExposure {
  fullSun, partialShade, fullShade;

  String get label {
    switch (this) {
      case SunExposure.fullSun:     return 'Full Sun (6+ hrs)';
      case SunExposure.partialShade: return 'Partial Shade (3-6 hrs)';
      case SunExposure.fullShade:   return 'Full Shade (<3 hrs)';
    }
  }
}

enum SoilType {
  loam, sandy, clay, silty, peaty, chalky, pottingMix;

  String get label {
    switch (this) {
      case SoilType.loam:       return 'Loam';
      case SoilType.sandy:      return 'Sandy Loam';
      case SoilType.clay:       return 'Clay';
      case SoilType.silty:      return 'Silty';
      case SoilType.peaty:      return 'Peaty';
      case SoilType.chalky:     return 'Chalky';
      case SoilType.pottingMix: return 'Potting Mix';
    }
  }
}

enum ActivityType {
  watering, fertilizing, pruning, pestControl, transplanting,
  harvesting, soilTest, observation, photo;

  String get label {
    switch (this) {
      case ActivityType.watering:      return 'Watering';
      case ActivityType.fertilizing:   return 'Fertilizing';
      case ActivityType.pruning:       return 'Pruning';
      case ActivityType.pestControl:   return 'Pest Control';
      case ActivityType.transplanting: return 'Transplanting';
      case ActivityType.harvesting:    return 'Harvest Logged';
      case ActivityType.soilTest:      return 'Soil Test';
      case ActivityType.observation:   return 'Observation';
      case ActivityType.photo:         return 'Photo Added';
    }
  }

  String get emoji {
    switch (this) {
      case ActivityType.watering:      return '💧';
      case ActivityType.fertilizing:   return '🧪';
      case ActivityType.pruning:       return '✂️';
      case ActivityType.pestControl:   return '🐛';
      case ActivityType.transplanting: return '🪴';
      case ActivityType.harvesting:    return '🌾';
      case ActivityType.soilTest:      return '🔬';
      case ActivityType.observation:   return '👁️';
      case ActivityType.photo:         return '📸';
    }
  }

  Color get color {
    switch (this) {
      case ActivityType.watering:      return const Color(0xFF2B6CB0);
      case ActivityType.fertilizing:   return const Color(0xFF6B46C1);
      case ActivityType.pruning:       return const Color(0xFF40916C);
      case ActivityType.pestControl:   return const Color(0xFFC0392B);
      case ActivityType.transplanting: return const Color(0xFF1B4332);
      case ActivityType.harvesting:    return const Color(0xFFD4A017);
      case ActivityType.soilTest:      return const Color(0xFF718096);
      case ActivityType.observation:   return const Color(0xFF4A5568);
      case ActivityType.photo:         return const Color(0xFFE67E22);
    }
  }
}

enum QualityRating { poor, fair, good, excellent, outstanding }

enum SeasonType { spring, summer, autumn, winter, yearRound }

// ── MODELS ────────────────────────────────────────────

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String location;
  final String climateZone;
  final DateTime createdAt;
  final GardenStats stats;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.location,
    required this.climateZone,
    required this.createdAt,
    required this.stats,
  });
}

class GardenStats {
  final int totalCrops;
  final int activeCrops;
  final double totalHarvestKg;
  final int totalHarvestCount;
  final double seasonGoalKg;
  final int daysActive;

  const GardenStats({
    required this.totalCrops,
    required this.activeCrops,
    required this.totalHarvestKg,
    required this.totalHarvestCount,
    required this.seasonGoalKg,
    required this.daysActive,
  });

  double get goalProgress => totalHarvestKg / seasonGoalKg;
}

class GardenPlot {
  final String id;
  final String name;
  final String description;
  final double widthM;
  final double lengthM;
  final SoilType soilType;
  final SunExposure sunExposure;
  final bool hasIrrigation;
  final bool isRaisedBed;
  final bool isContainer;
  final int containerCount;
  final List<String> cropIds;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime lastCaredAt;
  final String emoji;

  const GardenPlot({
    required this.id,
    required this.name,
    required this.description,
    required this.widthM,
    required this.lengthM,
    required this.soilType,
    required this.sunExposure,
    required this.hasIrrigation,
    required this.isRaisedBed,
    required this.isContainer,
    this.containerCount = 0,
    required this.cropIds,
    this.imageUrl,
    required this.createdAt,
    required this.lastCaredAt,
    required this.emoji,
  });

  double get areaM2 => isContainer ? containerCount.toDouble() : widthM * lengthM;
  String get sizeLabel => isContainer
    ? '$containerCount containers'
    : '${widthM}m × ${lengthM}m';
  int get activeCropCount => cropIds.length;
}

class CropModel {
  final String id;
  final String name;
  final String variety;
  final CropCategory category;
  final CropStatus status;
  final String plotId;
  final DateTime plantingDate;
  final DateTime expectedHarvestDate;
  final DateTime? actualHarvestDate;
  final WateringFrequency wateringFrequency;
  final String emoji;
  final double estimatedYieldKg;
  final double actualYieldKg;
  final int quantityPlanted;
  final List<String> growthRecordIds;
  final List<String> harvestIds;
  final List<String> activityIds;
  final List<String> photoUrls;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isFavorite;
  final Map<String, dynamic> customFields;

  const CropModel({
    required this.id,
    required this.name,
    required this.variety,
    required this.category,
    required this.status,
    required this.plotId,
    required this.plantingDate,
    required this.expectedHarvestDate,
    this.actualHarvestDate,
    required this.wateringFrequency,
    required this.emoji,
    required this.estimatedYieldKg,
    this.actualYieldKg = 0,
    required this.quantityPlanted,
    this.growthRecordIds = const [],
    this.harvestIds = const [],
    this.activityIds = const [],
    this.photoUrls = const [],
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite = false,
    this.customFields = const {},
  });

  int get daysInGround => DateTime.now().difference(plantingDate).inDays;
  int get daysToHarvest => expectedHarvestDate.difference(DateTime.now()).inDays;
  bool get isOverdue => daysToHarvest < 0 && status != CropStatus.harvested;
  bool get isNearHarvest => daysToHarvest >= 0 && daysToHarvest <= 7;
  double get harvestProgress => status.progressValue;
  double get yieldProgress => estimatedYieldKg > 0 ? actualYieldKg / estimatedYieldKg : 0;

  CropModel copyWith({
    CropStatus? status,
    double? actualYieldKg,
    List<String>? growthRecordIds,
    List<String>? harvestIds,
    List<String>? photoUrls,
    String? notes,
    bool? isFavorite,
  }) {
    return CropModel(
      id: id, name: name, variety: variety,
      category: category,
      status: status ?? this.status,
      plotId: plotId,
      plantingDate: plantingDate,
      expectedHarvestDate: expectedHarvestDate,
      wateringFrequency: wateringFrequency,
      emoji: emoji,
      estimatedYieldKg: estimatedYieldKg,
      actualYieldKg: actualYieldKg ?? this.actualYieldKg,
      quantityPlanted: quantityPlanted,
      growthRecordIds: growthRecordIds ?? this.growthRecordIds,
      harvestIds: harvestIds ?? this.harvestIds,
      photoUrls: photoUrls ?? this.photoUrls,
      notes: notes ?? this.notes,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class GrowthRecord {
  final String id;
  final String cropId;
  final DateTime recordedAt;
  final double heightCm;
  final int leafCount;
  final String health;
  final String? notes;
  final List<String> photoUrls;
  final double? soilMoisture;
  final double? temperature;
  final bool floweringObserved;
  final bool fruitingObserved;

  const GrowthRecord({
    required this.id,
    required this.cropId,
    required this.recordedAt,
    required this.heightCm,
    required this.leafCount,
    required this.health,
    this.notes,
    this.photoUrls = const [],
    this.soilMoisture,
    this.temperature,
    this.floweringObserved = false,
    this.fruitingObserved = false,
  });
}

class HarvestRecord {
  final String id;
  final String cropId;
  final String plotId;
  final DateTime harvestDate;
  final double quantityKg;
  final HarvestDestination destination;
  final QualityRating quality;
  final String? notes;
  final List<String> photoUrls;
  final double? pricePerKg;
  final String? buyerName;

  const HarvestRecord({
    required this.id,
    required this.cropId,
    required this.plotId,
    required this.harvestDate,
    required this.quantityKg,
    required this.destination,
    required this.quality,
    this.notes,
    this.photoUrls = const [],
    this.pricePerKg,
    this.buyerName,
  });

  double get estimatedValue => (pricePerKg ?? 0) * quantityKg;
}

class ActivityLog {
  final String id;
  final String? cropId;
  final String? plotId;
  final ActivityType type;
  final DateTime performedAt;
  final String description;
  final String? notes;
  final Map<String, dynamic> metadata;

  const ActivityLog({
    required this.id,
    this.cropId,
    this.plotId,
    required this.type,
    required this.performedAt,
    required this.description,
    this.notes,
    this.metadata = const {},
  });
}

class WateringLog {
  final String id;
  final String cropId;
  final DateTime wateredAt;
  final double volumeLiters;
  final String method;
  final String? notes;

  const WateringLog({
    required this.id,
    required this.cropId,
    required this.wateredAt,
    required this.volumeLiters,
    required this.method,
    this.notes,
  });
}

class SeasonSummary {
  final String season;
  final int year;
  final int totalCropsPlanted;
  final int successfulHarvests;
  final double totalYieldKg;
  final double totalWaterLiters;
  final int totalActivities;
  final Map<String, double> yieldByCrop;
  final Map<HarvestDestination, double> harvestByDestination;

  const SeasonSummary({
    required this.season,
    required this.year,
    required this.totalCropsPlanted,
    required this.successfulHarvests,
    required this.totalYieldKg,
    required this.totalWaterLiters,
    required this.totalActivities,
    required this.yieldByCrop,
    required this.harvestByDestination,
  });
}

class WeatherData {
  final double tempC;
  final double humidity;
  final double windKph;
  final double rainfallMm;
  final String condition;
  final String iconCode;
  final String tip;
  final bool isGoodForPlanting;
  final bool isGoodForHarvesting;

  const WeatherData({
    required this.tempC,
    required this.humidity,
    required this.windKph,
    required this.rainfallMm,
    required this.condition,
    required this.iconCode,
    required this.tip,
    required this.isGoodForPlanting,
    required this.isGoodForHarvesting,
  });

  String get emoji {
    if (condition.contains('rain')) return '🌧️';
    if (condition.contains('cloud')) return '⛅';
    if (condition.contains('sun') || condition.contains('clear')) return '☀️';
    if (condition.contains('storm')) return '⛈️';
    return '🌤️';
  }
}

class AppNotification {
  final String id;
  final String title;
  final String body;
  final String emoji;
  final DateTime scheduledAt;
  final bool isRead;
  final String? cropId;
  final String type;

  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.emoji,
    required this.scheduledAt,
    this.isRead = false,
    this.cropId,
    required this.type,
  });
}

// ── MOCK DATA ─────────────────────────────────────────

class MockData {
  static final List<GardenPlot> plots = [
    GardenPlot(
      id: 'plot_a', name: 'Main Bed',
      description: 'Primary vegetable growing area with rich loam soil. South-facing for maximum sunlight.',
      widthM: 4, lengthM: 3,
      soilType: SoilType.loam,
      sunExposure: SunExposure.fullSun,
      hasIrrigation: true, isRaisedBed: false, isContainer: false,
      cropIds: ['c1','c3','c6','c9'],
      createdAt: DateTime(2024, 1, 15),
      lastCaredAt: DateTime.now().subtract(const Duration(hours: 6)),
      emoji: '🌱',
    ),
    GardenPlot(
      id: 'plot_b', name: 'Raised Bed',
      description: 'Elevated raised bed perfect for herbs and leafy greens. Excellent drainage.',
      widthM: 2, lengthM: 2,
      soilType: SoilType.sandy,
      sunExposure: SunExposure.partialShade,
      hasIrrigation: false, isRaisedBed: true, isContainer: false,
      cropIds: ['c2','c5','c8','c11'],
      createdAt: DateTime(2024, 2, 1),
      lastCaredAt: DateTime.now().subtract(const Duration(days: 1)),
      emoji: '🌿',
    ),
    GardenPlot(
      id: 'plot_c', name: 'Container Garden',
      description: 'Flexible container setup on the patio. Great for herbs and compact vegetables.',
      widthM: 1, lengthM: 1,
      soilType: SoilType.pottingMix,
      sunExposure: SunExposure.fullSun,
      hasIrrigation: false, isRaisedBed: false, isContainer: true,
      containerCount: 10,
      cropIds: ['c4','c7','c10','c12'],
      createdAt: DateTime(2024, 3, 5),
      lastCaredAt: DateTime.now().subtract(const Duration(hours: 12)),
      emoji: '🪴',
    ),
  ];

  static final List<CropModel> crops = [
    CropModel(
      id: 'c1', name: 'Cherry Tomatoes', variety: 'Sweet Million',
      category: CropCategory.fruit, status: CropStatus.readyToHarvest,
      plotId: 'plot_a', emoji: '🍅',
      plantingDate: DateTime(2024, 4, 10),
      expectedHarvestDate: DateTime.now().add(const Duration(days: 3)),
      wateringFrequency: WateringFrequency.everyTwoDays,
      estimatedYieldKg: 3.2, actualYieldKg: 0, quantityPlanted: 4,
      notes: 'Excellent growth this season. Check for fruit set daily.',
      isFavorite: true,
      createdAt: DateTime(2024, 4, 10),
      updatedAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    CropModel(
      id: 'c2', name: 'Basil', variety: 'Italian Large Leaf',
      category: CropCategory.herb, status: CropStatus.readyToHarvest,
      plotId: 'plot_b', emoji: '🌿',
      plantingDate: DateTime(2024, 4, 20),
      expectedHarvestDate: DateTime.now().add(const Duration(days: 1)),
      wateringFrequency: WateringFrequency.daily,
      estimatedYieldKg: 0.8, actualYieldKg: 0.2, quantityPlanted: 6,
      notes: 'Pinch tops regularly to prevent bolting.',
      isFavorite: false,
      createdAt: DateTime(2024, 4, 20),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    CropModel(
      id: 'c3', name: 'Lettuce', variety: 'Butterhead',
      category: CropCategory.leafy, status: CropStatus.vegetative,
      plotId: 'plot_a', emoji: '🥬',
      plantingDate: DateTime(2024, 5, 1),
      expectedHarvestDate: DateTime.now().add(const Duration(days: 9)),
      wateringFrequency: WateringFrequency.daily,
      estimatedYieldKg: 1.4, actualYieldKg: 0, quantityPlanted: 8,
      createdAt: DateTime(2024, 5, 1),
      updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
    CropModel(
      id: 'c4', name: 'Cucumber', variety: 'English Long',
      category: CropCategory.vegetable, status: CropStatus.fruiting,
      plotId: 'plot_c', emoji: '🥒',
      plantingDate: DateTime(2024, 4, 15),
      expectedHarvestDate: DateTime.now().add(const Duration(days: 16)),
      wateringFrequency: WateringFrequency.everyTwoDays,
      estimatedYieldKg: 4.5, actualYieldKg: 0.8, quantityPlanted: 3,
      createdAt: DateTime(2024, 4, 15),
      updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    CropModel(
      id: 'c5', name: 'Bell Pepper', variety: 'California Wonder',
      category: CropCategory.vegetable, status: CropStatus.fruiting,
      plotId: 'plot_b', emoji: '🫑',
      plantingDate: DateTime(2024, 3, 28),
      expectedHarvestDate: DateTime.now().add(const Duration(days: 11)),
      wateringFrequency: WateringFrequency.everyTwoDays,
      estimatedYieldKg: 2.8, actualYieldKg: 0.5, quantityPlanted: 4,
      isFavorite: true,
      createdAt: DateTime(2024, 3, 28),
      updatedAt: DateTime.now().subtract(const Duration(hours: 18)),
    ),
    CropModel(
      id: 'c6', name: 'Sweet Corn', variety: 'Golden Bantam',
      category: CropCategory.grain, status: CropStatus.vegetative,
      plotId: 'plot_a', emoji: '🌽',
      plantingDate: DateTime(2024, 5, 10),
      expectedHarvestDate: DateTime.now().add(const Duration(days: 42)),
      wateringFrequency: WateringFrequency.twiceWeekly,
      estimatedYieldKg: 6.0, actualYieldKg: 0, quantityPlanted: 12,
      createdAt: DateTime(2024, 5, 10),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    CropModel(
      id: 'c7', name: 'Spring Onion', variety: 'White Lisbon',
      category: CropCategory.vegetable, status: CropStatus.vegetative,
      plotId: 'plot_c', emoji: '🧅',
      plantingDate: DateTime(2024, 5, 15),
      expectedHarvestDate: DateTime.now().add(const Duration(days: 21)),
      wateringFrequency: WateringFrequency.everyTwoDays,
      estimatedYieldKg: 0.6, actualYieldKg: 0, quantityPlanted: 20,
      createdAt: DateTime(2024, 5, 15),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    CropModel(
      id: 'c8', name: 'Kale', variety: 'Curly Scotch',
      category: CropCategory.leafy, status: CropStatus.concern,
      plotId: 'plot_b', emoji: '🌱',
      plantingDate: DateTime(2024, 5, 5),
      expectedHarvestDate: DateTime.now().add(const Duration(days: 26)),
      wateringFrequency: WateringFrequency.daily,
      estimatedYieldKg: 1.2, actualYieldKg: 0, quantityPlanted: 6,
      notes: '⚠️ Aphid damage observed on lower leaves. Apply neem oil.',
      createdAt: DateTime(2024, 5, 5),
      updatedAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    CropModel(
      id: 'c9', name: 'Eggplant', variety: 'Black Beauty',
      category: CropCategory.vegetable, status: CropStatus.flowering,
      plotId: 'plot_a', emoji: '🍆',
      plantingDate: DateTime(2024, 4, 8),
      expectedHarvestDate: DateTime.now().add(const Duration(days: 31)),
      wateringFrequency: WateringFrequency.everyTwoDays,
      estimatedYieldKg: 3.5, actualYieldKg: 0, quantityPlanted: 3,
      isFavorite: true,
      createdAt: DateTime(2024, 4, 8),
      updatedAt: DateTime.now().subtract(const Duration(hours: 24)),
    ),
    CropModel(
      id: 'c10', name: 'Carrot', variety: 'Nantes Half-Long',
      category: CropCategory.rootCrop, status: CropStatus.vegetative,
      plotId: 'plot_c', emoji: '🥕',
      plantingDate: DateTime(2024, 4, 25),
      expectedHarvestDate: DateTime.now().add(const Duration(days: 29)),
      wateringFrequency: WateringFrequency.twiceWeekly,
      estimatedYieldKg: 2.0, actualYieldKg: 0, quantityPlanted: 30,
      createdAt: DateTime(2024, 4, 25),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    CropModel(
      id: 'c11', name: 'Pechay', variety: 'White Stem Bok Choy',
      category: CropCategory.leafy, status: CropStatus.readyToHarvest,
      plotId: 'plot_b', emoji: '🌸',
      plantingDate: DateTime(2024, 5, 20),
      expectedHarvestDate: DateTime.now().add(const Duration(days: 6)),
      wateringFrequency: WateringFrequency.daily,
      estimatedYieldKg: 1.8, actualYieldKg: 0, quantityPlanted: 10,
      createdAt: DateTime(2024, 5, 20),
      updatedAt: DateTime.now().subtract(const Duration(hours: 8)),
    ),
    CropModel(
      id: 'c12', name: 'String Beans', variety: 'Pole Beans Sitao',
      category: CropCategory.legume, status: CropStatus.readyToHarvest,
      plotId: 'plot_c', emoji: '🫘',
      plantingDate: DateTime(2024, 4, 30),
      expectedHarvestDate: DateTime.now().add(const Duration(days: 8)),
      wateringFrequency: WateringFrequency.everyTwoDays,
      estimatedYieldKg: 2.4, actualYieldKg: 0.6, quantityPlanted: 15,
      createdAt: DateTime(2024, 4, 30),
      updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
  ];

  static final List<HarvestRecord> harvests = [
    HarvestRecord(
      id: 'h31', cropId: 'c1', plotId: 'plot_a',
      harvestDate: DateTime.now().subtract(const Duration(days: 4)),
      quantityKg: 1.4, destination: HarvestDestination.consumed,
      quality: QualityRating.excellent, notes: 'Perfect flavour, zero blemishes',
      pricePerKg: 80,
    ),
    HarvestRecord(
      id: 'h30', cropId: 'c2', plotId: 'plot_b',
      harvestDate: DateTime.now().subtract(const Duration(days: 5)),
      quantityKg: 0.2, destination: HarvestDestination.consumed,
      quality: QualityRating.outstanding, notes: 'Very aromatic, harvested tops only',
    ),
    HarvestRecord(
      id: 'h29', cropId: 'c3', plotId: 'plot_a',
      harvestDate: DateTime.now().subtract(const Duration(days: 7)),
      quantityKg: 0.6, destination: HarvestDestination.consumed,
      quality: QualityRating.good, notes: 'Outer leaves only, plant still growing',
    ),
    HarvestRecord(
      id: 'h28', cropId: 'c5', plotId: 'plot_b',
      harvestDate: DateTime.now().subtract(const Duration(days: 9)),
      quantityKg: 0.9, destination: HarvestDestination.sold,
      quality: QualityRating.excellent, notes: 'Sold at Sunday market',
      pricePerKg: 120, buyerName: 'Aling Rosa',
    ),
    HarvestRecord(
      id: 'h27', cropId: 'c4', plotId: 'plot_c',
      harvestDate: DateTime.now().subtract(const Duration(days: 11)),
      quantityKg: 1.8, destination: HarvestDestination.donated,
      quality: QualityRating.good, notes: 'Shared with neighbors on Maharlika St.',
    ),
    HarvestRecord(
      id: 'h26', cropId: 'c11', plotId: 'plot_b',
      harvestDate: DateTime.now().subtract(const Duration(days: 13)),
      quantityKg: 1.2, destination: HarvestDestination.stored,
      quality: QualityRating.excellent, notes: 'Blanched and frozen for later use',
    ),
    HarvestRecord(
      id: 'h25', cropId: 'c12', plotId: 'plot_c',
      harvestDate: DateTime.now().subtract(const Duration(days: 15)),
      quantityKg: 0.6, destination: HarvestDestination.consumed,
      quality: QualityRating.good,
    ),
  ];

  static final List<ActivityLog> activities = [
    ActivityLog(
      id: 'a1', cropId: 'c1', plotId: 'plot_a',
      type: ActivityType.watering,
      performedAt: DateTime.now().subtract(const Duration(hours: 3)),
      description: 'Watered Cherry Tomatoes (Plot A) — 1.5 L applied',
    ),
    ActivityLog(
      id: 'a2', cropId: 'c2',
      type: ActivityType.observation,
      performedAt: DateTime.now().subtract(const Duration(hours: 6)),
      description: 'Basil reached 28 cm — looking very healthy and fragrant',
    ),
    ActivityLog(
      id: 'a3', cropId: 'c2',
      type: ActivityType.harvesting,
      performedAt: DateTime.now().subtract(const Duration(days: 1)),
      description: 'Harvested Basil: 0.2 kg → consumed at home',
    ),
    ActivityLog(
      id: 'a4', cropId: 'c8', plotId: 'plot_b',
      type: ActivityType.pestControl,
      performedAt: DateTime.now().subtract(const Duration(days: 1, hours: 4)),
      description: '⚠️ Kale: Aphid infestation detected. Applied neem oil solution.',
    ),
    ActivityLog(
      id: 'a5', cropId: 'c12', plotId: 'plot_c',
      type: ActivityType.watering,
      performedAt: DateTime.now().subtract(const Duration(days: 2)),
      description: 'String Beans watered — 2.0 L applied via watering can',
    ),
    ActivityLog(
      id: 'a6', cropId: 'c9', plotId: 'plot_a',
      type: ActivityType.fertilizing,
      performedAt: DateTime.now().subtract(const Duration(days: 2, hours: 8)),
      description: 'Applied organic compost tea to Eggplant — 0.5 L per plant',
    ),
    ActivityLog(
      id: 'a7', cropId: 'c3',
      type: ActivityType.harvesting,
      performedAt: DateTime.now().subtract(const Duration(days: 7)),
      description: 'Lettuce outer leaves harvested: 0.6 kg → consumed at home',
    ),
  ];

  static final List<GrowthRecord> growthRecords = [
    GrowthRecord(
      id: 'g1', cropId: 'c1',
      recordedAt: DateTime.now().subtract(const Duration(days: 7)),
      heightCm: 85, leafCount: 42, health: 'Excellent',
      notes: 'Fruit clusters forming nicely, good colour.',
      floweringObserved: true, fruitingObserved: true,
    ),
    GrowthRecord(
      id: 'g2', cropId: 'c1',
      recordedAt: DateTime.now().subtract(const Duration(days: 14)),
      heightCm: 72, leafCount: 36, health: 'Good',
      floweringObserved: true, fruitingObserved: false,
    ),
    GrowthRecord(
      id: 'g3', cropId: 'c2',
      recordedAt: DateTime.now().subtract(const Duration(days: 3)),
      heightCm: 28, leafCount: 24, health: 'Excellent',
      notes: 'Very bushy and aromatic.', floweringObserved: false, fruitingObserved: false,
    ),
    GrowthRecord(
      id: 'g4', cropId: 'c8',
      recordedAt: DateTime.now().subtract(const Duration(days: 2)),
      heightCm: 32, leafCount: 18, health: 'Concern',
      notes: 'Aphid damage on lower 4 leaves. Yellow spotting observed.',
      floweringObserved: false, fruitingObserved: false,
    ),
  ];

  static final WeatherData weather = WeatherData(
    tempC: 24.0, humidity: 68, windKph: 12, rainfallMm: 8.4,
    condition: 'Partly Cloudy',
    iconCode: 'partly_cloudy',
    tip: 'Ideal conditions for transplanting seedlings. Water tomatoes deeply this morning.',
    isGoodForPlanting: true, isGoodForHarvesting: true,
  );

  static final GardenStats stats = GardenStats(
    totalCrops: 18, activeCrops: 12,
    totalHarvestKg: 48.6, totalHarvestCount: 31,
    seasonGoalKg: 72.0, daysActive: 156,
  );

  static final UserModel user = UserModel(
    id: 'u1', name: 'Maria Reyes', email: 'maria@greentrack.app',
    location: 'Quezon City, Philippines',
    climateZone: 'Tropical Humid',
    createdAt: DateTime(2024, 1, 1),
    stats: stats,
  );

  static List<AppNotification> notifications = [
    AppNotification(
      id: 'n1', emoji: '🌾', type: 'harvest',
      title: 'Cherry Tomatoes Ready!',
      body: 'Your cherry tomatoes in Plot A are ready to harvest. Expected: 3.2 kg.',
      scheduledAt: DateTime.now().subtract(const Duration(hours: 2)),
      cropId: 'c1', isRead: false,
    ),
    AppNotification(
      id: 'n2', emoji: '💧', type: 'watering',
      title: 'Watering Reminder',
      body: 'Basil and Lettuce are due for watering today.',
      scheduledAt: DateTime.now().subtract(const Duration(hours: 5)),
      isRead: false,
    ),
    AppNotification(
      id: 'n3', emoji: '⚠️', type: 'alert',
      title: 'Kale Needs Attention',
      body: 'Aphid damage detected on your Kale in Plot B. Apply neem oil solution.',
      scheduledAt: DateTime.now().subtract(const Duration(days: 1)),
      cropId: 'c8', isRead: true,
    ),
    AppNotification(
      id: 'n4', emoji: '🌸', type: 'milestone',
      title: 'Eggplant is Flowering! 🎉',
      body: 'Your Black Beauty eggplant has started flowering. Harvest in ~4 weeks.',
      scheduledAt: DateTime.now().subtract(const Duration(days: 2)),
      cropId: 'c9', isRead: true,
    ),
  ];

  // Monthly harvest data for charts
  static List<Map<String, dynamic>> monthlyYield = [
    {'month': 'Jan', '2024': 2.1, '2023': 1.6},
    {'month': 'Feb', '2024': 1.8, '2023': 1.4},
    {'month': 'Mar', '2024': 3.4, '2023': 2.8},
    {'month': 'Apr', '2024': 5.2, '2023': 4.1},
    {'month': 'May', '2024': 6.8, '2023': 5.5},
    {'month': 'Jun', '2024': 8.4, '2023': 6.9},
    {'month': 'Jul', '2024': 0,   '2023': 7.2},
    {'month': 'Aug', '2024': 0,   '2023': 6.4},
  ];

  static List<Map<String, dynamic>> yieldByCrop = [
    {'crop': 'Tomato', 'emoji': '🍅', 'kg': 12.4, 'color': 0xFFC0392B},
    {'crop': 'Cucumber', 'emoji': '🥒', 'kg': 9.8, 'color': 0xFF27AE60},
    {'crop': 'Eggplant', 'emoji': '🍆', 'kg': 8.2, 'color': 0xFF6B46C1},
    {'crop': 'Corn', 'emoji': '🌽', 'kg': 7.6, 'color': 0xFFD4A017},
    {'crop': 'Bell Pepper', 'emoji': '🫑', 'kg': 6.3, 'color': 0xFFE67E22},
    {'crop': 'Carrot', 'emoji': '🥕', 'kg': 5.1, 'color': 0xFFD4A017},
    {'crop': 'Beans', 'emoji': '🫘', 'kg': 4.8, 'color': 0xFF40916C},
    {'crop': 'Pechay', 'emoji': '🌸', 'kg': 4.2, 'color': 0xFF40916C},
  ];
}

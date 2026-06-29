import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/models.dart';

class LogHarvestScreen extends StatefulWidget {
  const LogHarvestScreen({super.key});

  @override
  State<LogHarvestScreen> createState() => _LogHarvestScreenState();
}

class _LogHarvestScreenState extends State<LogHarvestScreen> {
  CropModel? _selectedCrop;
  DateTime _harvestDate = DateTime.now();
  double _quantity = 1.0;
  HarvestDestination _destination = HarvestDestination.consumed;
  QualityRating _quality = QualityRating.good;
  final _notesCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();

  final _qualityLabels = {
    QualityRating.poor: ('😞', 'Poor'),
    QualityRating.fair: ('😐', 'Fair'),
    QualityRating.good: ('🙂', 'Good'),
    QualityRating.excellent: ('😃', 'Excellent'),
    QualityRating.outstanding: ('🤩', 'Outstanding'),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.parchment,
      appBar: AppBar(
        title: const Text('Log Harvest 🌾'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Crop *',
                style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: MockData.crops.length,
                itemBuilder: (_, i) {
                  final crop = MockData.crops[i];
                  final isSelected = crop.id == _selectedCrop?.id;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCrop = crop),
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? AppColors.paleGreen : AppColors.cream,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected ? AppColors.leaf : AppColors.border,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(crop.emoji,
                              style: const TextStyle(fontSize: 26)),
                          const SizedBox(height: 6),
                          Text(crop.name,
                              style: AppTextStyles.body(9,
                                  weight: FontWeight.w700,
                                  color: AppColors.forest),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text('Harvest Date',
                style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                    context: context,
                    initialDate: _harvestDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030));
                if (picked != null) setState(() => _harvestDate = picked);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_rounded,
                        size: 18, color: AppColors.leaf),
                    const SizedBox(width: 10),
                    Text(
                        '${_harvestDate.day}/${_harvestDate.month}/${_harvestDate.year}',
                        style: AppTextStyles.body(14, weight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Quantity (kg) *',
                style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cream,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Text('${_quantity.toStringAsFixed(1)} kg',
                      style: AppTextStyles.display(32, color: AppColors.leaf)),
                  Slider(
                    value: _quantity,
                    min: 0.1,
                    max: 10,
                    divisions: 99,
                    onChanged: (v) => setState(() => _quantity = v),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('0.1 kg',
                          style: AppTextStyles.body(10,
                              color: AppColors.slateLight)),
                      Text('10 kg',
                          style: AppTextStyles.body(10,
                              color: AppColors.slateLight)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text('Quality Rating',
                style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: QualityRating.values.map((q) {
                final isSelected = q == _quality;
                final (emoji, label) = _qualityLabels[q]!;
                return GestureDetector(
                  onTap: () => setState(() => _quality = q),
                  child: Column(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.amberPale
                              : AppColors.cream,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                isSelected ? AppColors.amber : AppColors.border,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Center(
                            child: Text(emoji,
                                style: const TextStyle(fontSize: 24))),
                      ),
                      const SizedBox(height: 4),
                      Text(label,
                          style: AppTextStyles.body(9,
                              color: isSelected
                                  ? AppColors.amber
                                  : AppColors.slateLight,
                              weight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w400)),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text('Produce Destination *',
                style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 10),
            ...HarvestDestination.values.map((d) {
              final isSelected = d == _destination;
              return GestureDetector(
                onTap: () => setState(() => _destination = d),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? d.color.withOpacity(0.08)
                        : AppColors.cream,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected ? d.color : AppColors.border,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(d.emoji, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: Text(d.label,
                              style: AppTextStyles.body(13,
                                  weight: FontWeight.w600,
                                  color:
                                      isSelected ? d.color : AppColors.slate))),
                      if (isSelected)
                        Icon(Icons.check_circle_rounded,
                            color: d.color, size: 20),
                    ],
                  ),
                ),
              );
            }),
            if (_destination == HarvestDestination.sold) ...[
              const SizedBox(height: 8),
              Text('Price per kg (₱)',
                  style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 8),
              TextField(
                controller: _priceCtrl,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(hintText: '0.00', prefixText: '₱ '),
              ),
            ],
            const SizedBox(height: 20),
            Text('Notes (Optional)',
                style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 8),
            TextField(
              controller: _notesCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                  hintText:
                      'Quality observations, storage method, buyer info…'),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedCrop == null ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.amber,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('🌾 Save Harvest Record'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _submit() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                    color: AppColors.amberPale, shape: BoxShape.circle),
                child: const Center(
                    child: Text('🌾', style: TextStyle(fontSize: 36))),
              ).animate().scale(curve: Curves.elasticOut, duration: 500.ms),
              const SizedBox(height: 20),
              Text('Harvest Logged!',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                  '${_quantity.toStringAsFixed(1)} kg of ${_selectedCrop?.name} → ${_destination.label}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.pop();
                  },
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

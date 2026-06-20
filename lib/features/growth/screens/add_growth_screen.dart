import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../data/models/models.dart';

class AddGrowthScreen extends StatefulWidget {
  const AddGrowthScreen({super.key});

  @override
  State<AddGrowthScreen> createState() => _AddGrowthScreenState();
}

class _AddGrowthScreenState extends State<AddGrowthScreen> {
  CropModel? _selectedCrop;
  double _height = 20;
  int _leafCount = 10;
  String _health = 'Healthy';
  bool _flowering = false;
  bool _fruiting = false;
  final _notesCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.parchment,
      appBar: AppBar(title: const Text('Growth Update 📏')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Crop *', style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 10),
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: MockData.crops.length,
                itemBuilder: (_, i) {
                  final crop = MockData.crops[i];
                  final isSelected = crop.id == _selectedCrop?.id;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCrop = crop),
                    child: Container(
                      width: 76,
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.purpleLight : AppColors.cream,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected ? AppColors.purple : AppColors.border,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(crop.emoji, style: const TextStyle(fontSize: 24)),
                          const SizedBox(height: 4),
                          Text(crop.name,
                            style: AppTextStyles.body(8, weight: FontWeight.w700),
                            textAlign: TextAlign.center, maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            Text('Plant Height', style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cream, borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Text('${_height.toInt()} cm',
                    style: AppTextStyles.display(32, color: AppColors.purple)),
                  Slider(
                    value: _height, min: 1, max: 200,
                    activeColor: AppColors.purple,
                    onChanged: (v) => setState(() => _height = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text('Leaf Count', style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton.filled(
                  onPressed: () => setState(() => _leafCount = (_leafCount - 1).clamp(0, 999)),
                  icon: const Icon(Icons.remove),
                  style: IconButton.styleFrom(backgroundColor: AppColors.border,
                    foregroundColor: AppColors.slate),
                ),
                Expanded(
                  child: Center(
                    child: Text('$_leafCount',
                      style: AppTextStyles.display(28, color: AppColors.leaf)),
                  ),
                ),
                IconButton.filled(
                  onPressed: () => setState(() => _leafCount++),
                  icon: const Icon(Icons.add),
                  style: IconButton.styleFrom(backgroundColor: AppColors.leaf,
                    foregroundColor: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Text('Overall Health', style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _HealthOption('🟢', 'Healthy', _health, (v) => setState(() => _health = v))),
                const SizedBox(width: 8),
                Expanded(child: _HealthOption('🟡', 'Concern', _health, (v) => setState(() => _health = v))),
                const SizedBox(width: 8),
                Expanded(child: _HealthOption('🔴', 'Attention', _health, (v) => setState(() => _health = v))),
              ],
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cream, borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    value: _flowering,
                    onChanged: (v) => setState(() => _flowering = v),
                    title: const Text('🌸 Flowering Observed'),
                    dense: true,
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    value: _fruiting,
                    onChanged: (v) => setState(() => _fruiting = v),
                    title: const Text('🫐 Fruiting Observed'),
                    dense: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text('Observation Notes', style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 8),
            TextField(
              controller: _notesCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Color, pest signs, general observations…'),
            ),
            const SizedBox(height: 16),

            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt_outlined, size: 18),
              label: const Text('Attach Photo'),
              style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedCrop == null ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('📏 Save Growth Record'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _submit() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('📏 Growth record saved for ${_selectedCrop?.name}!')));
    context.pop();
  }
}

class _HealthOption extends StatelessWidget {
  final String emoji, value, current;
  final ValueChanged<String> onTap;
  const _HealthOption(this.emoji, this.value, this.current, this.onTap);

  @override
  Widget build(BuildContext context) {
    final isSelected = value == current;
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.paleGreen : AppColors.cream,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? AppColors.leaf : AppColors.border,
            width: isSelected ? 2 : 1),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 4),
            Text(value, style: AppTextStyles.body(10, weight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

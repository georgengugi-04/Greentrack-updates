import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/models.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<AppNotification> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = List.from(MockData.notifications);
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notifications.where((n) => !n.isRead).length;

    return Scaffold(
      backgroundColor: AppColors.parchment,
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: () => setState(() {
                _notifications = _notifications
                    .map((n) => AppNotification(
                          id: n.id,
                          title: n.title,
                          body: n.body,
                          emoji: n.emoji,
                          scheduledAt: n.scheduledAt,
                          isRead: true,
                          cropId: n.cropId,
                          type: n.type,
                        ))
                    .toList();
              }),
              child: const Text('Mark all read'),
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmpty()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _notifications.length,
              itemBuilder: (_, i) {
                final n = _notifications[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (_) =>
                              setState(() => _notifications.removeAt(i)),
                          backgroundColor: AppColors.red.withOpacity(0.1),
                          foregroundColor: AppColors.red,
                          icon: Icons.delete_outline_rounded,
                          label: 'Delete',
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ],
                    ),
                    child: _NotificationTile(notification: n, index: i),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🔔', style: TextStyle(fontSize: 56)),
          const SizedBox(height: 12),
          Text('No notifications',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Text('You\'re all caught up!',
              style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final AppNotification notification;
  final int index;
  const _NotificationTile({required this.notification, required this.index});

  @override
  Widget build(BuildContext context) {
    final typeColors = {
      'harvest': AppColors.amber,
      'watering': AppColors.blue,
      'alert': AppColors.red,
      'milestone': AppColors.purple,
    };
    final color = typeColors[notification.type] ?? AppColors.leaf;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: notification.isRead ? AppColors.cream : color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              notification.isRead ? AppColors.border : color.withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12)),
            child: Center(
                child: Text(notification.emoji,
                    style: const TextStyle(fontSize: 20))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(notification.title,
                          style: AppTextStyles.body(13,
                              weight: FontWeight.w700,
                              color: AppColors.forest)),
                    ),
                    if (!notification.isRead)
                      Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                              color: AppColors.amber, shape: BoxShape.circle)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(notification.body,
                    style: AppTextStyles.body(11, color: AppColors.slateMid)),
                const SizedBox(height: 6),
                Text(_timeAgo(notification.scheduledAt),
                    style: AppTextStyles.body(10, color: AppColors.slateLight)),
              ],
            ),
          ),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: 60 * index))
        .fadeIn()
        .slideX(begin: 0.05);
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}

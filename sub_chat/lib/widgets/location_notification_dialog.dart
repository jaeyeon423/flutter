import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_service.dart';

class LocationNotificationDialog extends StatelessWidget {
  final Position position;
  
  const LocationNotificationDialog({
    super.key,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    final locationService = LocationService();
    final locationString = locationService.getLocationString(position);
    
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Icon(
            Icons.location_on,
            color: Theme.of(context).primaryColor,
            size: 28,
          ),
          const SizedBox(width: 8),
          const Text(
            '현재 위치',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locationString,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '업데이트 시간: ${_formatTime(DateTime.now())}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '위치 서비스가 1분마다 자동으로 위치를 체크합니다.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('확인'),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
            _openMapsApp(position);
          },
          icon: const Icon(Icons.map, size: 16),
          label: const Text('지도에서 보기'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:'
           '${dateTime.minute.toString().padLeft(2, '0')}:'
           '${dateTime.second.toString().padLeft(2, '0')}';
  }

  void _openMapsApp(Position position) {
    // 구글 맵스나 기본 지도 앱에서 위치 열기
    final url = 'geo:${position.latitude},${position.longitude}';
    print('지도 앱으로 이동: $url');
    // 실제 구현에서는 url_launcher 패키지를 사용하여 지도 앱을 열 수 있습니다.
  }
}

class LocationUpdateNotification {
  static void show(BuildContext context, Position position) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return LocationNotificationDialog(position: position);
      },
    );
  }

  /// 간단한 스낵바 형태의 위치 알림
  static void showSnackBar(BuildContext context, Position position) {
    final locationService = LocationService();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '위치가 업데이트되었습니다',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        action: SnackBarAction(
          label: '상세보기',
          textColor: Colors.white,
          onPressed: () {
            show(context, position);
          },
        ),
      ),
    );
  }
}
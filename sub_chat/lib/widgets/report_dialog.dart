import 'package:flutter/material.dart';
import '../services/report_service.dart';
import '../services/auth_service.dart';

class ReportDialog extends StatefulWidget {
  final String? messageId;
  final String? messageContent;
  final String reportedUserId;
  final String reportedUserName;
  final String roomId;
  final VoidCallback? onReported;

  const ReportDialog({
    super.key,
    this.messageId,
    this.messageContent,
    required this.reportedUserId,
    required this.reportedUserName,
    required this.roomId,
    this.onReported,
  });

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final ReportService _reportService = ReportService();
  final AuthService _authService = AuthService();
  final TextEditingController _reasonController = TextEditingController();
  ReportType? _selectedReportType;
  bool _isSubmitting = false;

  bool get _isMessageReport => widget.messageId != null;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _submitReport() async {
    if (_selectedReportType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('신고 사유를 선택해주세요.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final currentUser = _authService.currentUser;
      if (currentUser == null) {
        throw Exception('로그인이 필요합니다.');
      }
      
      final reporterUserId = currentUser.uid;
      final reporterUserName = currentUser.displayName ?? '사용자';

      if (_isMessageReport) {
        await _reportService.reportMessage(
          messageId: widget.messageId!,
          roomId: widget.roomId,
          reportedUserId: widget.reportedUserId,
          reportedUserName: widget.reportedUserName,
          reporterUserId: reporterUserId,
          reporterUserName: reporterUserName,
          messageContent: widget.messageContent ?? '',
          reportType: _selectedReportType!,
          additionalReason: _reasonController.text.trim().isNotEmpty
              ? _reasonController.text.trim()
              : null,
        );
      } else {
        await _reportService.reportUser(
          reportedUserId: widget.reportedUserId,
          reportedUserName: widget.reportedUserName,
          reporterUserId: reporterUserId,
          reporterUserName: reporterUserName,
          roomId: widget.roomId,
          reportType: _selectedReportType!,
          additionalReason: _reasonController.text.trim().isNotEmpty
              ? _reasonController.text.trim()
              : null,
        );
      }

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _isMessageReport ? '메시지를 신고했습니다.' : '사용자를 신고했습니다.',
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green,
          ),
        );
        widget.onReported?.call();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('신고 처리 중 오류가 발생했습니다: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.report,
            color: Colors.red[700],
          ),
          const SizedBox(width: 8),
          Text(_isMessageReport ? '메시지 신고' : '사용자 신고'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 신고 대상 정보
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _isMessageReport ? Icons.message : Icons.person,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _isMessageReport ? '신고할 메시지' : '신고할 사용자',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.reportedUserName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_isMessageReport && widget.messageContent != null) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        widget.messageContent!,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 신고 사유 선택
            const Text(
              '신고 사유',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            ...ReportType.values.map((reportType) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedReportType = reportType;
                  });
                },
                child: Row(
                  children: [
                    // The following line is ignored because the suggested fix (using a RadioGroup) does not exist in Flutter.
                    // ignore: deprecated_member_use
                    Radio<ReportType>(
                      value: reportType,
                      // ignore: deprecated_member_use
                      groupValue: _selectedReportType,
                      // ignore: deprecated_member_use
                      onChanged: (ReportType? value) {
                        setState(() {
                          _selectedReportType = value;
                        });
                      },
                    ),
                    Text(reportType.displayName),
                  ],
                ),
              );
            }),

            const SizedBox(height: 16),

            // 추가 설명
            const Text(
              '추가 설명 (선택사항)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _reasonController,
              decoration: InputDecoration(
                hintText: '신고 사유에 대한 자세한 설명을 입력해주세요...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
              maxLines: 3,
              maxLength: 500,
            ),

            const SizedBox(height: 8),

            // 경고 메시지
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red[200]!),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: Colors.red[700],
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '허위 신고 시 계정 제재를 받을 수 있습니다. 신중하게 신고해주세요.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
          child: const Text('취소'),
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submitReport,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[700],
            foregroundColor: Colors.white,
          ),
          child: _isSubmitting
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text('신고하기'),
        ),
      ],
    );
  }
}
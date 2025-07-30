import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_app/providers/chat_providers.dart';
import 'package:flutter/services.dart';

class NewMessage extends ConsumerStatefulWidget {
  const NewMessage({super.key});

  @override
  ConsumerState<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends ConsumerState<NewMessage> {
  final _messageController = TextEditingController();
  final _focusNode = FocusNode();
  var _isLoading = false;
  var _isTyping = false;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _messageController.removeListener(_onTextChanged);
    _messageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final isTyping = _messageController.text.trim().isNotEmpty;
    if (_isTyping != isTyping) {
      setState(() {
        _isTyping = isTyping;
      });
    }
  }

  void _sendMessage() async {
    final enteredMessage = _messageController.text.trim();

    if (enteredMessage.isEmpty) {
      return;
    }

    // Haptic feedback for better UX
    HapticFeedback.lightImpact();

    setState(() {
      _isLoading = true;
    });

    _messageController.clear();
    _focusNode.requestFocus(); // Keep focus after sending

    try {
      final sendMessage = ref.read(sendMessageProvider);
      await sendMessage(text: enteredMessage);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send message: $error'),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Attachment button
            Container(
              margin: const EdgeInsets.only(right: 8, bottom: 4),
              child: IconButton(
                onPressed: () {
                  // TODO: Implement attachment functionality
                  HapticFeedback.lightImpact();
                },
                icon: const Icon(Icons.add),
                style: IconButton.styleFrom(
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  foregroundColor: theme.colorScheme.onSurface,
                  padding: const EdgeInsets.all(12),
                  minimumSize: const Size(44, 44),
                ),
              ),
            ),
            
            // Text input field
            Expanded(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 120),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _messageController,
                  focusNode: _focusNode,
                  enabled: !_isLoading,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  maxLines: null,
                  minLines: 1,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.4,
                    letterSpacing: 0.1,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    suffixIcon: _isTyping ? Container(
                      margin: const EdgeInsets.all(8),
                      child: IconButton(
                        onPressed: () {
                          _messageController.clear();
                          HapticFeedback.lightImpact();
                        },
                        icon: const Icon(Icons.close, size: 20),
                        style: IconButton.styleFrom(
                          backgroundColor: theme.colorScheme.outline.withValues(alpha: 0.1),
                          foregroundColor: theme.colorScheme.onSurface,
                          minimumSize: const Size(32, 32),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ) : null,
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            
            // Send button
            Container(
              margin: const EdgeInsets.only(left: 8, bottom: 4),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: IconButton(
                  onPressed: (_isLoading || !_isTyping) ? null : _sendMessage,
                  icon: _isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                  style: IconButton.styleFrom(
                    backgroundColor: (_isTyping && !_isLoading) 
                        ? theme.colorScheme.primary 
                        : theme.colorScheme.outline.withValues(alpha: 0.3),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(12),
                    minimumSize: const Size(44, 44),
                    shape: const CircleBorder(),
                    elevation: (_isTyping && !_isLoading) ? 2 : 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
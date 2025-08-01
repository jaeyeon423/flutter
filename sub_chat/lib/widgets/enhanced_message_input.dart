import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnhancedMessageInput extends StatefulWidget {
  final Function(String) onSendMessage;
  final bool isLoading;
  final String? hintText;
  
  const EnhancedMessageInput({
    super.key,
    required this.onSendMessage,
    this.isLoading = false,
    this.hintText,
  });

  @override
  State<EnhancedMessageInput> createState() => _EnhancedMessageInputState();
}

class _EnhancedMessageInputState extends State<EnhancedMessageInput>
    with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _canSend = false;
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChanged);
    _controller.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final canSend = _controller.text.trim().isNotEmpty;
    if (_canSend != canSend) {
      setState(() {
        _canSend = canSend;
      });
      
      if (canSend) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  void _onFocusChanged() {
    setState(() {
      _isExpanded = _focusNode.hasFocus;
    });
  }

  void _sendMessage() {
    if (!_canSend || widget.isLoading) return;
    
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      HapticFeedback.lightImpact();
      widget.onSendMessage(text);
      _controller.clear();
      setState(() {
        _canSend = false;
      });
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 12 : 24,
      ),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                constraints: const BoxConstraints(
                  minHeight: 48,
                  maxHeight: 120,
                ),
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark
                      ? Colors.grey[800]
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(24),
                  border: _isExpanded
                      ? Border.all(
                          color: theme.primaryColor.withOpacity(0.5),
                          width: 2,
                        )
                      : null,
                ),
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.newline,
                  enabled: !widget.isLoading,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: widget.hintText ?? '메시지를 입력하세요...',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    prefixIcon: _isExpanded
                        ? Icon(
                            Icons.chat_bubble_outline,
                            color: theme.primaryColor.withOpacity(0.6),
                            size: 20,
                          )
                        : null,
                  ),
                  onSubmitted: (_) {
                    if (!widget.isLoading) {
                      _sendMessage();
                    }
                  },
                ),
              ),
            ),
            
            const SizedBox(width: 12),
            
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: _canSend && !widget.isLoading
                          ? LinearGradient(
                              colors: [
                                theme.primaryColor,
                                theme.primaryColor.withOpacity(0.8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      color: !_canSend || widget.isLoading
                          ? Colors.grey[300]
                          : null,
                      shape: BoxShape.circle,
                      boxShadow: _canSend && !widget.isLoading
                          ? [
                              BoxShadow(
                                color: theme.primaryColor.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: _canSend && !widget.isLoading ? _sendMessage : null,
                        child: Center(
                          child: widget.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Icon(
                                  Icons.send_rounded,
                                  color: _canSend ? Colors.white : Colors.grey[500],
                                  size: 20,
                                ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
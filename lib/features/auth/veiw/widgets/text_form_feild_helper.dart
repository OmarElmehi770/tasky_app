import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldHelper extends StatefulWidget {
  final TextEditingController? controller;
  final bool isPassword;
  final String? hint, obscuringCharacter;
  final bool enabled;
  final int? maxLines, minLines, maxLength;
  final String? Function(String?)? onValidate;
  final void Function(String?)? onChanged, onFieldSubmitted, onSaved;
  final void Function()? onEditingComplete, onTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixWidget, prefixIcon, prefix;
  final IconData? icon;
  final TextInputAction? action;
  final FocusNode? focusNode;
  final bool? hasBorder;
  final BorderRadius? borderRadius;
  final bool? isMobile;
  final TextStyle? style;

  const TextFormFieldHelper({
    super.key,
    this.controller,
    this.isPassword = false,
    this.hint,
    this.enabled = true,
    this.obscuringCharacter,
    this.onValidate,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onSaved,
    this.onTap,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.suffixWidget,
    this.icon,
    this.prefixIcon,
    this.prefix,
    this.action,
    this.focusNode,
    this.borderRadius,
    this.isMobile,
    this.hasBorder,
    this.style,
  });

  @override
  State<TextFormFieldHelper> createState() => _TextFormFieldHelperState();
}

class _TextFormFieldHelperState extends State<TextFormFieldHelper> {
  late bool obscureText;
  TextDirection _textDirection = TextDirection.ltr;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  void _toggleObscureText() {
    setState(() => obscureText = !obscureText);
  }

  void _updateTextDirection(String text) {
    if (text.isEmpty) return;
    final isArabic = RegExp(r'^[\u0600-\u06FF]').hasMatch(text);
    setState(() {
      _textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.onValidate,
      onChanged: (text) {
        widget.onChanged?.call(text);
        _updateTextDirection(text);
      },
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      onTap: widget.onTap,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      obscureText: obscureText,
      obscuringCharacter: widget.obscuringCharacter ?? '*',

      keyboardType: widget.keyboardType,
      // inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      textInputAction: widget.action ?? TextInputAction.next,
      focusNode: widget.focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: widget.style ?? TextStyle(
        fontSize: 16,
        // fontFamily: FontFamilyHelper.tajawalArabic,
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w500,
      ),

      textAlign: widget.isMobile != null ? TextAlign.left : TextAlign.start,

      textDirection: widget.isMobile != null
          ? TextDirection.ltr
          : _textDirection,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        filled: false,
        hintText: widget.hint,
        hintStyle: const TextStyle(
          fontSize: 18,
          // fontFamily: FontFamilyHelper.tajawalArabic,
          color: Color(0xff817D8D),
          fontWeight: FontWeight.w400,
        ),
        errorMaxLines: 4,
        errorStyle: const TextStyle(color: Colors.red),
        prefixIcon: widget.prefixIcon,
        prefix: widget.prefix,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: _toggleObscureText,
                child: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                  size: 27,
                ),
              )
            : widget.suffixWidget,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        border: widget.hasBorder == null
            ? outlineInputBorder(color: Color(0xffBABABA), width: 1)
            : InputBorder.none,
        enabledBorder: widget.hasBorder == null
            ? outlineInputBorder(color: Color(0xffBABABA), width: 1)
            : InputBorder.none,
        focusedBorder: widget.hasBorder == null
            ? outlineInputBorder(color: Color(0xffBABABA), width: 1)
            : InputBorder.none,
        errorBorder: widget.hasBorder == null
            ? outlineInputBorder(color: Colors.red, width: 1)
            : InputBorder.none,
        focusedErrorBorder: widget.hasBorder == null
            ? outlineInputBorder(color: Colors.red, width: 1)
            : InputBorder.none,
      ),
    );
  }

  OutlineInputBorder outlineInputBorder({
    required Color color,
    required double width,
  }) {
    return OutlineInputBorder(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(40),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}

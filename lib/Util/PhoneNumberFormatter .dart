import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newTextLength = newValue.text.length;
    var selectionIndex = newValue.selection.end;
    var usedSubstringIndex = 0;
    final newText = StringBuffer();

    // Counter for added characters, spaces, and separators.
    var addedCharacters = 0;

    // Keep track of cursor movement.
    var cursorOffset = 0;

    if (newTextLength >= 1) {
      newText.write('+');
      addedCharacters++;
      if (newValue.selection.end >= 1) cursorOffset++;
    }

    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ' ');
      addedCharacters++;
      if (newValue.selection.end >= 4) cursorOffset++;
    }

    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + ' ');
      addedCharacters++;
      if (newValue.selection.end >= 7) cursorOffset++;
    }

    if (newTextLength >= 10) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 9) + ' ');
      addedCharacters++;
      if (newValue.selection.end >= 10) cursorOffset++;
    }

    if (newTextLength >= 13) {
      newText.write(newValue.text.substring(9, usedSubstringIndex = 12));
      // Max length reached, no need to increment cursorOffset.
    } else if (newTextLength > 9) {
      newText.write(newValue.text.substring(9));
    }

    // Adjust selection index for cursor movement.
    if (newValue.selection.end == newTextLength) {
      // Cursor at the end, no adjustment needed.
      selectionIndex += cursorOffset;
    } else {
      // Cursor is not at the end, adjust based on added characters.
      selectionIndex += cursorOffset - addedCharacters;
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

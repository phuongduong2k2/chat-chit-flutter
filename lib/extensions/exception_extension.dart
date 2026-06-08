extension FormattedMessage on Exception {
  String get cleanMessage {
    final text = toString();
    return text.startsWith("Exception: ") ? text.substring(11) : text;
  }
}

enum levelFlag { MEDIUM, LOW, HEIGH }

extension toStringLevel on levelFlag {
  String toS() {
    switch (this) {
      case levelFlag.MEDIUM:
        return "medium";
      case levelFlag.HEIGH:
        return "high";
      case levelFlag.LOW:
        return "low";
    }
  }
}

class CapitalizeService {
  static String capitalizeEachWord(String text) {
    return text
        .split(' ')
        .map(
          (word) =>
              word.isEmpty ? word : word[0].toUpperCase() + word.substring(1),
        )
        .join(' ');
  }
}

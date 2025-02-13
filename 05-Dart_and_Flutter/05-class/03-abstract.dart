abstract class Media {
  late String myId;
  late String myTitle;
  late String myType;

  void setMediaTitle(String mediaTitle); // 추상 메서드
  String getMediaTitle(); // 추상 메서드

  void setMediaType(String mediaType);
  String getMediaType();

  void setMediaId(String mediaId);
  String getMediaId();
}

class Book implements Media {
  @override
  late String myId;
  @override
  late String myTitle;
  @override
  late String myType;

  @override
  void setMediaTitle(String mediaTitle) {
    myTitle = mediaTitle;
  }

  @override
  String getMediaTitle() {
    return myTitle;
  }

  @override
  void setMediaType(String mediaType) {
    myType = mediaType;
  }

  @override
  String getMediaType() {
    return myType;
  }

  @override
  void setMediaId(String mediaId) {
    myId = mediaId;
  }

  @override
  String getMediaId() {
    return myId;
  }

  Book() {
    myTitle = '';
    myType = '';
    myId = '';
  }

  Book.withParams(String mediaTitle, String mediaType, String mediaId) {
    myTitle = mediaTitle;
    myType = mediaType;
    myId = mediaId;
  }
}

void main() {
  var myBook = Book();

  myBook.setMediaId('1234');
  myBook.setMediaTitle('Dart Programming');
  myBook.setMediaType('Book');

  print('Media ID: ${myBook.getMediaId()}');
  print('Media Title: ${myBook.getMediaTitle()}');
  print('Media Type: ${myBook.getMediaType()}');

  // 클래스 메서드를 사용하여 인스턴스 생성
  var myBook2 = Book.withParams('Dart Programming', 'Book', '1234');

  print('Media ID: ${myBook2.getMediaId()}');
  print('Media Title: ${myBook2.getMediaTitle()}');
}

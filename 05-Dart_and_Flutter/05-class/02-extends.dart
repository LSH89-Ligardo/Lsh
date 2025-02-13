class Media {
  String title = "";
  String type = "";

  Media() {
    type = "Class";
  }

  void setMediaTitle(String mediaTitle) {
    title = mediaTitle;
  }

  String getMediaTitle() {
    return title;
  }

  String getMediaType() {
    return type;
  }
}

// Book는 Media 클래스를 상속받음
class Book extends Media {
  String author = "";
  String publisher = "";

  Book() {
    type = "Subclass";
  }

  void setBookAuthor(String bookAuthor) {
    author = bookAuthor;
  }

  void setBookPublisher(String bookPublisher) {
    publisher = bookPublisher;
  }

  String getBookAuthor() {
    return author;
  }

  String getBookPublisher() {
    return publisher;
  }
}

void main() {
  var myMedia = Media();

  myMedia.setMediaTitle("Dart Programming");
  print('Media Title: ${myMedia.getMediaTitle()}');
  print('Media Type: ${myMedia.getMediaType()}');

  var myBook = Book();
  myBook.setMediaTitle("Dart Programming");
  myBook.setBookAuthor("John Doe");
  myBook.setBookPublisher("Dart Publisher");

  print('Book Title: ${myBook.getMediaTitle()}');
  print('Book Author: ${myBook.getBookAuthor()}');
  print('Book Publisher: ${myBook.getBookPublisher()}');
}

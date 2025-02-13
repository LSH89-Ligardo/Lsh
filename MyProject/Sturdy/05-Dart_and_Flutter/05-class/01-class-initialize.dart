// class Book {
//   String title;
//   String author;
//   String publisher;
// }

const numDays = 7; // 상수 선언: 1주일은 7일

class DaysLeftInWeek {
  int currentDay = 0;

  // 생성자
  DaysLeftInWeek() {
    currentDay = DateTime.now().weekday;
  }

  // 메서드: 남은 일 수 계산
  int howManyDaysLeft() {
    return numDays - currentDay;
  }
}

void main() {
  // 클래스 인스턴스 생성
  var daysLeft = DaysLeftInWeek();

  // 메서드 호출
  print('There are ${daysLeft.howManyDaysLeft()} days left in the week');
}

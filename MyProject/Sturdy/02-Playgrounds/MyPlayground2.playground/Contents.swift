import Foundation

func normalizedStarRating(forRating rating: Float, ofPossibleTotal total: Float) -> (Int, String) {
    let fraction = rating / total
    let ratingOutOf5 = fraction * 5
    let rounedRating = round(ratingOutOf5)
    let numberOfStars = Int(rounedRating)
    let ratingString = "\(numberOfStars) Star Movie"
    return (numberOfStars, ratingString)
}

let ratingAndDisplayString = normalizedStarRating(forRating: 5, ofPossibleTotal: 10)
let ratingNumber = ratingAndDisplayString.0
let ratingString = ratingAndDisplayString.1
print("Rating: \(ratingNumber), Rating String: \(ratingString)")

// 배열
var moviesToWatch: Array<String> = Array()
moviesToWatch.append("Star Wars")
moviesToWatch.append("The Lion King")
moviesToWatch.append("The Incredibles")

print(moviesToWatch[0])
print(moviesToWatch[1])
print(moviesToWatch[2])
// print(moviesToWatch[3]) error: Execution was interrupted, reason: EXC_BREAKPOINT (code=1, subcode=0x194c6c7a8).
print(moviesToWatch.count)

// for (int i = 0; i < 3; i++) {
//    printf("%d", movie[i]);
// }

// 배열 새 요소 삽입
moviesToWatch.insert("The Avengers", at: 1)
print(moviesToWatch[1])

// 요소 삭제
let removedItem = moviesToWatch.remove(at: 2)
print(removedItem) // 삭제된 아이템 반환 값
print(moviesToWatch[2]) // 뒤에 있던 아이템이 당겨짐
print(moviesToWatch)
print(moviesToWatch.count)

let firstMovieToWatch = moviesToWatch.first
print(firstMovieToWatch ?? "No movie")

let lastMovieToWatch = moviesToWatch.last
print(lastMovieToWatch as Any)

// Array<String> == [String]
let spyMovieSuggestions: [String] = ["The Bourne Identity", "Casino Royale", "Mission Impossible"]
moviesToWatch += spyMovieSuggestions // moviesToWatch = moviesToWatch + spyMovieSuggestions
print(moviesToWatch)
print(moviesToWatch.count)

var starWarsTrilogy = Array<String>(repeating: "Star Wars: ", count: 3)
starWarsTrilogy[0] = starWarsTrilogy[0] + "A New Hope"
starWarsTrilogy[1] += "The Empire Strikes Back"
starWarsTrilogy[2] += "The Return of the Jedi"
print(starWarsTrilogy)

// 특정 범위의 요소 교체
moviesToWatch.replaceSubrange(2...4, with: starWarsTrilogy) // 2,3,4
print(moviesToWatch)

// 불변(immutable) 배열 NSArray
let moviesToWatchCopy = moviesToWatch
// moviesToWatchCopy.append("The Force Awakens")
print(moviesToWatchCopy)

// 가변(mutable) NSMutableArray
var moviesToWatchCopy2 = moviesToWatchCopy
moviesToWatchCopy2.append("The Force Awakens")
print(moviesToWatchCopy2)

// 집합 (Set)
let fibonacciArray: Array<Int> = [1, 1, 2, 3, 5, 8, 13, 21, 34]
var fibonacciSet: Set<Int> = Set(fibonacciArray)
print(fibonacciSet)
print(fibonacciArray.count)
print(fibonacciSet.count)

// 집합의 요소 삽입, 제거
fibonacciSet.insert(35)
print(fibonacciSet)
print(fibonacciSet.contains(35))
fibonacciSet.remove(35)
print(fibonacciSet.contains(35))

let evenNumbers = Set<Int>(arrayLiteral: 2, 4, 6, 8, 10)
let oddNumbers: Set<Int> = [1, 3, 5, 7, 9]
let squareNumbers: Set<Int> = [1, 4, 9]
let triangularNumbers: Set<Int> = [1, 3, 6, 10]

// 합집합
let evenOrTriangularNumbers = evenNumbers.union(triangularNumbers)
// 2, 4, 6, 8, 10, 1, 3, 순서 없음
print(evenOrTriangularNumbers.count) // 7

// 교집합
let oddAndSquareNumbers = oddNumbers.intersection(squareNumbers)
// 1, 9, 순서 없음
print(oddAndSquareNumbers.count) // 2

// 대칭 차집합
let squareOrTriangularNotBoth = squareNumbers.symmetricDifference(triangularNumbers)
// 4, 9, 3, 6, 10, 순서 없음
print(squareOrTriangularNotBoth.count) // 5

// 집합 뺄셈
let squareNotOdd = squareNumbers.subtracting(oddNumbers) // 4
print(squareNotOdd.count) // 1

// 집합의 멤버십
let animalKingdom: Set<String> = ["dog", "cat", "pigeon", "chimpanzee", "snake", "kangaroo", "giraffe", "elephant", "tiger", "lion", "panther"]
let vertebrates: Set<String> = ["dog", "cat", "pigeon", "chimpanzee", "snake", "kangaroo", "giraffe", "elephant", "tiger", "lion", "panther"]
let reptile: Set<String> = ["snake"]
let mammals: Set<String> = ["dog", "cat", "chimpanzee", "kangaroo", "giraffe", "elephant", "tiger", "lion", "panther"]
let catFamily: Set<String> = ["cat", "tiger", "lion", "panther"]
let domesticAnimals: Set<String> = ["cat", "dog"]

print(mammals.isSubset(of: animalKingdom))

print(mammals.isSuperset(of: catFamily))

print(vertebrates.isStrictSubset(of: animalKingdom))
print(vertebrates.isSubset(of: animalKingdom))
print(mammals.isStrictSubset(of: animalKingdom))


print(animalKingdom.isStrictSuperset(of: vertebrates))
print(animalKingdom.isStrictSuperset(of: domesticAnimals))

// 서로소(Disjoint)
print(catFamily.isDisjoint(with: reptile))


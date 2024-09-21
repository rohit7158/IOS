import UIKit


//Question no. 1
let maxStudents :Int = 30
var currentNumberOfStudents :Int = 0
var numberOfStudentsInClass :Int = 0
var studentName = ""
var studentAge = 0
var studentGrade = ""
let mathScore = 85
var scienceScore = 90
var englishScore = 88

var studentNames: [String] = []
var attendancePercentage: [Int] = [60, 45, 58, 86, 96]

//Question No. 2
func calculateScores(math: Int, science: Int, english: Int) ->(Int,Int) {
    let sum = math+science+english
    let average = sum/3;
    return (sum,average)
}

var result = calculateScores(math: mathScore, science: scienceScore, english: englishScore)
print (result)
//Doubt: How to print two values separately


//Question No. 3
func addStudent(studentName: String) {
    if(currentNumberOfStudents < maxStudents) {
        studentNames.append(studentName)
        currentNumberOfStudents += 1
    }
}
addStudent(studentName: "Jarry")
addStudent(studentName: "Jack")
addStudent(studentName: "Allwin")
addStudent(studentName: "Karla")
addStudent(studentName: "Devid")


//Question No. 4
print("Names In Correct Order Way 1")
for name in studentNames {
    print(name);
}

print("Names In Correct Order Way 2")
for name in 0...studentNames.count-1 {
    print(studentNames[name])
}

print("Names In Correct Order Way 3")
for name in 0..<studentNames.count {
    print(studentNames[name])
}

//Reversed order
print("Names In Reversed Order")
for name in studentNames.reversed() {
    print(name)
}

//Reversed order
print("Another way to print Names In Reversed Order")
studentNames.reverse()
for names in studentNames {
    print(names)
}


//Question No. 5
if(currentNumberOfStudents < maxStudents) {
    print("More Students can be added")
} else {
    print("Class is full")
}

//Question No. 6
for index in 0...currentNumberOfStudents-1 {
    if(attendancePercentage[index] >= 90) {
        print("Student \(studentNames[index]) is Excellent")
    } else if(attendancePercentage[index] >= 75) {
        print("Student \(studentNames[index]) is Good")
    } else if(attendancePercentage[index] >= 50) {
        print("Student \(studentNames[index]) is Average")
    } else if(attendancePercentage[index] < 50) {
        print("Student \(studentNames[index]) is Poor")
    }
}

//Question No. 7
while currentNumberOfStudents < maxStudents {
    currentNumberOfStudents += 1
    print("Current number of students after Adding: \(currentNumberOfStudents)")
}

//Question No. 8
repeat {
    currentNumberOfStudents -= 1
    print("Current number of students after removing: \(currentNumberOfStudents)")
} while currentNumberOfStudents > 5


//Question No. 9
checkStudentName("Rohit")
checkStudentName("")
func checkStudentName(_ name: String) {
    guard !name.isEmpty else {
        print("Guard Statement - Student name is empty")
        return
    }
    print("Guard Statement - Student name is \(name)")
}


// Question No. 10
var mNames: [String?] = ["Chauhan", nil, "Singh"]
for mName in mNames {
    guard let name = mName else {
        print("Guard Let Statement - Found a nil value.")
        continue
    }
    print("Guard Let Statement - Middle name is: \(name)")
}

// Another Way for guard Let
printMiddleName("Chauhan")
printMiddleName(nil)
func printMiddleName(_ middleName: String?) {
    guard let name = middleName else {
        print("Guard Let Statement Another Way - No middle name provided")
        return
    }
    print("Guard Let Statement Another Way - Middle name is \(name)")
}


// Question No. 11

calculateGrade(45)
calculateGrade(87)

enum Grades: String {
    case GradeA
    case GradeB
    case GradeC
    case GradeD
    case Fail
}

func calculateGrade(_ averageScore: Int) {
    
    print("Student Grade is: \(averageScore)")

    switch averageScore {
    case 90...100:
        print ("GradeA")
    case 80..<90:
        print("Grade B")
    case 70..<80:
        print("Grade C")
    case 60..<70:
        print("Grade D")
    default:
        print("Fail")
    }
}

// Question No. 12
let congratulate = {(_ name: String, _ grade: String) -> Void in
    if (grade == "A") {
        print("Congratulations \(name), you got an A!")
    }
}
congratulate("Jack", "A")
congratulate("Ron", "B")


//Question No. 13
var studentGrades: [Int] = [95, 82, 75, 66, 58]

enum Grade: String {
    case GradeA = "A"
    case GradeB = "B"
    case GradeC = "C"
    case GradeD = "D"
    case GradeF = "F"
}

func calculateGrades(_ averageScore: Int) -> Grade{
    
    print("Student Grade is: \(averageScore)")

    switch averageScore {
    case 90...100:
        return .GradeA
    case 80..<90:
        return .GradeB
    case 70..<80:
        return .GradeC
    case 60..<70:
        return .GradeD
    default:
        return .GradeF
    }
}

for studentGrade in studentGrades {
    let grade = calculateGrades(studentGrade)
    print("The grade is \(grade)")
}


// 14. Optional Types
var studentNickname: String? = "Ally"

if let nickname = studentNickname {
    print("Nickname: \(nickname)")
} else {
    print("No nickname")
}

studentNickname = nil

if let nickname = studentNickname {
    print("Nickname: \(nickname)")
} else {
    print("No nickname")
}

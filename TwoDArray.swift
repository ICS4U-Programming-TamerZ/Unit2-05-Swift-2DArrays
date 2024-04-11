/*
 * Author: Tamer Zreg
 * Version: 1.0
 * Since: April 11, 2024
 * Description: This Swift script reads student and assignment data from files, generates random marks for each student,
 * and writes the marks into a CSV file.
 */

import Foundation

// Function to read student data from a file
func readDataFromFile(filename: String) -> [[String]]? {
    do {
        // Read the contents of the file
        let content = try String(contentsOfFile: filename)
        // Split the content into rows
        let rows = content.components(separatedBy: "\n")
        var data = [[String]]()
        // Process each row to extract student data
        for row in rows {
            let fields = row.components(separatedBy: ",")
            data.append(fields)
        }
        // Return the 2D array containing student data
        return data
    } catch {
        // Print error message if reading fails
        print("Error reading student data: \(error)")
        return nil
    }
}

// Function to read assignment names from a file
func readAssignmentsFromFile(filename: String) -> [String]? {
    do {
        // Read the contents of the file
        let content = try String(contentsOfFile: filename)
        // Split the content by comma to get individual assignments
        let assignments = content.components(separatedBy: ",")
        // Return the array containing assignments
        return assignments
    } catch {
        // Print error message if reading fails
        print("Error reading assignments: \(error)")
        return nil
    }
}

// Function to generate random marks for students and assignments
func generateMarks(students: [[String]], assignments: [String]) -> [[String]] {
    var marks = [[String]]()
    
    // Add header row with assignment names
    marks.append(["Student"] + assignments)
    
    // Generate marks for each student
    for student in students {
        var studentMarks = [String]()
        // Add student name as the first column
        studentMarks.append(student[0])
        // Generate a random mark for each assignment
        for _ in 0..<assignments.count {
            let mark = Int.random(in: 65...85) // Generating random marks between 65 and 85
            studentMarks.append("\(mark)")
        }
        // Add student marks to the marks array
        marks.append(studentMarks)
    }
    return marks
}

// Function to write data to a CSV file
func writeToCSV(data: [[String]], filename: String) {
    // Convert the data array into CSV format
    let content = data.map { row in row.joined(separator: ",") }.joined(separator: "\n")
    do {
        // Write the CSV content to the file
        try content.write(toFile: filename, atomically: true, encoding: .utf8)
        // Print success message
        print("CSV file has been created successfully.")
    } catch {
        // Print error message if writing fails
        print("Error writing to CSV file: \(error)")
    }
}

// Main program
let studentsFile = "students.txt"
let assignmentsFile = "assignments.txt"

// Read student and assignment data from files
if let studentArray = readDataFromFile(filename: studentsFile),
   let assignmentsArray = readAssignmentsFromFile(filename: assignmentsFile) {
    // Generate marks for students
    let marks = generateMarks(students: studentArray, assignments: assignmentsArray)
    // Write marks to a CSV file
    writeToCSV(data: marks, filename: "marks.csv")
} else {
    print("Failed to read student or assignments data.")
}

//
//  QuizQuestion.swift
//  Quiz
//
//  Created by test on 01/05/25.
//


struct QuizQuestion: Codable {
    let CREATORID: String
    let MODIFIEDTIME: String
    let CREATEDTIME: String
    let ROWID: String
    
    let Question: String
    let Answer: String
    
    let Option_1: String
    let Option_2: String
    let Option_3: String
    let Option_4: String

}

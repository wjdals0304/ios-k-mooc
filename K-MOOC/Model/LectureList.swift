//
//  LectureList.swift
//  K-MOOC
//
//  Created by 김정민 on 2022/04/10.
//

import Foundation

struct LectureListResponseModel: Codable {
    let pagination : Pagination
    let results : [LectureResponseModel]
}

struct Pagination: Codable {
    let count: Int
    let previous: String?
    let numPages: Int
    let next: String
    
    enum CodingKeys: String, CodingKey {
        case count
        case previous
        case numPages = "num_pages"
        case next
    }
}


struct LectureList: Codable {
    
    let count: Int
    let numPages: Int
    let previous: String
    let next: String
    var lectures: [Lecture]

    init(count: Int,
         numPages: Int,
         previous: String,
         next: String,
         lectures: [Lecture]) {
        self.count = count
        self.numPages = numPages
        self.previous = previous
        self.next = next
        self.lectures = lectures
    }
}

extension LectureList {
    static let EMPTY = LectureList(count: 0, numPages: 0, previous: "", next: "", lectures: [])
}

//
//  LectureUrlEndPoint.swift
//  K-MOOC
//
//  Created by 김정민 on 2022/04/10.
//

import Foundation

enum LectureUrlEndPoint {
    case courseList(serviceKey: String, mobile: String)
    case courseDetail(serviceKey: String, courseId: String)
}

extension LectureUrlEndPoint {
    var url: String {
        switch self {
        case .courseList(serviceKey: let serviceKey, mobile: let mobile) :
            return .makeEndpoint("/courseList?serviceKey=\(serviceKey)&Mobile=\(mobile)")
        case .courseDetail(serviceKey: let serviceKey, courseId: let courseId):
            return .makeEndpoint("/courseDetail?servicekey=\(serviceKey)&CourseId=\(courseId)")
        }
    }
}

extension String {
    static let baseURL = "http://apis.data.go.kr/B552881/kmooc"
    static func makeEndpoint(_ endpoint: String) -> String {
        return String(baseURL + endpoint)
    }
}

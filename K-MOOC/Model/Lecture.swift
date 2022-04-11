//
//  Lecture.swift
//  K-MOOC
//
//  Created by 김정민 on 2022/04/10.
//

import Foundation


// MARK: - Result
struct LectureResponseModel: Codable {
    let blocksURL: String
    let effort: String
    let end, enrollmentStart, enrollmentEnd: Date
    let id: String
    let media: Media
    let name, number: String
    let org: String
    let shortDescription: String
    let start: Date
    let startDisplay: String
    let startType: String
    let pacing: String
    let mobileAvailable, hidden, invitationOnly: Bool
    let teachers, classfy, middleClassfy: String
    let classfyPlus: String
    let coursePeriod: String
    let level, passingGrade: String
    let auditYn, fourthIndustryYn, homeCourseYn: String
    let homeCourseStep: String
    let ribbonYn, jobEduYn: String
    let linguistics: String
    let created, modified: Date
    let aiSECYn, basicScienceSECYn: String
    let orgName: String
    let classfyName: String
    let middleClassfyName: String?
    let languageName: String
    let effortTime, videoTime, week, learningTime: String
    let previewVideo: String
    let courseID: String

    enum CodingKeys: String, CodingKey {
        case blocksURL = "blocks_url"
        case effort, end
        case enrollmentStart = "enrollment_start"
        case enrollmentEnd = "enrollment_end"
        case id, media, name, number, org
        case shortDescription = "short_description"
        case start
        case startDisplay = "start_display"
        case startType = "start_type"
        case pacing
        case mobileAvailable = "mobile_available"
        case hidden
        case invitationOnly = "invitation_only"
        case teachers, classfy
        case middleClassfy = "middle_classfy"
        case classfyPlus = "classfy_plus"
        case coursePeriod = "course_period"
        case level
        case passingGrade = "passing_grade"
        case auditYn = "audit_yn"
        case fourthIndustryYn = "fourth_industry_yn"
        case homeCourseYn = "home_course_yn"
        case homeCourseStep = "home_course_step"
        case ribbonYn = "ribbon_yn"
        case jobEduYn = "job_edu_yn"
        case linguistics, created, modified
        case aiSECYn = "ai_sec_yn"
        case basicScienceSECYn = "basic_science_sec_yn"
        case orgName = "org_name"
        case classfyName = "classfy_name"
        case middleClassfyName = "middle_classfy_name"
        case languageName = "language_name"
        case effortTime = "effort_time"
        case videoTime = "video_time"
        case week
        case learningTime = "learning_time"
        case previewVideo = "preview_video"
        case courseID = "course_id"
    }
}


// MARK: - Media
struct Media: Codable {
    let courseImage, courseVideo: Course
    let image: Image

    enum CodingKeys: String, CodingKey {
        case courseImage = "course_image"
        case courseVideo = "course_video"
        case image
    }
}

// MARK: - Course
struct Course: Codable {
    let uri: String?
}

// MARK: - Image
struct Image: Codable {
    let raw, small, large: String
}


struct Lecture: Codable {
    let id: String                 // 아이디
    let number: String             // 강좌번호
    let name: String               // 강좌명
    let classfyName: String        // 강좌분류
    let middleClassfyName: String  // 강좌분류2
    let courseImage: String        // 강좌 썸네일 (media>image>small)
    let courseImageLarge: String   // 강좌 이미지 (media>image>large)
    let shortDescription: String   // 짧은 설명
    let orgName: String            // 운영기관
    let start: Date                // 운영기간 시작
    let end: Date                  // 운영기간 종료
    let teachers: String?          // 교수진
    let overview: String?          // 상제정보(html)

    init(id: String,
         number: String,
         name: String,
         classfyName: String,
         middleClassfyName: String,
         courseImage: String,
         courseImageLarge: String,
         shortDescription: String,
         orgName: String,
         start: Date,
         end: Date,
         teachers: String?,
         overview: String?) {
        self.id = id
        self.number = number
        self.name = name
        self.classfyName = classfyName
        self.middleClassfyName = middleClassfyName
        self.courseImage = courseImage
        self.courseImageLarge = courseImageLarge
        self.shortDescription = shortDescription
        self.orgName = orgName
        self.start = start
        self.end = end
        self.teachers = teachers
        self.overview = overview
    }
}

extension Lecture {
    static let EMPTY = Lecture(id: "", number: "", name: "", classfyName: "", middleClassfyName: "", courseImage: "", courseImageLarge: "", shortDescription: "", orgName: "", start: Date(), end: Date(), teachers: nil, overview: nil)
}

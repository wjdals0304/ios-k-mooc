//
//  LectureNetwork.swift
//  K-MOOC
//
//  Created by 김정민 on 2022/04/10.
//

import UIKit
import Alamofire

final class LectureNetwork {

    private let serviceKey = "LwG%2BoHC0C5JRfLyvNtKkR94KYuT2QYNXOT5ONKk65iVxzMXLHF7SMWcuDqKMnT%2BfSMP61nqqh6Nj7cloXRQXLA%3D%3D"

    private func parseLectureList(data: LectureListResponseModel) -> LectureList {
        let lectures = data.results.map { res in
            Lecture(id: res.id, number: res.number, name: res.name, classfyName: res.classfyName, middleClassfyName: res.middleClassfyName ?? "", courseImage: res.media.courseImage.uri ?? "", courseImageLarge: res.media.image.large, shortDescription: res.shortDescription, orgName: res.orgName, start: res.start, end: res.end, teachers: res.teachers, overview: "")
        }

        let lectureList = LectureList(count: data.pagination.count, numPages: data.pagination.numPages, previous: data.pagination.previous ?? "", next: data.pagination.next, lectures: lectures)

        return lectureList
    }
    
    private func parseLecture(res: LectureResponseModel) -> Lecture {
        print(res)
        return  Lecture(id: res.id, number: res.number, name: res.name, classfyName: res.classfyName, middleClassfyName: res.middleClassfyName ?? "", courseImage: res.media.courseImage.uri ?? "", courseImageLarge: res.media.image.large, shortDescription: res.shortDescription, orgName: res.orgName, start: res.start, end: res.end, teachers: res.teachers, overview: res.overview)
        
    }

    func getLectureList(completion: @escaping(Result<LectureList, APIError>) -> Void) {

        let url = LectureUrlEndPoint.courseList(serviceKey: serviceKey, mobile: String(1)).url

        let dataRequest = AF.request(url, method: .get)

        dataRequest.responseData { response in

            switch response.result {

            case .success:

                guard let statusCode = response.response?.statusCode else {
                    completion(.failure(.failed))
                    return
                }

                guard let value = response.value else {
                    completion(.failure(.noData))
                    return
                }

                switch statusCode {

                case 200 :
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    guard let data = try? decoder.decode(LectureListResponseModel.self, from: value )
                    else {
                        completion(.failure(.invalidData))
                        return
                    }

                    let lectureList = self.parseLectureList(data: data)

                    completion(.success(lectureList))
                case 403 :
                    completion(.failure(.forbidden))
                case 500 :
                    completion(.failure(.serverError))
                default :
                    completion(.failure(.failed))
                }

            case .failure:
                completion(.failure(.failed))
            }
        }
    }

    func nextLectureList(currentPage: LectureList, completion: @escaping(Result<LectureList, APIError>) -> Void) {
        let nextPageUrl = currentPage.next

        let dataRequest = AF.request(nextPageUrl, method: .get)

        dataRequest.responseData { response in

            switch response.result {

            case .success:

                guard let statusCode = response.response?.statusCode else {
                    completion(.failure(.failed))
                    return
                }

                guard let value = response.value else {
                    completion(.failure(.noData))
                    return
                }

                switch statusCode {

                case 200 :
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    guard let data = try? decoder.decode(LectureListResponseModel.self, from: value )
                    else {
                        completion(.failure(.invalidData))
                        return
                    }

                    let lectureList = self.parseLectureList(data: data)

                    completion(.success(lectureList))
                case 403 :
                    completion(.failure(.forbidden))
                case 500 :
                    completion(.failure(.serverError))
                default :
                    completion(.failure(.failed))
                }

            case .failure:
                completion(.failure(.failed))
            }
        }
    }
    
    
    func detailLecture(courseId:String,completion: @escaping(Result<Lecture, APIError>) -> Void ) {
        
        let url = LectureUrlEndPoint.courseDetail(serviceKey: serviceKey, courseId: courseId).url
        
        let dataRequest = AF.request(url, method: .get)

        dataRequest.responseData { response in

            switch response.result {

            case .success:

                guard let statusCode = response.response?.statusCode else {
                    completion(.failure(.failed))
                    return
                }

                guard let value = response.value else {
                    completion(.failure(.noData))
                    return
                }

                switch statusCode {

                case 200 :
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601

                    guard let data = try? decoder.decode(LectureResponseModel.self, from: value )
                    else {
                        completion(.failure(.invalidData))
                        return
                    }

                    let lectureList = self.parseLecture(res: data)

                    completion(.success(lectureList))
                case 403 :
                    completion(.failure(.forbidden))
                case 500 :
                    completion(.failure(.serverError))
                default :
                    completion(.failure(.failed))
                }

            case .failure:
                completion(.failure(.failed))
            }
        }
        
    }

}

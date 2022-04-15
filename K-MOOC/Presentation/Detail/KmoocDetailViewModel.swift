//
//  KmoocDetailViewModel.swift
//  K-MOOC
//
//  Created by 김정민 on 2022/04/14.
//

import UIKit

final class KmoocDetailViewModel {

    private let lectureNetwork = LectureNetwork()
    
    private var lecture = Lecture.EMPTY
    
    var lectureId: String = ""
    
    var loadingStarted:() -> Void = {}
    var loadingEnded:() -> Void = {}
    var lectureUpdated: (Lecture) -> Void = { _ in }
    
    func detail(completion: @escaping(String?) -> Void) {
        loadingStarted()
        lectureNetwork.detailLecture(courseId: lectureId) { [weak self] response in
            
            switch response {
                
            case .success(let lecture):
                self?.lecture = lecture
                self?.lectureUpdated(lecture)
                self?.loadingEnded()
                
                completion(nil)
                
            case .failure(let error):
                
                switch error {
                    
                case .forbidden :
                    completion(APIError.forbidden.description)
                    
                case .serverError :
                    completion(APIError.serverError.description)
                    
                case .failed :
                    completion(APIError.serverError.description)
                    
                default :
                    completion(APIError.failed.description)

            }
        }
      }
    }
    
}

//
//  KmoocListViewModel.swift
//  K-MOOC
//
//  Created by 김정민 on 2022/04/10.
//

import Foundation

final class KmoocListViewModel {
    
    private let lectureNetwork = LectureNetwork()
    private var lectureList: LectureList = LectureList.EMPTY
        
    func lecturesCount() -> Int {
        return lectureList.lectures.count 
    }
    
    func list( completion: @escaping(String?) -> Void) {
        lectureNetwork.getLectureList { response in
            switch response {
                
            case .success(let lectureList) :
                self.lectureList = lectureList
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

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
    
    func getLectureList(completion: @escaping(Result<LectureList,APIError>) -> Void) {
        
        
        let url = LectureUrlEndPoint.courseList(serviceKey: serviceKey, mobile: String(1))
        
        let dataRequest = AF.request(url as! URLConvertible,method: .get)
        
        dataRequest.responseDecodable(of:LectureList.self) { response in
            
            switch response.result {
                
            case .success(let result):
                
                guard let statusCode = response.response?.statusCode else {
                    completion(.failure(.failed))
                    return
                }
                
                switch statusCode {
                    
                case 200 :
                    completion(.success(result))
                case 403 :
                    completion(.failure(.forbidden))
                case 500 :
                    completion(.failure(.serverError))
                default :
                    completion(.failure(.failed))
                    
                }
            
            case .failure :
                completion(.failure(.failed))

            }
        }
        
        
    }
     
    
    
    
    
}

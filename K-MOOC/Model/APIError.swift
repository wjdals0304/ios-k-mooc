//
//  APIError.swift
//  K-MOOC
//
//  Created by 김정민 on 2022/04/10.
//

import Foundation

enum APIError: Error {

    case failed
    case noData
    case forbidden
    case serverError
    case invalidData

    var description: String {
        switch self {
        case .failed, .noData, .forbidden, .serverError, .invalidData:
            return "에러가 발생했습니다. 다시 시도해주세요."
        }
    }

}

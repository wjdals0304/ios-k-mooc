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
    private var loading = false

    var lectureListUpdate: () -> Void = {}
    var loadingStarted: () -> Void = {}
    var loadingEnded: () -> Void = {}

    func lecturesCount() -> Int {
        return lectureList.lectures.count
    }

    func lecture(at index: Int) -> Lecture {
        return lectureList.lectures[index]
    }

    func list( completion: @escaping(String?) -> Void) {

        loading = true
        loadingStarted()

        lectureNetwork.getLectureList { [weak self] response in
            switch response {

            case .success(let lectureList) :
                self?.lectureList = lectureList
                self?.lectureListUpdate()
                self?.loadingEnded()
                self?.loading = false

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

    func next(completion: @escaping(String?) -> Void) {
        if loading { return }
        loading = true
        loadingStarted()

        lectureNetwork.nextLectureList(currentPage: lectureList) { [weak self] response in
            switch response {

            case .success(let resLectureList):

                var lectureList = resLectureList
                guard let lectures = self?.lectureList.lectures else {
                    return
                }

                lectureList.lectures.insert(contentsOf: lectures, at: 0)
                self?.lectureList = lectureList
                self?.lectureListUpdate()
                self?.loadingEnded()
                self?.loading = false

            case .failure(let error) :

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

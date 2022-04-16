//
//  KmoocDetailViewController.swift
//  K-MOOC
//
//  Created by 김정민 on 2022/04/14.
//

import UIKit
import WebKit

final class KmoocDetailViewController: UIViewController {
    
    var detailViewModel = KmoocDetailViewModel()

    private let detailView = KmoocDetailView()

    private let loading = UIActivityIndicatorView()

    override func loadView() {
        super.loadView()
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        
        detailView.webView.navigationDelegate = self
        detailView.webView.scrollView.isScrollEnabled = false
        
        detailViewModel.loadingStarted = { [ weak self] in
            self?.loading.isHidden = false
            self?.loading.startAnimating()
        }
        
        detailViewModel.loadingEnded = { [weak self] in
            self?.loading.stopAnimating()
        }
        
        detailViewModel.lectureUpdated = { [weak self] lecture in
            self?.title = lecture.name
            
            self?.detailView.lectureEmptyNumberLabel.text = lecture.number
            
            self?.detailView.lectureEmptyTypeLabel.text = "\(lecture.classfyName) (\(lecture.middleClassfyName))"
            
            self?.detailView.lectureEmptyOrgLabel.text = lecture.orgName
            
            self?.detailView.lectureTeacherEmptyLabel.text = lecture.teachers
            
            self?.detailView.lectureDueEmptyLabel.text = DateUtil.dueString(start: lecture.start, end: lecture.end)
            
            self?.detailView.webView.loadHTMLString(self?.makeHtml(lecture.overview) ?? "", baseURL: nil)
        }
        
        detailViewModel.detail { [weak self] message in
            guard let message = message else {
                return
            }
            self?.view.makeToast(message)
        }
        
    }
    
    func setupRefreshControl() {

        view.addSubview(loading)
        
        loading.tintColor = .red
        loading.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }

        detailViewModel.loadingStarted = { [weak loading] in
            loading?.isHidden = false
            loading?.startAnimating()
        }

        detailViewModel.loadingEnded = { [weak loading] in
            loading?.stopAnimating()
        }
    }
}

extension KmoocDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { [weak self] result, _ in
            if let height = result as? CGFloat {
                webView.heightAnchor.constraint(equalToConstant: height).isActive = true
                self?.view.layoutIfNeeded()
            }
        })
    }
}

private extension KmoocDetailViewController {
    
    func makeHtml(_ string: String?) -> String {
        return """
            <!doctype html>
            <html>
            <head>
                <meta charset="utf-8" />
                <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1" />
            </head>
            <body>
            \(string ?? "")
            </body>
            </html>
            """
       }
}
    

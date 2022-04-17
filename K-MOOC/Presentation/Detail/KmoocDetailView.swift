//
//  KmoocDetailView.swift
//  K-MOOC
//
//  Created by 김정민 on 2022/04/14.
//

import UIKit
import SnapKit
import WebKit

final class KmoocDetailView: UIView {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    
    let lectureImage = UIImageView()
    
    private let numberEmptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let typeEmptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let orgEmptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let teacherEmptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let dueEmptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let lectureNumberStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private let lectureNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "• 강좌번호 :"
        return label
    }()
    
    let lectureEmptyNumberLabel = UILabel()
    
    private let lectureTypeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private let lectureTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "• 강좌분류 :"
        return label
    }()
    
    let lectureEmptyTypeLabel = UILabel()

    private let lectureOrgStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private let lectureOrgLabel: UILabel = {
        let label = UILabel()
        label.text = "• 운영기관 :"
        return label
    }()
    
    let lectureEmptyOrgLabel = UILabel()
    
    private let lectureTeacherStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private let lectureTeacherLabel: UILabel = {
        let label = UILabel()
        label.text = "• 교수정보 :"
        return label
    }()
    
    let lectureTeacherEmptyLabel = UILabel()
    
    private let lectureDueStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private let lectureDueLabel: UILabel = {
        let label = UILabel()
        label.text = "• 운영기간 :"
        return label
    }()
    
    let lectureDueEmptyLabel = UILabel()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let webView = WKWebView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setup()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [
            totalStackView, webView
        ].forEach { contentView.addSubview($0) }
        
        [
          lectureImage,
          lectureNumberStackView,
          lectureTypeStackView,
          lectureOrgStackView,
          lectureTeacherStackView,
          lectureDueStackView,
          lineView
        ].forEach { totalStackView.addArrangedSubview($0) }
        
        [
            numberEmptyView,
            lectureNumberLabel,
            lectureEmptyNumberLabel
        ].forEach { lectureNumberStackView.addArrangedSubview($0) }
        
        [
            typeEmptyView,
            lectureTypeLabel,
            lectureEmptyTypeLabel
        ].forEach { lectureTypeStackView.addArrangedSubview($0) }
        
        [
            orgEmptyView,
            lectureOrgLabel,
            lectureEmptyOrgLabel
        ].forEach { lectureOrgStackView.addArrangedSubview($0) }
        
        [
            teacherEmptyView,
            lectureTeacherLabel,
            lectureTeacherEmptyLabel
        ].forEach { lectureTeacherStackView.addArrangedSubview($0) }
        
        [
            dueEmptyView,
            lectureDueLabel,
            lectureDueEmptyLabel
        ].forEach { lectureDueStackView.addArrangedSubview($0) }
        
    }
    
    func setupConstraint() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.height.equalTo(self.snp.height).priority(.low)
            make.width.equalTo(scrollView.snp.width)
        }
        
        totalStackView.snp.makeConstraints { make in
            make.trailing.leading.top.equalToSuperview()
            make.bottom.equalTo(webView.snp.top)
            
        }
        
        lectureImage.setContentHuggingPriority(.required, for: .vertical)
        lectureImage.setContentHuggingPriority(.required, for: .horizontal)
        lectureImage.snp.makeConstraints { make in
            make.height.equalTo(230)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        [
          numberEmptyView,
          typeEmptyView,
          orgEmptyView,
          teacherEmptyView,
          dueEmptyView
        ].forEach {
            
            $0.setContentHuggingPriority(.defaultLow, for: .vertical)
            $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
            
            $0.snp.makeConstraints { make in
                make.width.equalTo(16)
            }
        }
        
        [
            lectureNumberLabel,
            lectureTypeLabel,
            lectureOrgLabel,
            lectureTeacherLabel,
            lectureDueLabel
        ].forEach { $0.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(50)
        }}
        
        webView.snp.makeConstraints { make in
            make.trailing.bottom.leading.equalToSuperview()
        }
        
    }

}

//
//  KmoocListItemTableViewCell.swift
//  K-MOOC
//
//  Created by 김정민 on 2022/04/09.
//
import UIKit
import Kingfisher

final class KmoocListItemTableViewCell: UITableViewCell {

    static let cellIdentifier = String(describing: KmoocListItemTableViewCell.self)

    private let horizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.axis = .horizontal
        return stackView
    }()

    private let verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.axis = .vertical
        return stackView
    }()

    private let thumbnail = UIImageView()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    private let orgNameLabel = UILabel()
    private let durationLabel = UILabel()

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
        setupConstraints()
    }

    func setup() {

        [
          horizontalStack
        ].forEach { addSubview($0) }

        [
          thumbnail,
          verticalStack
        ].forEach {  horizontalStack.addArrangedSubview($0) }

        [
         nameLabel,
         orgNameLabel,
         durationLabel
        ].forEach { verticalStack.addArrangedSubview($0) }

    }

    func setupConstraints() {

        horizontalStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        thumbnail.setContentHuggingPriority(.init(rawValue: 1000), for: .vertical)
        thumbnail.setContentHuggingPriority(.init(rawValue: 1000), for: .horizontal)
        thumbnail.snp.makeConstraints { make in

            make.height.equalTo(self.contentView.snp.height)
            make.width.equalTo(thumbnail.snp.height).multipliedBy(16/9)
        }

        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }

    func setLecture(_ lecture: Lecture) {

        self.nameLabel.text = lecture.name
        self.orgNameLabel.text = lecture.orgName
        self.durationLabel.text = DateUtil.dueString(start: lecture.start, end: lecture.end)

        let url = URL(string: lecture.courseImageLarge)
        self.thumbnail.kf.setImage(with: url)
    }

}

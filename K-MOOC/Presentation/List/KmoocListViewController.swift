//
//  ViewController.swift
//  K-MOOC
//
//  Created by 김정민 on 2022/04/09.
//

import UIKit
import SnapKit
import Toast

final class KmoocListViewController: UIViewController {
    
    private var kmoocListViewModel = KmoocListViewModel()

    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(KmoocListItemTableViewCell.self, forCellReuseIdentifier: KmoocListItemTableViewCell.cellIdentifier)
     
       return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupConstraints()

        setupRefreshControl()
        
        kmoocListViewModel.lectureListUpdate = { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
        }
        
        kmoocListViewModel.list { [weak self] message in
            guard let message = message else {
                return
            }
            self?.view.makeToast(message)
        }
       
    }
    
    func setup() {
        title = "K-MOOC"
        view.backgroundColor = .systemBackground
        
        [
            tableView
        ].forEach {
            view.addSubview($0)
        }

    }
    
    func setupConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupRefreshControl() {
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        
        let activity = UIActivityIndicatorView()
        view.addSubview(activity)
        activity.tintColor = .red
        activity.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        kmoocListViewModel.loadingStarted = { [weak activity] in
            activity?.isHidden = false
            activity?.startAnimating()
        }
        
        kmoocListViewModel.loadingEnded = { [weak activity] in
            activity?.stopAnimating()
        }
    
        
        
    }
    
    @objc func onRefresh() {
        kmoocListViewModel.list { [weak self] message in
            guard let message = message else {
                return
            }
            self?.view.makeToast(message)
        }
    }

    
}

extension KmoocListViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kmoocListViewModel.lecturesCount()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KmoocListItemTableViewCell.cellIdentifier, for: indexPath) as? KmoocListItemTableViewCell else {
            return UITableViewCell()
        }

        let lecture = kmoocListViewModel.lecture(at: indexPath.row)
        cell.setLecture(lecture)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let lecture = kmoocListViewModel.lecture(at: indexPath.row)
//
//    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    

}




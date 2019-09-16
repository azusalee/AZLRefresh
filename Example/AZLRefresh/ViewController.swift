//
//  ViewController.swift
//  AZLRefresh
//
//  Created by azusalee on 11/14/2018.
//  Copyright (c) 2018 azusalee. All rights reserved.
//

import UIKit
import AZLRefresh

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dataArray: [String] = []

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "刷新Demo"

        //self.tabelView.contentInset = UIEdgeInsets.init(top: 50, left: 0, bottom: 50, right: 0)

        self.tableView.azl_addHeaderRefresh(refreshHeader:
            AZLNormalRefreshHeader.createHeader(refresh: { [weak self] () in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1), execute: {
                self?.loadNewData()
                self?.tableView.azl_refreshHeader()?.endRefresh()
                self?.tableView.azl_refreshfooter()?.setRefreshStatus(state: .normal)
            })
        }))

        let footer = AZLNormalRefreshFooter.createFooter(refresh: {[weak self] () in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1), execute: {
                self?.loadMoreData()
                self?.tableView.azl_refreshfooter()?.endRefresh()
                self?.tableView.azl_refreshfooter()?.setRefreshStatus(state: .noMoreData)
            })
        })
        footer.isAutoRefresh = true
        self.tableView.azl_addFooterRefresh(footerRefresh: footer)

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "normalCell")

        self.tableView.azl_refreshHeader()?.beginRefresh()
    }

    func loadNewData() {
        self.dataArray.removeAll()
        for _ in 0...19 {
            let ram = arc4random()
            let text = String(ram)
            self.dataArray.append(text)
        }
        self.tableView.reloadData()
    }

    func loadMoreData() {
        for _ in 0...19 {
            let ram = arc4random()
            let text = String(ram)
            self.dataArray.append(text)
        }
        self.tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell") {
            cell.textLabel?.text = self.dataArray[indexPath.row]
            return cell
        }

        return UITableViewCell()
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}

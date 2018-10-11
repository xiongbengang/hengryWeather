//
//  BaseTableViewController.swift
//  HengryWeather
//
//  Created by Bengang on 2018/8/22.
//  Copyright © 2018 puerjia. All rights reserved.
//

import UIKit
import SnapKit

open class BaseTableViewController: BaseViewController {

    open var sections: [TableSection]!
    open var tableView: UITableView!
    open var tableViewStyle: UITableView.Style { return .plain }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: view.bounds, style: tableViewStyle)
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.keyboardDismissMode = .onDrag;
        tableView.delegate = self;
        tableView.dataSource = self;
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(view)
        }
        registCells()
    }
    
    open func registCells() {
        regist(cellClass: BaseTableViewCell.self, with: CellItem.self)
    }
    
    private func cellIdentifier(for itemClass: CellItem.Type) -> String {
        let identifier = NSStringFromClass(itemClass).components(separatedBy: ".").last
        return identifier!
    }
    
    final public func regist(cellClass:BaseTableViewCell.Type, with itemClass:CellItem.Type) {
        let cellClassIdentifier = cellIdentifier(for: itemClass)
        let path = Bundle.main.path(forResource: cellClassIdentifier, ofType: "nib")
        if let path = path {
            tableView.register(UINib(nibName: path, bundle: Bundle.main), forCellReuseIdentifier: cellClassIdentifier)
        } else {
            tableView.register(cellClass, forCellReuseIdentifier: cellClassIdentifier)
        }
    }
    
    open func cellItemAt(_ indexPath:IndexPath) -> CellItem {
        let section = sections[indexPath.section]
        return section.items[indexPath.row]
    }
    
    open func tableview(_ tableView: UITableView, didLoadCell: UITableViewCell, for item: CellItem, at indexPath: IndexPath) {
        
    }
}

extension BaseTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        return section.items.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellItem = cellItemAt(indexPath)
        let identifier = cellIdentifier(for: type(of: cellItem))
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        tableview(tableView, didLoadCell: cell, for: cellItem, at: indexPath)
        if let baseCell = cell as? BaseTableViewCell {
            baseCell.bind(data: cellItem)
        }
        return cell
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellItem = cellItemAt(indexPath)
        if let cellHeight = cellItem.cellHeight {
            return cellHeight
        }
        return tableView.rowHeight
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: .zero)
        return headerView
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: .zero)
        return footerView
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].headerHeight;
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sections[section].footerHeight
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

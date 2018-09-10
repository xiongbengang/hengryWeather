//
//  BaseTableViewController.swift
//  HengryWeather
//
//  Created by Bengang on 2018/8/22.
//  Copyright © 2018 puerjia. All rights reserved.
//

import UIKit
import SnapKit

public class BaseTableViewController: UIViewController {

    public var sections: [TableSection]!
    public var tableView: UITableView!
    public var tableViewStyle: UITableViewStyle { return UITableViewStyle.plain }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: view.bounds, style: tableViewStyle)
        tableView.tableFooterView = UIView()
        tableView.delegate = self;
        tableView.dataSource = self;
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(view)
        }
        registCells()
    }
    
    public func registCells() {
        regist(cellClass: BaseTableViewCell.self, with: CellItem.self)
    }
    
    final public func regist(cellClass:BaseTableViewCell.Type, with itemClass:CellItem.Type) {
        let cellClassIdentifier = NSStringFromClass(itemClass)
        let path = Bundle.main.path(forResource: cellClassIdentifier, ofType: "nib")
        if let path = path {
            tableView.register(UINib(nibName: path, bundle: Bundle.main), forCellReuseIdentifier: cellClassIdentifier)
        } else {
            tableView.register(cellClass, forCellReuseIdentifier: cellClassIdentifier)
        }
    }
    
    public func cellItemAt(indexPath:IndexPath) -> CellItem {
        let section = sections[indexPath.section]
        return section.items[indexPath.row]
    }
}

extension BaseTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        return section.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellItem = cellItemAt(indexPath: indexPath)
        let identifier = NSStringFromClass(type(of: cellItem))
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let baseCell = cell as? BaseTableViewCell {
            baseCell.bind(data: cellItem)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellItem = cellItemAt(indexPath: indexPath)
        if let cellHeight = cellItem.cellHeight {
            return cellHeight
        }
        return tableView.rowHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].headerHeight;
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sections[section].footerHeight
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

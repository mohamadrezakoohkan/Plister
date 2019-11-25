//
//  ViewController.swift
//  Plister
//
//  Created by Mohammad reza Koohkan on 8/10/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let information = Plist.init(withNameAtDocumentDirectory: "Information")
    let cellId = "informationCell"

    @available(iOS 9.0, *)
    lazy var header: HeaderView = .init(frame: .zero, target: self.submitted(_:))
    
    var data: [NSDictionary.Element] { return self.information.asCollection() }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellId)
    }
    
    func submitted(_ sender: SubmitButton) {
        guard #available(iOS 9.0, *),
            let key = self.header.form.inputs.first?.text,
            let value = self.header.form.inputs.last?.text else { return }
        
        self.information.set(value, for: key)
        self.tableView.reloadSections([0], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: self.cellId)
        cell.textLabel?.text = self.data[indexPath.row].key as? String
        cell.detailTextLabel?.text = self.data[indexPath.row].value as? String
        return cell
    }
 
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard #available(iOS 9.0, *) else { return nil }
        return self.header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard #available(iOS 9.0, *) else { return 0 }
        return self.header.form.height + self.header.form.padding
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.information.remove(self.data[indexPath.row].key as! String)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

}


//
//  TeamListPicker_Extension.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 3/16/21.
//

import Foundation
import UIKit

extension TeamListPickerController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters!.count
      }
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CheckableTableViewCell
        cell?.textLabel?.text = characters![indexPath.row]
        cell?.backgroundColor = .clear
        cell?.textLabel?.textColor = .white
        cell?.textLabel?.textAlignment = .center
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .light)
        return cell!
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.NewEventControllerDelegate!.tickCount += 1
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.NewEventControllerDelegate!.tickCount -= 1
        print(indexPath.row)
    }
}


class CheckableTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }
}

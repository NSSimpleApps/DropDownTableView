# DropDownTableView

Supporting `Swift 2.*` has been removed.

`>= 0.6` for `Swift 3`.

Place into Podfile:

`pod 'DropDownTableView/Swift' # for swift project`
`pod 'DropDownTableView/ObjC' # for objc project`

Place this preamble `import DropDownTableView` into source file.

Inherit from `DropDownTableViewController` and override methods from `DropDownTableViewDataSource` and `DropDownTableViewDelegate`.

Usage:
```swift
class TableViewController: DropDownTableViewController {
    override func numberOfRows(in tableView: UITableView) -> Int {
        return someValue
    }
    override func tableView(_ tableView: UITableView, numberOfSubrowsInRow row: Int) -> Int {
        return someValue
    }
    override var showSubrowsInRow: Int? {
        return someValue
    }
    override func tableView(_ tableView: UITableView, cellForRow row: Int, indexPath: IndexPath) -> UITableViewCell {
        if row == self.nsk_selectedRow {
            someCell.accessoryView = UIImageView(image: UIImage(named: "up_arrow"))
        } else {
            someCell.accessoryView = UIImageView(image: UIImage(named: "down_arrow"))
        }
        return someCell
    }
    override func tableView(_ tableView: UITableView, cellForSubrow subrow: Int, inRow row: Int, indexPath: IndexPath) -> UITableViewCell {
        return someCell
    }
    override func tableView(_ tableView: UITableView, didSelectRow row: Int) {
        switch (self.nsk_selectedRow, row) {
            case (let sr?, _) where row == sr:
                tableView.cellForRow(at: row)?.accessoryView =  UIImageView(image: UIImage(named: "down_arrow"))
                tableView.deselect(row: row, animated: true)
            break
            case (let sr?, _) where row != sr:
                tableView.cellForRow(at: row)?.accessoryView = UIImageView(image: UIImage(named: "up_arrow"))
                tableView.cellForRow(at: sr)?.accessoryView = UIImageView(image: UIImage(named: "down_arrow"))
            break
            case (nil, _):
                tableView.cellForRow(at: row)?.accessoryView = UIImageView(image: UIImage(named: "up_arrow"))
            break
            default:
            break
        }
        super.tableView(tableView, didSelectRow: row)
    }
}
```

![Alt text](https://github.com/NSSimpleApps/DropDownTableView/blob/master/DropDownTableView.gif)

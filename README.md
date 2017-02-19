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
        return someCell
    }
}
```

![Alt text](https://github.com/NSSimpleApps/DropDownTableView/blob/master/DropDownTableView.gif)

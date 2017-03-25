## 0.7.2 (2017-03-25)

- for swift version: `DropDownIndexPath` is a enum with cases: `Int` or `IndexPath`
- some API changes

## 0.7.1 (2017-03-12)

- fixed small bugs
- removed methods: `tableView(_:, accessoryViewForSelectedRow:) -> UIView?`, and `tableView(_:, accessoryViewForDeselectedRow:) -> UIView?` 

## 0.7 (2017-02-19)

- full update
- added implementation for `Objective C`
- use these methods from `UITableViewDelegate` and `UITableViewDataSource` for section 0. Other sections are ignored
- `tableView(_:heightFor{Header,Footer}InSection:)`
- `tableView(_:estimatedHeightFor{Header,Footer}InSection:)`
- `tableView(_:viewFor{Header,Footer}InSection:)`
- `tableView(_:titleFor{Header,Footer}InSection:)`

## 0.6.4 (2017-01-22)

- fixed crash

## 0.6.3 (2017-01-15)

- added `var showSubrowsInRow: Int?` for secifying row whose subrow will be shown at initial appearance
- removed old versions
- TODO: multi-row support

## 0.6.2 (2016-11-13)

- added methods for animation when deletion and insertion
- TODO: multi-row support

## 0.6.1 (2016-10-01)

- old versions removed
- internal improvements
- API changes :(

## 0.6 (2016-09-18)

- Bump to Swift 3
- some changes

## 0.5.4 (2016-07-26)

- small improvement in `cellForRowAtIndexPath`

## 0.5.3 (2016-07-26)

- fixed crash
- some internal improvements
- added required methods in DropDownTableViewDataSource

## 0.5.2 (2016-05-11)

## 0.5.1 (2016-05-11)

- doc updated
- update some internal functionality

## 0.5 (2016-05-01)

- API changes
- added drop-down category under `UITableView`
- the methods `-[DropDownTableViewController tableView:didEndDisplayingCell:forRow:]` and `-[DropDownTableViewController tableView:didEndDisplayingCell:forSubrow:inRow]` have been implemented
- added delegate methods for `UITableViewRowAction`

## 0.4 (2016-03-13)

- added cell moving

## 0.3 (2016-03-06)

- set deployment target to 8.0
- removed tvOS support
- added cell deletion and cell insertion 
- the methods `-[DropDownTableViewController tableView:didEndDisplayingCell:forRow:]` and `-[DropDownTableViewController tableView:didEndDisplayingCell:forSubrow:inRow]` are not implemented... yet
- bugfixes

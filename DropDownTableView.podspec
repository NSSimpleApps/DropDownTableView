Pod::Spec.new do |s|
    s.name         = "DropDownTableView"
    s.version      = "0.8"
    s.summary      = "This is a simple drop down table view."
    s.description  = "DropDownTableViewController is a simple UITableViewController. Inherit from DropDownTableViewController and override methods from DropDownTableViewDataSource and DropDownTableViewDelegate."
    s.homepage     = "https://github.com/NSSimpleApps/DropDownTableView"
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.author       = { 'NSSimpleApps, Sergey Poluyanov' => 'ns.simple.apps@gmail.com' }
    s.source       = { :git => "https://github.com/NSSimpleApps/DropDownTableView.git", :tag => s.version.to_s }
    s.requires_arc = true
    s.platform                  = :ios, '8.0'
    s.ios.deployment_target     = '8.0'

    s.default_subspec = 'Swift'

    s.subspec 'ObjC' do |objc|
        objc.ios.deployment_target     = '8.0'
        objc.source_files = "Source/ObjC/*.{h,m}"
        objc.public_header_files = "Source/ObjC/DropDownTableView.h", "Source/ObjC/DropDownTableViewController.h", "Source/ObjC/DropDownTableViewDataSource.h", "Source/ObjC/DropDownTableViewDelegate.h", "Source/ObjC/NSIndexPath+DropDown.h", "Source/ObjC/UITableView+DropDown.h"
    end

    s.subspec 'Swift' do |swift|
        swift.ios.deployment_target     = '8.0'
        swift.source_files = "Source/Swift/*.swift"
    end
end

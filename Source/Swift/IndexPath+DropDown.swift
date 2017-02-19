//
//  IndexPath+DropDown.swift
//  DropDownTableView
//
//  Created by NSSimpleApps on 23.04.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

import Foundation


// mainrow0 /\
//    subrow0       -> IndexPath(forSubrow: 0, mainrow: 0)
//    subrow1       -> IndexPath(forSubrow: 1, mainrow: 0)
//    subrow2       -> IndexPath(forSubrow: 2, mainrow: 0)
//    subrow3       -> IndexPath(forSubrow: 3, mainrow: 0)
// mainrow1 \/


public extension IndexPath {
    
    public init(forSubrow subrow: Int, inMainrow mainrow: Int) {
        
        self.init(indexes: [subrow, mainrow])
    }
    
    public var subrow: Int {
        
        return self[0]
    }
    
    public var mainrow: Int {
        
        return self[1]
    }
}

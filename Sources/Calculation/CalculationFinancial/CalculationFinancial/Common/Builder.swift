//
//  Builder.swift
//  CalculationFinancial
//
//  Created by Duong Van Chung on 9/20/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import Foundation

protocol Initializable: class {
    init()
}

class Builder<T: Initializable> {
    
    let object = T()
    
    func outputObject() -> T {
        return object
    }
}

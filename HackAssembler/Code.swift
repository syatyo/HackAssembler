//
//  Code.swift
//  HackAssembler
//
//  Created by 山田良治 on 2019/01/10.
//  Copyright © 2019 山田良治. All rights reserved.
//

import Foundation

struct Code {
    
    static func dest(from mnemonic: String) -> String {
        let d1 = mnemonic.contains("A").binary
        let d2 = mnemonic.contains("D").binary
        let d3 = mnemonic.contains("M").binary
        return "\(d1)\(d2)\(d3)"
    }
    
}

extension Bool {
    
    var binary: Int {
        return self == true ? 1 : 0
    }
    
}

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
    
    // TODO: Is there a any way to implement more efficiently? I don't want to use all pattern matching.
    static func comp(from mnemonic: String) -> String {
        
        // I did not use new line to notice shortage of bit easily.
        switch mnemonic {
        // a bit is 0.
        case "0":   return "0101010"
        case "1":   return "0111111"
        case "-1":  return "0111010"
        case "D":   return "0001100"
        case "A":   return "0110000"
        case "!D":  return "0001101"
        case "!A":  return "0110001"
        case "-D":  return "0001111"
        case "-A":  return "0110011"
        case "D+1": return "0011111"
        case "A+1": return "0110111"
        case "D-1": return "0001110"
        case "A-1": return "0110010"
        case "D+A": return "0000010"
        case "D-A": return "0010011"
        case "A-D": return "0000111"
        case "D&A": return "0000000"
        case "D|A": return "0010101"
            
        // a bit is 1.
        case "M":   return "1110000"
        case "!M":  return "1110001"
        case "-M":  return "1110011"
        case "M+1": return "1110111"
        case "M-1": return "1110010"
        case "D+M": return "1000010"
        case "D-M": return "1010011"
        case "M-D": return "1000111"
        case "D&M": return "1000000"
        case "D|M": return "1010101"
        default: fatalError() // Implementation failure.
        }
    }
    
    static func jump(from mnemonic: String) -> String {
        guard mnemonic != "JNE" else {
            return "101"
        }
        
        guard mnemonic != "JMP" else {
            return "111"
        }
        
        let j1 = mnemonic.contains("L").binary
        let j2 = mnemonic.contains("E").binary
        let j3 = mnemonic.contains("G").binary
        return "\(j1)\(j2)\(j3)"
    }
    
}

extension Bool {
    
    var binary: Int {
        return self == true ? 1 : 0
    }
    
}

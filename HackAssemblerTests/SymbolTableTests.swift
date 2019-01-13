//
//  SymbolTableTests.swift
//  HackAssemblerTests
//
//  Created by 山田良治 on 2019/01/13.
//  Copyright © 2019 山田良治. All rights reserved.
//

import XCTest

class SymbolTableTests: XCTestCase {
    let variableSymbolTable = VariableSymbolTable()
    let labelSymbolTable = LabelSymbolTable()
    
    override func setUp() {
        variableSymbolTable.addEntry(symbol: "testSymbol", address: 80)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testContains() {
        XCTAssertTrue(variableSymbolTable.contains(symbol: "testSymbol"))
    }
    
    func testGetAddress() {
        XCTAssertEqual(variableSymbolTable.getAddress(symbol: "testSymbol"), 80)
    }
    
    func testGetDefinedSymbolAddress() {
        let sp = labelSymbolTable.getAddress(symbol: "SP")
        XCTAssertEqual(sp, 0)
        
        let lcl = labelSymbolTable.getAddress(symbol: "LCL")
        XCTAssertEqual(lcl, 1)
        
        let arg = labelSymbolTable.getAddress(symbol: "ARG")
        XCTAssertEqual(arg, 2)
        
        let this = labelSymbolTable.getAddress(symbol: "THIS")
        XCTAssertEqual(this, 3)
        
        let that = labelSymbolTable.getAddress(symbol: "THAT")
        XCTAssertEqual(that, 4)
        
        for i in 0...15 {
            let registerName = "R\(i)"
            let address = labelSymbolTable.getAddress(symbol: registerName)
            XCTAssertEqual(address, i)
        }
        
        let screen = labelSymbolTable.getAddress(symbol: "SCREEN")
        XCTAssertEqual(screen, 16384)
        
        let kbd = labelSymbolTable.getAddress(symbol: "KBD")
        XCTAssertEqual(kbd, 24576)
    }
    
}

//
//  ValidatorEmail.swift
//  Navigation
//
//  Created by Constantin on 24.05.2022.
//

import Foundation
import UIKit

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

public class ValidatorEmail {
 
    func isValid(input: String) -> Bool {
        guard input != "" else { return false }
 
        var state: Int = 0
        var ch: Character
        var index: Int = 0
        var mark: Int = 0
        var local: String = ""
        var domain: String = ""
 
        while (index <= input.count && state != -1) {
            // Dealing with a char instead of char[] makes life a lot easier!
            if (index == input.count) {
                ch = "\0" // We need to encode the end by using a terminator
            }
            else {
                ch = input[index]
                if (ch == "\0") {
                    // but the terminator may not be part of the input!
                    return false
                }
            }
 
            switch state {
 
                case 0:
                    // Transition on {atext}
                    if ((ch >= "a" && ch <= "z") || (ch >= "A" && ch <= "Z")
                            || (ch >= "0" && ch <= "9") || ch == "_" || ch == "-"
                            || ch == "+") {
                        state = 1
                        break
                    }
                    // Unexpected Character -> Error state
                    state = -1
                    break
                
 
                case 1:
                    // Consume {atext}
                    if ((ch >= "a" && ch <= "z") || (ch >= "A" && ch <= "Z")
                            || (ch >= "0" && ch <= "9") || ch == "_" || ch == "-"
                            || ch == "+") {
                        break
                    }
                    if (ch == ".") {
                        state = 2
                        break
                    }
                    if (ch == "@") { // Endof local part
                        local = "\(input)0\(index - mark)"
                        mark = index + 1
                        state = 3
                        break
                    }
                    // Unexpected Character -> Error state
                    state = -1
                    break
                
 
                case 2:
                    // Transition on {atext}
                    if ((ch >= "a" && ch <= "z") || (ch >= "A" && ch <= "Z")
                            || (ch >= "0" && ch <= "9") || ch == "_" || ch == "-"
                            || ch == "+") {
                        state = 1
                        break
                    }
                    // Unexpected Character -> Error state
                    state = -1
                    break
                
 
                case 3:
                    // Transition on {alnum}
                    if ((ch >= "a" && ch <= "z") || (ch >= "0" && ch <= "9")
                            || (ch >= "A" && ch <= "Z")) {
                        state = 4
                        break
                    }
                    // Unexpected Character -> Error state
                    state = -1
                    break
                
 
                case 4:
                    // Consume {alnum}
                    if ((ch >= "a" && ch <= "z") || (ch >= "0" && ch <= "9")
                            || (ch >= "A" && ch <= "Z")) {
                        break
                    }
                    if (ch == "-") {
                        state = 5
                        break
                    }
                    if (ch == ".") {
                        domain.append("\(input)\(mark)\(index - mark)")
                        mark = index + 1
                        state = 5
                        break
                    }
                    // Match EOL
                    if (ch == "\0") {
                        domain.append("\(input)\(mark)\(index - mark)")
                        state = 6
                        break // EOL -> Finish
                    }
                    // Unexpected Character -> Error state
                    state = -1
                    break
                
 
                case 5:
                    if ((ch >= "a" && ch <= "z") || (ch >= "0" && ch <= "9")
                            || (ch >= "A" && ch <= "Z")) {
                        state = 4
                        break
                    }
                    if (ch == "-") { break }
                    // Unexpected Character -> Error state
                    state = -1
                    break
                
 
                case 6:
                    // Success! (we don't really get here, though)
                    break
                default:
                    state = -1
            }
            index += 1
        }
 
        // Sanity checks
 
        // Input not accepted
        if (state != 6) { return false }
 
        // Require at least a second level domain
        if (domain.count < 2) { return false }
 
        // RFC 5321 limits the length of the local part
        if (local.count > 64) { return false }
 
        // RFC 5321 limits the total length of an address
        if (input.count > 254) { return false }
 
        // TLD must only consist of letters and be at least two characters long.
        index = input.count - 1
        while (index > 0) {
            ch = input[index]
            if (ch == "." && input.count - index > 2) { return true }
            if (!((ch >= "a" && ch <= "z") || (ch >= "A" && ch <= "Z"))) { return false }
            index -= 1
        }
 
        return true
    }
}

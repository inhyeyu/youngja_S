//
//  Encrypt.swift
//  youngjaS
//
//  Created by Shatra on 2017. 3. 31..
//  Copyright © 2017년 BWG. All rights reserved.
//

import CryptoSwift
import UIKit

class Encrypt {
    
    // 로그인 요청 시
    // Util.Encrypt.digest(this.state.email + this.state.password)
    
    // 패스워드 textfield onChange 시
    // let array = Util.Encrypt.passwordSplit(text, this.state.passwordArray)
    // pw = Util.Encrypt.passwordEncrypt(JSON.stringify(array))
    // this.state.password = pw
    // this.state.passwordArray = array
    
    
    // 1. passwordSplit
    func passwordSplit(text:String, array:[Int]) -> [Int] {
        var pwArray = array
        let originLength = array.count
        let displayLength = text.characters.count
        
        if (originLength > displayLength) {
            return Array(pwArray[0...displayLength]) // pwArray.splice(0, displayLength);
        }
        
        let index = displayLength - 1
        let lastWord = text.substring(from: text.index(text.startIndex, offsetBy: index))
        
        
        
        //let character = String(self.characterAtIndex(Char))
        //return Int(String(character.unicodeScalars.first!.value))!
        
        let wordNumber = (lastWord.unicodeScalars.first?.value)! + 1207
        pwArray.append(Int(wordNumber))
        
        return pwArray
    }
    
    // 2. passwordEncrypt
    func passwordEncrypt(text:String) -> String {
        // todo checking nil
        
        var result:String? = nil
        
        do {
            //let tt:String = "eW91bmdqYV9tb2ltX2Zpbg=="
            let tt1:String = "youngja_moim_fin"
            let aes = try AES(key: tt1, iv:tt1, blockMode: .CBC, padding: PKCS7())
            let ciphertext = try aes.encrypt(Array(text.utf8))
            
            result = ciphertext.toBase64()
            
        } catch {
            print(error)
        }
        
        return result!
    }
    
    // 3. jsonStringify
    func jsonStringify(array:[Int]) -> String {
        
        let jsonData = try! JSONSerialization.data(withJSONObject: array, options: .init(rawValue: 0))
        let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
        
        return jsonString!
    }
    
    
    // 4. digest
    func digest(plain:String) -> String {
        return plain.sha256()
    }
   
    
}

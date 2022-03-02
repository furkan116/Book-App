//
//  Extensions.swift
//  Book-App
//
//  Created by Furkan Yıldırım on 2.03.2022.
//

import SwiftUI

//For string character limitations
extension String {
    func onlyNumber(stringLenght: Int) -> String {
        return self.filter {"0123456789".contains($0)}.prefix(stringLenght).uppercased()
    }
    
    func onlyLetter(stringLenght: Int) -> String {
        return self.prefix(stringLenght).filter {"ABCÇDEFGĞHIİJKLMNOÖPQRSŞTUÜVWXYZabcçdefgğhıijklmnoöprsştuüvyzqxy ".contains($0)}
    }
}

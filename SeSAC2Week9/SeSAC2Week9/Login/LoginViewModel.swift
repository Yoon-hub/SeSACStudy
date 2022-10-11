//
//  LoginViewModel.swift
//  SeSAC2Week9
//
//  Created by 최윤제 on 2022/09/01.
//

import Foundation

class LoginViewModel {
    
    var email: Observable<String> = Observable("")
    var passwd: Observable<String> = Observable("")
    var name: Observable<String> = Observable("")
    var isValid: Observable<Bool> = Observable(false)
    
    func checkValidation() {
        if email.value.count >= 6 && passwd.value.count >= 4 {
            isValid.value = true
        } else {
            isValid.value = false
        }
    }
    
    func signIn(completion: @escaping () -> ()) {
        UserDefaults.standard.set(name.value, forKey: "name")
        completion()
    }
    
}

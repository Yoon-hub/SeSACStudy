//
//  LottoViewModel.swift
//  SeSAC2Week9
//
//  Created by 최윤제 on 2022/09/01.
//

import Foundation

class LottoViewModel {
    
    var number1 = Observable(1)
    var number2 = Observable(2)
    var lottoMoney = Observable("당첨금")
    
    func format(for number: Int) -> String {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        return numberFormat.string(for: number)!
    }
    
    func fetchLottoAPI(drwNo: Int) {
        LottoAPIManager.requestLottot(drwNo: drwNo) { lotto, error in
            
            guard let lotto = lotto else {
                return
            }
            self.number1.value = lotto.drwtNo1
            self.number2.value = lotto.drwtNo2
            self.lottoMoney.value = self.format(for: lotto.totSellamnt)
            
        }
    }
    
}

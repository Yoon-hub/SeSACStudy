import Foundation

struct ExchangeRate{
    var currentRate: Double{ //프로퍼티 옵저버
        willSet{
            print("currency rate willSet - 환율 변동 예정 \(currentRate)에서 \(newValue)로 곧 변경됩니다.")
        }
        didSet{
            print("currency rate didSet - 환율 변동 예정 \(oldValue)에서 \(currentRate)로 변경되었습니다.")
        }
    }
    var USD: Double{
        willSet{
            print("USD willSet - 환전 금액: \(USD) -> \(newValue) 변환 예정")
        }
        didSet{
            print("USD willSet - 환전 금액: \(oldValue) -> \(USD) 변환 예정")
        }
    }
    var KRW: Double{
        get{
            return KRW
        }
        set{
            USD = newValue / currentRate
        }
    }
}


var rate = ExchangeRate(currentRate: 1100, USD: 1)
rate.KRW = 500000
rate.currentRate = 1350
rate.KRW = 500000

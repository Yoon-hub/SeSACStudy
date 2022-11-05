//
//  APIService.swift
//  SeSAC2Week18
//
//  Created by 최윤제 on 2022/11/02.
//

import Foundation

import Alamofire

struct Login: Codable {
    let token: String
}

struct Profile: Codable {
    let user: User
}

struct User: Codable {
    let photo: String
    let email: String
    let username: String
}

enum SeSACError: Int, Error {
    case invalidaAuthorization = 401
    case takenEmail = 406
    case emptyParameters = 501
}

extension SeSACError: LocalizedError { // ????
    var errorDescription: String? {
        switch self {
        case .invalidaAuthorization:
            return "토큰이 만료되었습니다. 다시 로그인 해주세요"
        case .takenEmail:
            return "이미 가입된 회원입니다. 로그인 해주세요."
        case .emptyParameters:
            return "머가 없습니다."
        }
    }
}

final class APIService {

    func signup() {
        let api = SeSACAPI.signup(userName: "testydddoon", email: "1111111@naver.com", password: "12341234")
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { response in
            switch response.result {
            case let .success(value):
                print(value)
            case let .failure(error):
                print(error)
            }
        }
    }

    func login() {
        let api = SeSACAPI.login(email: "kong4170@naver.com", password:  "12341234")

        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: Login.self) { response in
            switch response.result {
            case .success(let data):
                print(data.token)
                UserDefaults.standard.set(data.token, forKey: "token")
            case .failure(_):
                print(response.response?.statusCode)
            }
        }
    }



    func profile() {
        let api = SeSACAPI.profile

        AF.request(api.url, method: .get, headers: api.headers).responseDecodable(of: Profile.self) { response in
            switch response.result {
            case .success(let data):
                print(data)
            case .failure(_):
                print(response.response?.statusCode)
            }
        }
    }

    
    func requestSeSAC<T: Decodable>(type: T.Type = T.self, url: URL, method: HTTPMethod = .get, parameters: [String:String]? = nil, headers: HTTPHeaders, completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(url, method: method, parameters: parameters  ,headers: headers).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                
                guard let statusCode = response.response?.statusCode else { return }
                guard let error = SeSACError(rawValue: statusCode) else { return } // 오 rawvalue로 오류를 찾을 수 있는겨
                
                
                completion(.failure(error))
            }
        }
    }
    
}


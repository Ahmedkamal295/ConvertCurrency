//
//  APIService.swift
//  ConvertCurrency
//
//  Created by Ahmed Kamal on 09/12/2023.
//

import Foundation
import Alamofire

class RetryHandler: RequestInterceptor {
    let maxRetry = 3
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        request.retryCount < maxRetry ?  completion(.retry) : completion(.doNotRetry)
    }
}

// MARK: - postJson
class ApiServices {
    
    //MARK: - variables
    var lang : String = "ar"
    private init() {}
    static let instance = ApiServices()
    
    func FetchData<T: Codable>(method: HTTPMethod,url:String,parameters: Parameters,headers: HTTPHeaders?, completion: @escaping (((Result<T,Error>)?,Int?) -> Void)) {
        
        print(url)

        //MARK: -  headers with login
        var finalHeaders: HTTPHeaders? = headers
        
        //MARK: -  method
        var encoder: ParameterEncoding!
        switch method {
        case .get:
            encoder = URLEncoding.default
        case .post:
            encoder = JSONEncoding.default
        default:
            encoder = JSONEncoding.prettyPrinted
        }
        
        //MARK: - request
    AF.request(url, method: method, parameters: parameters,encoding: encoder, headers: finalHeaders, interceptor: RetryHandler()).responseJSON { response in
        debugPrint("[debug] result in api service \(response) ")

            switch response.result {
                
                // success request
            case .success( _):
                guard let data = response.data else {
                    completion(nil,response.response?.statusCode)
                    return}
                do {
                    let myModel = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(myModel), response.response?.statusCode)
                }catch {
                    print(error)
                    completion(.failure(error), response.response?.statusCode)
                }
                // failure request
            case .failure(let error):
                print(error)
                completion(.failure(error), response.response?.statusCode)
            }
        }
    }
    
}



//
//  AlamofireClient.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 21/08/25.
//

import Foundation
import RxSwift
import Alamofire

class AlamofireClient: HttpClient {
    var session: Session?
    
    init(
        URLSessionConfig configuration: URLSessionConfiguration = URLSessionConfiguration.default,
        timeoutInterval: TimeInterval = 120
    ) {
        configuration.timeoutIntervalForRequest = timeoutInterval
        configuration.timeoutIntervalForResource = timeoutInterval
        self.session = Session(configuration: configuration)
    }
    
    func load(urlString: String, method: String = "GET", params: [String : String]? = nil) -> Observable<Data> {
        return Observable<Data>.create { observer in
            
            var urlComponents = URLComponents(string: urlString)
            
            if let params = params {
                let items = params.map { URLQueryItem(name: $0.key, value: $0.value) }
                let queryExisting = urlComponents?.queryItems ?? []
                urlComponents?.queryItems = queryExisting + items
            }
            
            print("urlString: \(urlString)")
            guard
                let url = urlComponents?.url,
                let urlRequest = try? URLRequest(url: url, method: HTTPMethod(rawValue: method))
            else {
                observer.onError(NSError(
                    domain: NSURLErrorDomain,
                    code: NSURLErrorBadURL,
                    userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]
                ))
                return Disposables.create()
            }
        
            let request = self.session?.request(urlRequest)
                .response { response in
                    switch response.result {
                    case .success(let data):
                        if let data {
                            print("Response: \(urlString)")
                            observer.onNext(data)
                            observer.onCompleted()
                        } else {
                            observer.onError(NSError(
                                domain: NSURLErrorDomain,
                                code: NSURLErrorCannotDecodeContentData,
                                userInfo: [NSLocalizedDescriptionKey: "No data in response"]
                            ))
                        }
                    case .failure(let error):
                        print("Failure: \(urlString)")
                        observer.onError(error)
                    }
                }
            
            return Disposables.create {
                request?.cancel()
            }
        }
    }
    
//    func load(request: URLRequest) -> Observable<Data> {
//        return Observable<Data>.create { observer in
//            self.session?.request(request)
//                .response { response in
//                    switch response.result {
//                    case .success(let data):
//                        if let data {
//                            observer.onNext(data)
//                        } else {
//                            observer.onError(NSError(domain: "unknown", code: 1001))
//                        }
//                    case .failure(let failure):
//                        observer.onError(failure)
//                    }
//                }
//            
//            return Disposables.create()
//        }
//    }
}

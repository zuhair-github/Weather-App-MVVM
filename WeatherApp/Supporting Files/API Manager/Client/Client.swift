//
//  Client.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import RxSwift

protocol Client {
    func fetchData(route: Routes, header: [String: String], parameters: [String: Any]) -> Observable<Data>
}

class APIClient: Client {
    
    var baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func fetchData(route: Routes, header: [String: String], parameters: [String: Any]) -> Observable<Data> {
        
        return Observable.create { observer -> Disposable in
            
            let url = self.url(route: route.rawValue, parameters: parameters)!            
            var request = URLRequest(url: url)
            for (key, value) in header {
                request.setValue(value, forHTTPHeaderField: key)
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data else {
                        return observer.onError(error ?? self.error(description: "Unexpected error"))
                    }
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }
            task.resume()
            return Disposables.create()
        }
           
    }
    
    
}

// MARK: - Utility Methods
extension APIClient {
    
    func url(route: String, parameters: [String: Any] = [:]) -> URL? {
        var queryParameters = ""
        for (key, value) in parameters {
            if queryParameters.isEmpty {
                queryParameters += "?\(key.trimmed)=\(value)".trimmed
            } else {
                queryParameters += "&\(key.trimmed)=\(value)".trimmed
            }
        }
        guard let urlString = (baseUrl + route + queryParameters).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        return URL(string: urlString)
    }
    
    func error(description: String) -> Error {
        let userInfo: [String : Any] = [
            NSLocalizedDescriptionKey :  description,
            NSLocalizedFailureReasonErrorKey : description
        ]
        return NSError(domain: "API Error", code: 400, userInfo: userInfo)
    }
}

//
//  Parser.swift
//  WeatherApp
//
//  Created by Zuhair Hussain on 03/06/2024.
//

import RxSwift

protocol Parser {
    func parse<T: Decodable>(data: Data, toType: T.Type) -> Observable<T>
}

class ObjectParser: Parser {
    
    
    func parse<T>(data: Data, toType: T.Type) -> Observable<T> where T : Decodable {
        
        return Observable.create { observer in
            do {
                let results = try JSONDecoder().decode(T.self, from: data)
                observer.onNext(results)
            } catch {
                if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    observer.onError(self.error(description: errorResponse.message))
                }
                observer.onError(error)
            }
            
            return Disposables.create()
        }
        
    }
    
    func error(description: String) -> Error {
        let userInfo: [String : Any] = [
            NSLocalizedDescriptionKey :  description,
            NSLocalizedFailureReasonErrorKey : description
        ]
        return NSError(domain: "Parsing Error", code: 400, userInfo: userInfo)
    }
    
}

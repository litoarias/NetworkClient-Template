//  ___FILEHEADER___

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

class ___FILEBASENAMEASIDENTIFIER___ {
    
    static func get<K: Codable>(url: URL, parameters: [String: Any]? = [:], completion: @escaping (Result<K>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        var urlComp = URLComponents(url: url, resolvingAgainstBaseURL: false)
        parameters?.forEach({
            urlComp?.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value as? String))
        })
        
        NetworkClient().task(request: request, completion: completion).resume()
    }
    
    
    static func post<K: Codable>(url: URL, parameters: [String: Any], completion: @escaping (Result<K>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        request.httpBody = httpBody
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        NetworkClient().task(request: request, completion: completion).resume()
    }
    
    
    fileprivate func task<K: Codable>(request: URLRequest, completion: @escaping (Result<K>) -> Void) -> URLSessionDataTask {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        return session.dataTask(with: request) { (responseData, response, responseError) in
            if let error = responseError {
                completion(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let objects = try decoder.decode(K.self, from: jsonData)
                    let result: Result<K> = Result.success(objects)
                    completion(result)
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
    
}

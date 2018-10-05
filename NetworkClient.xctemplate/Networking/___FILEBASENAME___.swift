//  ___FILEHEADER___

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

class ___FILEBASENAMEASIDENTIFIER___Client {
    
    static func get<K: Codable>(url: URL, completion: @escaping (Result<K>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
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
        
        task.resume()
    }
    
    
    static func post<K: Codable>(url: URL, parameters: [String: Any], completion: @escaping (Result<K>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let session = URLSession(configuration: URLSessionConfiguration.default)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        request.httpBody = httpBody
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
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
        
        task.resume()
    }
    
}

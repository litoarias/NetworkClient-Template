//  ___FILEHEADER___

import Foundation

struct User: Codable {
    let id: Int
    let name: String?
    let email: String?
}

struct UserResponse: Codable {
    let success: Bool
}

protocol UsersDataSourceType {
    func fetchUsers(completion: @escaping (_ result: Result<[User]>) -> Void)
    func addUser(completion: @escaping (_ result: Result<UserResponse>) -> Void)
}

class UsersDataSource: UsersDataSourceType {
    
    func fetchUsers(completion: @escaping (_ result: Result<[User]>) -> Void) {
        ___VARIABLE_productName:identifier___.get(url: URL(string: "https://jsonplaceholder.typicode.com/users")!) { result in
            completion(result as Result<[User]>)
        }
    }
    
    func addUser(completion: @escaping (_ result: Result<UserResponse>) -> Void) {
        let parameters: [String: String] = ["email" : "lito.developer@gmail.com",
                                            "password" : "a5cbf232ce283b3655944fb9deeb6e54",
                                            "name" : "lito.developer"]
        ___VARIABLE_productName:identifier___.post(url: URL(string: "https://hipolitoarias.com/webapi/user/signup")!, parameters: parameters) { result in
            completion(result as Result<UserResponse>)
        }
    }
}



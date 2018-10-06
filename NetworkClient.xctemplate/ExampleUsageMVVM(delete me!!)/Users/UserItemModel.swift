//  ___FILEHEADER___

import Foundation

struct UserItemModel {

    var name: String
    var email: String

    init(user: User) {
        name = user.name ?? ""
        email = user.email ?? ""
    }
    
}

//  ___FILEHEADER___

import Foundation

protocol ViewModelDelegate: class {
    func willLoadData()
    func didLoadData()
}

protocol ViewModelType {
    func bootstrap()
    var delegate: ViewModelDelegate? { get set }
}

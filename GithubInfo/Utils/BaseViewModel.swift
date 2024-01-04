//
//  BaseViewModel.swift
//  BetBlack
//
//  Created by Nayab Mehar on 04/01/24.
//

import Foundation

enum Status: Equatable {
    case success
    case loading
    case error(String)
    case initial
}

class BaseViewModel: ObservableObject,
                     Equatable,
                        Hashable {
    @Published var status: Status
    static func == (lhs: BaseViewModel, rhs: BaseViewModel) -> Bool {
        String(describing: lhs) == String(describing: rhs)
    }

    init(status: Status = .initial) {
        self.status = status
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: type(of: self)))
    }
  
    func setLoading(){
        DispatchQueue.main.async {
            self.status = .loading
        }
       
    }
    
    
    

    func handleResult<T>(_ result: Result<T, APIError>, onSuccess: @escaping (T) -> Void, onFailure: (() -> Void)? = nil) {
        switch result {
        case let .success(response):
            DispatchQueue.main.async {
                self.status = .success
                onSuccess(response)
            }
        case let .failure(error):
            DispatchQueue.main.async {
                self.status = .error(APIError.commonErrorDescription)

                if case let APIError.serverError(_, response) = error {
                    self.status = .error(response.error)
                }
                onFailure?()
            }
        }
    }

    func isStatusError() -> Bool {
        if case .error = status {
            return true
        }

        return false
    }
    
    func handleError(_ handler: @escaping (String) -> Void){
        if case  .error(let message) = status {
            handler(message)
        }
    }
}


extension BaseViewModel {
    func mockStatus(_ s:Status)  {
         DispatchQueue.main.async {
             self.status = s
         }
    }
}

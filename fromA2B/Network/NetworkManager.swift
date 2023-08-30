//
//  NetworkManager.swift
//  fromA2B
//
//  Created by Johan Thureson on 2023-08-17.
//

import Foundation
import Alamofire

private let API_BASE_URL = "https://api.resrobot.se/v2.1"

actor NetworkManager: GlobalActor {
    
    static let shared = NetworkManager()

    private let sessionManager: Session

    init(sessionManager: Session = AF) {
        self.sessionManager = sessionManager
    }

    private let maxWaitTime = 15.0
    
    /*
    var commonHeaders: HTTPHeaders = [
        "user_id": "123",
        "token": "xxx-xx"
    ]
     */

    func get(path: String, parameters: Parameters?) async throws -> Data {
        var parametersWithAccessId = parameters
        parametersWithAccessId?["accessId"] = "661da78d-bf7c-4b44-8f33-c02ebc44228a"

       // You must resume the continuation exactly once
        return try await withCheckedThrowingContinuation { continuation in
            sessionManager.request(
                API_BASE_URL + path,
                parameters: parametersWithAccessId,
                headers: nil,
                requestModifier: { $0.timeoutInterval = self.maxWaitTime }
            )
            .responseData { response in
                switch(response.result) {
                case let .success(data):
                    continuation.resume(returning: data)
                case let .failure(error):
                    continuation.resume(throwing: self.handleError(error: error))
                }
            }
        }
    }

    private func handleError(error: AFError) -> Error {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost
            {
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "Unable to connect to the server"
                let currentError = NSError(
                    domain: nserror.domain,
                    code: code,
                    userInfo: userInfo
                )
                return currentError
            }
        }
        return error
    }
}

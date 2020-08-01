//
//  API.swift
//  Shared
//
//  Created by Alex Littlejohn on 08/07/2020.
//  Copyright © 2020 zero. All rights reserved.
//

import Foundation

public func makeRequest() -> URLRequest {
    let url = URL(string: "https://icanhazdadjoke.com/")!
    var request = URLRequest(url: url)
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("Jokes iOS app (https://github.com/alittlejohn/jokes)", forHTTPHeaderField: "User-Agent")
    return request
}

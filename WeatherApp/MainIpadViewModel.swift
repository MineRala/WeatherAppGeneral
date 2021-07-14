//
//  MainIpadViewModel.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 14.07.2021.
//

import Foundation
import Combine

class MainIpadViewModel {
    private(set) var currentWeather: List!
    private var cancellables = Set<AnyCancellable>()
}

//
//  Rocket.swift
//  PortalGroupCase
//
//  Created by Atilla Çıtırık on 14.01.2025.
//

struct Rocket: Decodable{
    let rocket: RocketName?
    let price: Double?
    let launch_year: String?
    let links: LinkResponse?
    let details: String?
}



struct RocketName: Decodable {
    let rocket_id: String?
    let rocket_name: String?
}


struct LinkResponse: Decodable {
    let mission_patch: String?
}



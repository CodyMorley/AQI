//
//  Attribution.swift
//  FreshAir
//
//  Created by Cody Morley on 5/14/24.
//

import Foundation


struct Attribution: Codable {
    let url: String
    let name: String
    let logo: String?
}

extension Attribution {
    static let mockAttribution: Attribution = Attribution(url: "http://www.arb.ca.gov/",
                                                          name: "CARB - California Air Resources Board",
                                                          logo: "USA-CAARB.png")
    static let mockAttributions: [Attribution] = [Attribution(url: "http://www.arb.ca.gov/",
                                                              name: "CARB - California Air Resources Board",
                                                              logo: "USA-CAARB.png"),
                                                  Attribution(url: "http://www.aqmd.gov/",
                                                              name: "South Coast Air Quality Management District (AQMD)",
                                                              logo: "USA-SouthCoastAQMD.png"),
                                                  Attribution(url: "http://www.airnow.gov/",
                                                              name: "Air Now - US EPA",
                                                              logo: nil)]
}

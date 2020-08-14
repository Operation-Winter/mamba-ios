//
//  PlanningParticipantRowViewModel.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import UIKit

class PlanningParticipantRowViewModel: Identifiable {
    let participantName: String
    let votingValue: String?
    let votingImageName: String?
    let highlighted: Bool

    var borderWidth: CGFloat {
        highlighted ? 2 : 0
    }
    
    init(participantName: String, votingValue: String? = nil, votingImageName: String? = nil, highlighted: Bool = false) {
        self.participantName = participantName
        self.votingValue = votingValue
        self.highlighted = highlighted
        self.votingImageName = votingImageName
    }
}

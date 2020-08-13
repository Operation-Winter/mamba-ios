//
//  PlanningParticipantRowViewModel.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/13.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

class PlanningParticipantRowViewModel: Identifiable {
    let participantName: String
    let votingValue: String

    init(participantName: String, votingValue: String) {
        self.participantName = participantName
        self.votingValue = votingValue
    }
}

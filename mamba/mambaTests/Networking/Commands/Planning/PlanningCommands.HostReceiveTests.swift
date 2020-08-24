//
//  PlanningCommands_HostReceiveTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/24.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
@testable import Mamba

class PlanningCommands_HostReceiveTests: XCTestCase {
    
    func testNoneStateCommandDecoding() {
        // Given: mocked json
        let mockedJson = Mocks.noneState
        
        // When: JSON is mapped to a command
        guard
            let data = mockedJson.data(using: .utf8),
            let command = try? JSONDecoder().decode(PlanningCommands.HostReceive.self, from: data)
        else {
            XCTFail("Error thrown")
            return
        }
        
        // Then: The decoded value matches the expected value
        if case .noneState(let message) = command {
            XCTAssertEqual(message.sessionCode, Expected.stateMessage.sessionCode)
            XCTAssertEqual(message.sessionName, Expected.stateMessage.sessionName)
            XCTAssertEqual(message.availableCards, Expected.stateMessage.availableCards)
            
            XCTAssertEqual(message.participants.first?.id, Expected.stateMessage.participants.first?.id)
            XCTAssertEqual(message.participants.first?.name, Expected.stateMessage.participants.first?.name)
            XCTAssertEqual(message.participants.first?.selectedCard, Expected.stateMessage.participants.first?.selectedCard)
            
            XCTAssertEqual(message.ticket?.identifier, Expected.stateMessage.ticket?.identifier)
            XCTAssertEqual(message.ticket?.description, Expected.stateMessage.ticket?.description)
            
            XCTAssertEqual(message.ticket?.ticketVotes.first?.selectedCard, Expected.stateMessage.ticket?.ticketVotes.first?.selectedCard)
            XCTAssertEqual(message.ticket?.ticketVotes.first?.user.id, Expected.stateMessage.ticket?.ticketVotes.first?.user.id)
            XCTAssertEqual(message.ticket?.ticketVotes.first?.user.name, Expected.stateMessage.ticket?.ticketVotes.first?.user.name)
        } else {
            XCTFail("Wrong command has been mapped")
        }
    }
    
    func testVotingStateCommandDecoding() {
        // Given: mocked json
        let mockedJson = Mocks.votingState
        
        // When: JSON is mapped to a command
        guard
            let data = mockedJson.data(using: .utf8),
            let command = try? JSONDecoder().decode(PlanningCommands.HostReceive.self, from: data)
        else {
            XCTFail("Error thrown")
            return
        }
        
        // Then: The decoded value matches the expected value
        if case .votingState(let message) = command {
            XCTAssertEqual(message.sessionCode, Expected.stateMessage.sessionCode)
            XCTAssertEqual(message.sessionName, Expected.stateMessage.sessionName)
            XCTAssertEqual(message.availableCards, Expected.stateMessage.availableCards)
            
            XCTAssertEqual(message.participants.first?.id, Expected.stateMessage.participants.first?.id)
            XCTAssertEqual(message.participants.first?.name, Expected.stateMessage.participants.first?.name)
            XCTAssertEqual(message.participants.first?.selectedCard, Expected.stateMessage.participants.first?.selectedCard)
            
            XCTAssertEqual(message.ticket?.identifier, Expected.stateMessage.ticket?.identifier)
            XCTAssertEqual(message.ticket?.description, Expected.stateMessage.ticket?.description)
            
            XCTAssertEqual(message.ticket?.ticketVotes.first?.selectedCard, Expected.stateMessage.ticket?.ticketVotes.first?.selectedCard)
            XCTAssertEqual(message.ticket?.ticketVotes.first?.user.id, Expected.stateMessage.ticket?.ticketVotes.first?.user.id)
            XCTAssertEqual(message.ticket?.ticketVotes.first?.user.name, Expected.stateMessage.ticket?.ticketVotes.first?.user.name)
        } else {
            XCTFail("Wrong command has been mapped")
        }
    }
    
    func testFinishedVotingStateCommandDecoding() {
        // Given: mocked json
        let mockedJson = Mocks.finishedVotingState
        
        // When: JSON is mapped to a command
        guard
            let data = mockedJson.data(using: .utf8),
            let command = try? JSONDecoder().decode(PlanningCommands.HostReceive.self, from: data)
        else {
            XCTFail("Error thrown")
            return
        }
        
        // Then: The decoded value matches the expected value
        if case .finishedState(let message) = command {
            XCTAssertEqual(message.sessionCode, Expected.stateMessage.sessionCode)
            XCTAssertEqual(message.sessionName, Expected.stateMessage.sessionName)
            XCTAssertEqual(message.availableCards, Expected.stateMessage.availableCards)
            
            XCTAssertEqual(message.participants.first?.id, Expected.stateMessage.participants.first?.id)
            XCTAssertEqual(message.participants.first?.name, Expected.stateMessage.participants.first?.name)
            XCTAssertEqual(message.participants.first?.selectedCard, Expected.stateMessage.participants.first?.selectedCard)
            
            XCTAssertEqual(message.ticket?.identifier, Expected.stateMessage.ticket?.identifier)
            XCTAssertEqual(message.ticket?.description, Expected.stateMessage.ticket?.description)
            
            XCTAssertEqual(message.ticket?.ticketVotes.first?.selectedCard, Expected.stateMessage.ticket?.ticketVotes.first?.selectedCard)
            XCTAssertEqual(message.ticket?.ticketVotes.first?.user.id, Expected.stateMessage.ticket?.ticketVotes.first?.user.id)
            XCTAssertEqual(message.ticket?.ticketVotes.first?.user.name, Expected.stateMessage.ticket?.ticketVotes.first?.user.name)
        } else {
            XCTFail("Wrong command has been mapped")
        }
    }
    
    func testInvalidCommandDecoding() {
        // Given: mocked json
        let mockedJson = Mocks.invalidCommand
        
        // When: JSON is mapped to a command
        guard
            let data = mockedJson.data(using: .utf8),
            let command = try? JSONDecoder().decode(PlanningCommands.HostReceive.self, from: data)
        else {
            XCTFail("Error thrown")
            return
        }
        
        // Then: The decoded value matches the expected value
        if case .invalidCommand(let message) = command {
            XCTAssertEqual(message.code, Expected.invalidCommandMessage.code)
            XCTAssertEqual(message.description, Expected.invalidCommandMessage.description)
        } else {
            XCTFail("Wrong command has been mapped")
        }
    }
    
}

fileprivate class Mocks {
    static let noneState = """
    { "type": "NONE_STATE", "message": {
            "sessionCode": "000000", "sessionName": "Test", "availableCards": ["COFFEE"],
            "participants": [{ "id": "x", "name": "Test" }], "ticket": {
                "identifier": "x", "description":"Test", "ticketVotes": [{"user": { "id": "x", "name": "Test" }, "selectedCard": "COFFEE"}]
            }
        }
    }
    """
    
    static let votingState = """
    { "type": "VOTING_STATE", "message": {
            "sessionCode": "000000", "sessionName": "Test", "availableCards": ["COFFEE"],
            "participants": [{ "id": "x", "name": "Test" }], "ticket": {
                "identifier": "x", "description":"Test", "ticketVotes": [{"user": { "id": "x", "name": "Test" }, "selectedCard": "COFFEE"}]
            }
        }
    }
    """
    
    static let finishedVotingState = """
    { "type": "FINISHED_STATE", "message": {
            "sessionCode": "000000", "sessionName": "Test", "availableCards": ["COFFEE"],
            "participants": [{ "id": "x", "name": "Test" }], "ticket": {
                "identifier": "x", "description":"Test", "ticketVotes": [{"user": { "id": "x", "name": "Test" }, "selectedCard": "COFFEE"}]
            }
        }
    }
    """
    
    static let invalidCommand = """
    { "type": "INVALID_COMMAND", "message": { "code": "0", "description": "Test" } }
    """
}

fileprivate class Expected {
    static let stateMessage: PlanningSessionStateMessage = {
        let planningTicket = PlanningTicket(identifier: "x", description: "Test", ticketVotes: [PlanningTicketVote(user: PlanningParticipant(id: "x", name: "Test"), selectedCard: .coffee)])
        
        return PlanningSessionStateMessage(sessionCode: "000000", sessionName: "Test", availableCards: [.coffee], participants: [PlanningParticipant(id: "x", name: "Test")], ticket: planningTicket)
    }()
    
    static let invalidCommandMessage = PlanningInvalidCommandMessage(code: "0", description: "Test")
}

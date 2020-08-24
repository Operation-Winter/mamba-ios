//
//  PlanningCommands_HostSendTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/24.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
@testable import Mamba

class PlanningCommands_HostSendTests: XCTestCase {

    func testAddTicketCommandEncoding() {
        // Given: a mocked command
        let mockedCommand = Mocks.addTicket
        
        // When: Command is mapped to JSON
        guard let data = try? JSONEncoder().encode(mockedCommand) else {
            XCTFail("Error thrown")
            return
        }
        let jsonCommand = String(decoding: data, as: UTF8.self)
        
        // Then: The encoded value matches the expected value
        XCTAssertEqual(jsonCommand, Expected.addTicket)
    }
    
    func testStartSessionCommandEncoding() {
        // Given: a mocked command
        let mockedCommand = Mocks.startSession
        
        // When: Command is mapped to JSON
        guard let data = try? JSONEncoder().encode(mockedCommand) else {
            XCTFail("Error thrown")
            return
        }
        let jsonCommand = String(decoding: data, as: UTF8.self)
        
        // Then: The encoded value matches the expected value
        XCTAssertEqual(jsonCommand, Expected.startSession)
    }
    
    func testSkipVoteCommandEncoding() {
        // Given: a mocked command
        let mockedCommand = Mocks.skipVote
        
        // When: Command is mapped to JSON
        guard let data = try? JSONEncoder().encode(mockedCommand) else {
            XCTFail("Error thrown")
            return
        }
        let jsonCommand = String(decoding: data, as: UTF8.self)
        
        // Then: The encoded value matches the expected value
        XCTAssertEqual(jsonCommand, Expected.skipVote)
    }
    
    func testRemoveParticipantCommandEncoding() {
        // Given: a mocked command
        let mockedCommand = Mocks.removeParticipant
        
        // When: Command is mapped to JSON
        guard let data = try? JSONEncoder().encode(mockedCommand) else {
            XCTFail("Error thrown")
            return
        }
        let jsonCommand = String(decoding: data, as: UTF8.self)
        
        // Then: The encoded value matches the expected value
        XCTAssertEqual(jsonCommand, Expected.removeParticipant)
    }
    
    func testEndSessionCommandEncoding() {
        // Given: a mocked command
        let mockedCommand = Mocks.endSession
        
        // When: Command is mapped to JSON
        guard let data = try? JSONEncoder().encode(mockedCommand) else {
            XCTFail("Error thrown")
            return
        }
        let jsonCommand = String(decoding: data, as: UTF8.self)
        
        // Then: The encoded value matches the expected value
        XCTAssertEqual(jsonCommand, Expected.endSession)
    }
    
    func testFinishVotingCommandEncoding() {
        // Given: a mocked command
        let mockedCommand = Mocks.finishVoting
        
        // When: Command is mapped to JSON
        guard let data = try? JSONEncoder().encode(mockedCommand) else {
            XCTFail("Error thrown")
            return
        }
        let jsonCommand = String(decoding: data, as: UTF8.self)
        
        // Then: The encoded value matches the expected value
        XCTAssertEqual(jsonCommand, Expected.finishVoting)
    }
    
    func testReconnectCommandEncoding() {
        // Given: a mocked command
        let mockedCommand = Mocks.reconnect
        
        // When: Command is mapped to JSON
        guard let data = try? JSONEncoder().encode(mockedCommand) else {
            XCTFail("Error thrown")
            return
        }
        let jsonCommand = String(decoding: data, as: UTF8.self)
        
        // Then: The encoded value matches the expected value
        XCTAssertEqual(jsonCommand, Expected.reconnect)
    }
    
    func testRevoteCommandEncoding() {
        // Given: a mocked command
        let mockedCommand = Mocks.revote
        
        // When: Command is mapped to JSON
        guard let data = try? JSONEncoder().encode(mockedCommand) else {
            XCTFail("Error thrown")
            return
        }
        let jsonCommand = String(decoding: data, as: UTF8.self)
        
        // Then: The encoded value matches the expected value
        XCTAssertEqual(jsonCommand, Expected.revote)
    }

}

fileprivate class Mocks {
    static let addTicket: PlanningCommands.HostSend = {
        let message = PlanningAddTicketMessage(identifier: "x", description: "Test")
        return .addTicket(message)
    }()
    
    static let startSession: PlanningCommands.HostSend = {
        let message = PlanningStartSessionMessage(sessionName: "Test", availableCards: [PlanningCard.coffee])
        return .startSession(message)
    }()
    
    static let skipVote: PlanningCommands.HostSend = {
        let message = PlanningSkipVoteMessage(participantId: "x")
        return .skipVote(message)
    }()
    
    static let removeParticipant: PlanningCommands.HostSend = {
        let message = PlanningRemoveParticipantMessage(participantId: "x")
        return .removeParticipant(message)
    }()
    
    static let endSession = PlanningCommands.HostSend.endSession
    static let finishVoting = PlanningCommands.HostSend.finishVoting
    static let reconnect = PlanningCommands.HostSend.reconnect
    static let revote = PlanningCommands.HostSend.revote
}

fileprivate class Expected {
    static let addTicket = """
        {"type":"ADD_TICKET","message":{"description":"Test","identifier":"x"}}
        """
    
    static let startSession = """
        {"type":"START_SESSION","message":{"availableCards":["COFFEE"],"sessionName":"Test"}}
        """
    
    static let skipVote = """
        {"type":"SKIP_VOTE","message":{"participantId":"x"}}
        """
    
    static let removeParticipant = """
        {"type":"REMOVE_PARTICIPANT","message":{"participantId":"x"}}
        """
    
    static let endSession = """
        {"type":"END_SESSION"}
        """
    
    static let finishVoting = """
        {"type":"FINISH_VOTING"}
        """
    
    static let reconnect = """
        {"type":"RECONNECT"}
        """
    
    static let revote = """
        {"type":"REVOTE"}
        """
}

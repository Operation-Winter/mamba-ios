//
//  PlanningJoinSessionLandingViewModelTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/25.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
@testable import Mamba

class PlanningJoinSessionLandingViewModelTests: XCTestCase {
    var serviceUnderTest: PlanningJoinSessionLandingViewModel!
    var mockWebSocketHandler: MockWebSocketHandler!
    var mockService: MockPlanningSessionLandingService<PlanningCommands.JoinSend, PlanningCommands.JoinReceive>!
    
    override func setUpWithError() throws {
        mockService = .init(sessionURL: URLCenter.shared.webSocketBaseURL)
        let networkHandler = PlanningSessionNetworkHandler<PlanningCommands.JoinSend, PlanningCommands.JoinReceive>()
        mockWebSocketHandler = MockWebSocketHandler()
        networkHandler.configure(webSocket: mockWebSocketHandler)
        mockService.configure(sessionHandler: networkHandler)
        serviceUnderTest = PlanningJoinSessionLandingViewModel(sessionCode: "000000", participantName: "Test", service: mockService)
    }
    
    override func tearDownWithError() throws {
        serviceUnderTest = nil
        mockWebSocketHandler = nil
        mockService = nil
    }

    func testCommonInit() {
        // Then: sessionCode and participantName values are set
        XCTAssertEqual(serviceUnderTest.sessionCode, "000000")
        XCTAssertEqual(serviceUnderTest.participantName, "Test")
    }
    
    func testExecuteCommandNoneState() {
        // Given: a mocked command
        let mockedCommand = Mocks.noneState
        
        // When: execute the command
        serviceUnderTest.executeCommand(mockedCommand)
        
        // Then: the expected state is loaded and the message is parsed
        if case .none = serviceUnderTest.state {
            XCTAssertEqual(serviceUnderTest.participants.count, Mocks.stateMessage.participants.count)
            XCTAssertEqual(serviceUnderTest.participants.first?.id, Mocks.stateMessage.participants.first?.id)
            XCTAssertEqual(serviceUnderTest.participants.first?.name, Mocks.stateMessage.participants.first?.name)
            
            XCTAssertEqual(serviceUnderTest.sessionCode, Mocks.stateMessage.sessionCode)
            XCTAssertEqual(serviceUnderTest.sessionName, Mocks.stateMessage.sessionName)
            
            XCTAssertEqual(serviceUnderTest.availableCards, Mocks.stateMessage.availableCards)
            
            XCTAssertEqual(serviceUnderTest.ticket?.identifier, Mocks.stateMessage.ticket?.identifier)
            XCTAssertEqual(serviceUnderTest.ticket?.description, Mocks.stateMessage.ticket?.description)
            
            XCTAssertEqual(serviceUnderTest.participants.first?.skipped, false)
            XCTAssertEqual(serviceUnderTest.participants.first?.selectedCard, PlanningCard.coffee)
        } else {
            XCTFail("ViewModel has wrong state")
        }
    }
    
    func testExecuteCommandVotingState() {
        // Given: a mocked command
        let mockedCommand = Mocks.votingState
        
        // When: execute the command
        serviceUnderTest.executeCommand(mockedCommand)
        
        // Then: the expected state is loaded and the message is parsed
        if case .voting = serviceUnderTest.state {
            XCTAssertEqual(serviceUnderTest.participants.count, Mocks.stateMessage.participants.count)
            XCTAssertEqual(serviceUnderTest.participants.first?.id, Mocks.stateMessage.participants.first?.id)
            XCTAssertEqual(serviceUnderTest.participants.first?.name, Mocks.stateMessage.participants.first?.name)
            
            XCTAssertEqual(serviceUnderTest.sessionCode, Mocks.stateMessage.sessionCode)
            XCTAssertEqual(serviceUnderTest.sessionName, Mocks.stateMessage.sessionName)
            
            XCTAssertEqual(serviceUnderTest.availableCards, Mocks.stateMessage.availableCards)
            
            XCTAssertEqual(serviceUnderTest.ticket?.identifier, Mocks.stateMessage.ticket?.identifier)
            XCTAssertEqual(serviceUnderTest.ticket?.description, Mocks.stateMessage.ticket?.description)
            
            XCTAssertEqual(serviceUnderTest.participants.first?.skipped, false)
            XCTAssertEqual(serviceUnderTest.participants.first?.selectedCard, PlanningCard.coffee)
        } else {
            XCTFail("ViewModel has wrong state")
        }
    }
    
    func testExecuteCommandFinishedState() {
        // Given: a mocked command
        let mockedCommand = Mocks.finishedState
        
        // When: execute the command
        serviceUnderTest.executeCommand(mockedCommand)
        
        // Then: the expected state is loaded and the message is parsed
        if case .finishedVoting = serviceUnderTest.state {
            XCTAssertEqual(serviceUnderTest.participants.count, Mocks.stateMessage.participants.count)
            XCTAssertEqual(serviceUnderTest.participants.first?.id, Mocks.stateMessage.participants.first?.id)
            XCTAssertEqual(serviceUnderTest.participants.first?.name, Mocks.stateMessage.participants.first?.name)
            
            XCTAssertEqual(serviceUnderTest.sessionCode, Mocks.stateMessage.sessionCode)
            XCTAssertEqual(serviceUnderTest.sessionName, Mocks.stateMessage.sessionName)
            
            XCTAssertEqual(serviceUnderTest.availableCards, Mocks.stateMessage.availableCards)
            
            XCTAssertEqual(serviceUnderTest.ticket?.identifier, Mocks.stateMessage.ticket?.identifier)
            XCTAssertEqual(serviceUnderTest.ticket?.description, Mocks.stateMessage.ticket?.description)
            
            XCTAssertEqual(serviceUnderTest.participants.first?.skipped, false)
            XCTAssertEqual(serviceUnderTest.participants.first?.selectedCard, PlanningCard.coffee)
        } else {
            XCTFail("ViewModel has wrong state")
        }
    }
    
    func testExecuteCommandInvalidCommand() {
        // Given: a mocked command
        let mockedCommand = Mocks.invalidCommand
        
        // When: execute the command
        serviceUnderTest.executeCommand(mockedCommand)
        
        // Then: the expected state is loaded and the message is parsed
        if case .error(let error) = serviceUnderTest.state {
            XCTAssertEqual(error.code, "0")
            XCTAssertEqual(error.description, "Test")
        } else {
            XCTFail("ViewModel has wrong state")
        }
    }
    
    func testExecuteCommandInvalidSession() {
        // Given: a mocked command
        let mockedCommand = Mocks.invalidSession
        
        // When: execute the command
        serviceUnderTest.executeCommand(mockedCommand)
        
        // Then: the expected state is loaded and the message is parsed
        if case .error(let error) = serviceUnderTest.state {
            XCTAssertEqual(error.code, NSLocalizedString("PLANNING_INVALID_SESSION_ERROR_CODE", comment: "0001"))
            XCTAssertEqual(error.description, NSLocalizedString("PLANNING_INVALID_SESSION_ERROR_DESCRIPTION", comment: "Invalid session error description"))
        } else {
            XCTFail("ViewModel has wrong state")
        }
    }
    
    func testExecuteCommandRemoveParticipant() {
        // Given: a mocked command
        let mockedCommand = Mocks.removeParticipant
        
        // When: execute the command
        serviceUnderTest.executeCommand(mockedCommand)
        
        // Then: the expected state is loaded and the message is parsed
        XCTAssertTrue(serviceUnderTest.dismiss)
        XCTAssertEqual(mockService.closeCounter, 1)
    }
    
    func testExecuteCommandEndSession() {
        // Given: a mocked command
        let mockedCommand = Mocks.endSession
        
        // When: execute the command
        serviceUnderTest.executeCommand(mockedCommand)
        
        // Then: the expected state is loaded and the message is parsed
        XCTAssertTrue(serviceUnderTest.dismiss)
        XCTAssertEqual(mockService.closeCounter, 1)
    }
    
    func testSendJoinSessionCommand() {
        // Given: Zero send command calls have been made
        XCTAssertEqual(mockService.sendCommandCounter, 0)
        
        // When: command is sent
        serviceUnderTest.sendJoinSessionCommand()
        
        // Then: the service has send command called
        XCTAssertEqual(mockService.sendCommandCounter, 1)
    }
    
    func testSendLeaveSessionCommand() {
        // Given: Zero send command and close session calls have been made
        XCTAssertEqual(mockService.sendCommandCounter, 0)
        XCTAssertEqual(mockService.closeCounter, 0)
        
        // When: command is sent
        serviceUnderTest.sendLeaveSessionCommand()
        
        // Then: the service has send command called and close session called
        XCTAssertEqual(mockService.sendCommandCounter, 1)
        XCTAssertEqual(mockService.closeCounter, 1)
    }
    
    func testSendVoteCommandNoTicket() {
        // Given: Zero send command calls have been made
        XCTAssertEqual(mockService.sendCommandCounter, 0)
        
        // When: command is sent
        serviceUnderTest.sendVoteCommand(.coffee)
        
        // Then: the service has send command not called
        XCTAssertEqual(mockService.sendCommandCounter, 0)
    }
    
    func testSendVoteCommandWithTicket() {
        // Given: Zero send command calls have been made
        XCTAssertEqual(mockService.sendCommandCounter, 0)
        
        // When: command is sent
        serviceUnderTest.ticket = Mocks.ticket
        serviceUnderTest.sendVoteCommand(.coffee)
        
        // Then: the service has send command called
        XCTAssertEqual(mockService.sendCommandCounter, 1)
    }
}

fileprivate class Mocks {
    static let ticket = PlanningTicket(identifier: "x", description: "Test", ticketVotes: [PlanningTicketVote(user: PlanningParticipant(id: "x", name: "Test"), selectedCard: .coffee)])
    
    static let stateMessage: PlanningSessionStateMessage = PlanningSessionStateMessage(sessionCode: "000000", sessionName: "Test", availableCards: [.coffee], participants: [PlanningParticipant(id: "x", name: "Test")], ticket: ticket)
    
    static let noneState = PlanningCommands.JoinReceive.noneState(stateMessage)
    static let votingState = PlanningCommands.JoinReceive.votingState(stateMessage)
    static let finishedState = PlanningCommands.JoinReceive.finishedState(stateMessage)
    static let invalidCommand = PlanningCommands.JoinReceive.invalidCommand(PlanningInvalidCommandMessage(code: "0", description: "Test"))
    static let invalidSession = PlanningCommands.JoinReceive.invalidSession
    static let removeParticipant = PlanningCommands.JoinReceive.removeParticipant
    static let endSession = PlanningCommands.JoinReceive.endSession
}

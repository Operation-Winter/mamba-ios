//
//  PlanningJoinSessionLandingViewModelTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/25.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
import MambaNetworking
@testable import Mamba

class PlanningJoinSessionLandingViewModelTests: XCTestCase {
    var serviceUnderTest: PlanningJoinSessionLandingViewModel!
    var mockWebSocketHandler: MockWebSocketHandler!
    var mockService: MockPlanningSessionLandingService<PlanningCommands.JoinServerReceive, PlanningCommands.JoinServerSend>!
    
    override func setUpWithError() throws {
        mockService = .init(sessionURL: URLCenter.shared.webSocketBaseURL)
        let networkHandler = PlanningSessionNetworkHandler<PlanningCommands.JoinServerReceive, PlanningCommands.JoinServerSend>()
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
            
            XCTAssertEqual(serviceUnderTest.ticket?.title, Mocks.stateMessage.ticket?.title)
            XCTAssertEqual(serviceUnderTest.ticket?.description, Mocks.stateMessage.ticket?.description)
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
            
            XCTAssertEqual(serviceUnderTest.ticket?.title, Mocks.stateMessage.ticket?.title)
            XCTAssertEqual(serviceUnderTest.ticket?.description, Mocks.stateMessage.ticket?.description)
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
            
            XCTAssertEqual(serviceUnderTest.ticket?.title, Mocks.stateMessage.ticket?.title)
            XCTAssertEqual(serviceUnderTest.ticket?.description, Mocks.stateMessage.ticket?.description)
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
    static let ticket = PlanningTicket(title: "x", description: "Test", ticketVotes: [PlanningTicketVote(participantId: UUID(), selectedCard: .coffee)])
    
    static let stateMessage: PlanningSessionStateMessage = PlanningSessionStateMessage(sessionCode: "000000",
                                                                                       sessionName: "Test",
                                                                                       availableCards: [.coffee],
                                                                                       participants: [
                                                                                        PlanningParticipant(participantId: UUID(),
                                                                                                            name: "Test",
                                                                                                            connected: true)
                                                                                       ],
                                                                                       ticket: ticket,
                                                                                       timeLeft: nil)
    
    static let noneState = PlanningCommands.JoinServerSend.noneState(message: stateMessage)
    static let votingState = PlanningCommands.JoinServerSend.votingState(message: stateMessage)
    static let finishedState = PlanningCommands.JoinServerSend.finishedState(message: stateMessage)
    static let invalidCommand = PlanningCommands.JoinServerSend.invalidCommand(message: PlanningInvalidCommandMessage(code: "0", description: "Test"))
    static let invalidSession = PlanningCommands.JoinServerSend.invalidSession
    static let removeParticipant = PlanningCommands.JoinServerSend.removeParticipant
    static let endSession = PlanningCommands.JoinServerSend.endSession
}

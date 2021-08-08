//
//  PlanningHostSessionLandingViewModelTests.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/25.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
import MambaNetworking
@testable import Mamba

class PlanningHostSessionLandingViewModelTests: XCTestCase {
    var serviceUnderTest: PlanningHostSessionLandingViewModel!
    var mockWebSocketHandler: MockWebSocketHandler!
    var mockService: MockPlanningSessionLandingService<PlanningCommands.HostServerReceive, PlanningCommands.HostServerSend>!
    
    override func setUpWithError() throws {
        mockService = .init(sessionURL: URLCenter.shared.webSocketBaseURL)
        let networkHandler = PlanningSessionNetworkHandler<PlanningCommands.HostServerReceive, PlanningCommands.HostServerSend>()
        mockWebSocketHandler = MockWebSocketHandler()
        networkHandler.configure(webSocket: mockWebSocketHandler)
        mockService.configure(sessionHandler: networkHandler)
        serviceUnderTest = PlanningHostSessionLandingViewModel(sessionName: "Test", availableCards: PlanningCard.allCases, service: mockService)
    }
    
    override func tearDownWithError() throws {
        serviceUnderTest = nil
        mockWebSocketHandler = nil
        mockService = nil
    }

    func testCommonInit() {
        // Then: the session name and available cards are set
        XCTAssertEqual(serviceUnderTest.sessionName, "Test")
        XCTAssertEqual(serviceUnderTest.availableCards, PlanningCard.allCases)
    }

    func testSendStartSessionCommand() {
        // Given: zero commands have been sent
        XCTAssertEqual(mockService.sendCommandCounter, 0)
        
        // When: send a command
        serviceUnderTest.sendStartSessionCommand()
        
        // Then: command send has been called once
        XCTAssertEqual(mockService.sendCommandCounter, 1)
    }
    
    func testSendAddTicketCommand() {
        // Given: zero commands have been sent
        XCTAssertEqual(mockService.sendCommandCounter, 0)
        
        // When: send a command
        serviceUnderTest.sendAddTicketCommand(title: "x", description: "Test")
        
        // Then: command send has been called once
        XCTAssertEqual(mockService.sendCommandCounter, 1)
    }
    
    func testSendRevoteCommand() {
        // Given: zero commands have been sent
        XCTAssertEqual(mockService.sendCommandCounter, 0)
        
        // When: send a command
        serviceUnderTest.sendRevoteTicketCommand()
        
        // Then: command send has been called once
        XCTAssertEqual(mockService.sendCommandCounter, 1)
    }
    
    func testSendEndSessionCommand() {
        // Given: zero commands have been sent and zero sessions have been closed
        XCTAssertEqual(mockService.sendCommandCounter, 0)
        XCTAssertEqual(mockService.closeCounter, 0)
        
        // When: send a command
        serviceUnderTest.sendEndSessionCommand()
        
        // Then: command send has been called once and session closed
        XCTAssertEqual(mockService.sendCommandCounter, 1)
        XCTAssertEqual(mockService.closeCounter, 1)
    }
    
    func testSendFinishVotingCommand() {
        // Given: zero commands have been sent
        XCTAssertEqual(mockService.sendCommandCounter, 0)
        
        // When: send a command
        serviceUnderTest.sendFinishVotingCommand()
        
        // Then: command send has been called once
        XCTAssertEqual(mockService.sendCommandCounter, 1)
    }
    
    func testSendSkipParticipantCommand() {
        // Given: zero commands have been sent
        XCTAssertEqual(mockService.sendCommandCounter, 0)
        
        // When: send a command
        serviceUnderTest.sendSkipParticipantVoteCommand(participantId: UUID())
        
        // Then: command send has been called once
        XCTAssertEqual(mockService.sendCommandCounter, 1)
    }
    
    func testSendRemoveParticipantCommand() {
        // Given: zero commands have been sent
        XCTAssertEqual(mockService.sendCommandCounter, 0)
        
        // When: send a command
        serviceUnderTest.sendRemoveParticipantCommand(participantId: UUID())
        
        // Then: command send has been called once
        XCTAssertEqual(mockService.sendCommandCounter, 1)
    }
    
    func testRevoteDisabledNoneState() {
        // When: state is set to none
        serviceUnderTest.state = .none
        
        // Then: revote is disabled
        XCTAssertTrue(serviceUnderTest.revoteDisabled)
    }
    
    func testRevoteDisabledVotingState() {
        // When: state is set to voting
        serviceUnderTest.state = .voting
        
        // Then: revote is disabled
        XCTAssertTrue(serviceUnderTest.revoteDisabled)
    }
    
    func testRevoteDisabledFinishedVotingState() {
        // When: state is set to finishedVoting
        serviceUnderTest.state = .finishedVoting
        
        // Then: revote is enabled
        XCTAssertFalse(serviceUnderTest.revoteDisabled)
    }
    
    func testRevoteDisabledLoadingState() {
        // When: state is set to loading
        serviceUnderTest.state = .loading
        
        // Then: revote is disabled
        XCTAssertTrue(serviceUnderTest.revoteDisabled)
    }
    
    func testRevoteDisabledErrorState() {
        // When: state is set to error
        serviceUnderTest.state = .error(PlanningLandingError(code: "0", description: "Test"))
        
        // Then: revote is disabled
        XCTAssertTrue(serviceUnderTest.revoteDisabled)
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
    
    func testExecuteCommandNoneStateInitialShareModal() {
        // Given: a mocked command
        let mockedCommand = Mocks.noneState
        let asyncExpectation = expectation(description: "Async expectation")
        
        // When: execute the command
        serviceUnderTest.executeCommand(mockedCommand)
        
        // Then: the expected state is loaded and the message is parsed
        var results = [Bool]()
        let cancellable = serviceUnderTest.$showInitialShareModal.sink { showModal in
            results.append(showModal)
            
            if results == Expected.showModal {
                asyncExpectation.fulfill()
            }
        }
        
        wait(for: [asyncExpectation], timeout: 1.5)
        XCTAssertNotNil(cancellable)
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
    
    static let noneState = PlanningCommands.HostServerSend.noneState(message: stateMessage)
    static let votingState = PlanningCommands.HostServerSend.votingState(message: stateMessage)
    static let finishedState = PlanningCommands.HostServerSend.finishedState(message: stateMessage)
    static let invalidCommand = PlanningCommands.HostServerSend.invalidCommand(message: PlanningInvalidCommandMessage(code: "0", description: "Test"))
}

fileprivate class Expected {
    static let showModal = [false, true]
}

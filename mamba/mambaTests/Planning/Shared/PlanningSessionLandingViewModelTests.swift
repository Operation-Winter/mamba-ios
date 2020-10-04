//
//  PlanningSessionLandingViewModel.swift
//  mambaTests
//
//  Created by Armand Kamffer on 2020/08/24.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import XCTest
import MambaNetworking
@testable import Mamba

class PlanningSessionLandingViewModelTests: XCTestCase {
    var serviceUnderTest: PlanningSessionLandingViewModel<PlanningCommands.HostServerReceive, PlanningCommands.HostServerSend>!
    var mockWebSocketHandler: MockWebSocketHandler!
    var mockService: MockPlanningSessionLandingService<PlanningCommands.HostServerReceive, PlanningCommands.HostServerSend>!
    
    override func setUpWithError() throws {
        mockService = .init(sessionURL: URLCenter.shared.webSocketBaseURL)
        let networkHandler = PlanningSessionNetworkHandler<PlanningCommands.HostServerReceive, PlanningCommands.HostServerSend>()
        mockWebSocketHandler = MockWebSocketHandler()
        networkHandler.configure(webSocket: mockWebSocketHandler)
        mockService.configure(sessionHandler: networkHandler)
        serviceUnderTest = PlanningSessionLandingViewModel<PlanningCommands.HostServerReceive, PlanningCommands.HostServerSend>(service: mockService)
    }

    override func tearDownWithError() throws {
        serviceUnderTest = nil
        mockWebSocketHandler = nil
        mockService = nil
    }

    func testExecuteError() {
        // When: Error is executed on ViewModel
        serviceUnderTest.executeError(code: "0000", description: "Test")
        
        // Then: The decoded value matches the expected value
        if case .error(let error) = serviceUnderTest.state {
            XCTAssertEqual(error.code, "0000")
            XCTAssertEqual(error.description, "Test")
        } else {
            XCTFail("ViewModel has wrong state")
        }
    }
    
    func testConfigureAvailableCards() {
        // Given: The ViewModel has no assigned available cards
        XCTAssertEqual(serviceUnderTest.availableCards.count, 0)
        
        // When: Assign all PlanningCards
        serviceUnderTest.configure(availableCards: PlanningCard.allCases)
        
        // Then: the cards were assigned to availableCards
        XCTAssertEqual(serviceUnderTest.availableCards.count, PlanningCard.allCases.count)
    }
    
    func testConfigureSessionCode() {
        // Given: Session code initial value is an empty string
        XCTAssertEqual(serviceUnderTest.sessionCode, "")
        
        // When: Configure the session code
        serviceUnderTest.configure(sessionCode: "000000")
        
        // Then: the sessionCode matches the expected value
        XCTAssertEqual(serviceUnderTest.sessionCode, "000000")
    }
    
    func testConfigureParticipantName() {
        // Given: Participant name initial value is an empty string
        XCTAssertEqual(serviceUnderTest.participantName, "")
        
        // When: Configure the participant name
        serviceUnderTest.configure(participantName: "Test")
        
        // Then: the participantName matches the expected value
        XCTAssertEqual(serviceUnderTest.participantName, "Test")
    }
    
    func testToolbarHiddenErrorState() {
        // When: State is set to error
        serviceUnderTest.state = .error(PlanningLandingError(code: "000", description: "Test"))
        
        // Then: Toolbar is hidden
        XCTAssertEqual(serviceUnderTest.toolBarHidden, true)
    }
    
    func testToolbarHiddenLoadingState() {
        // When: State is set to loading
        serviceUnderTest.state = .loading
        
        // Then: Toolbar is hidden
        XCTAssertEqual(serviceUnderTest.toolBarHidden, true)
    }
    
    func testToolbarHiddenNoneState() {
        // When: State is set to none
        serviceUnderTest.state = .none
        
        // Then: Toolbar is not hidden
        XCTAssertEqual(serviceUnderTest.toolBarHidden, false)
    }
    
    func testToolbarHiddenVotingState() {
        // When: State is set to voting
        serviceUnderTest.state = .voting
        
        // Then: Toolbar is not hidden
        XCTAssertEqual(serviceUnderTest.toolBarHidden, false)
    }
    
    func testToolbarHiddenFinishedState() {
        // When: State is set to finishedVoting
        serviceUnderTest.state = .finishedVoting
        
        // Then: Toolbar is not hidden
        XCTAssertEqual(serviceUnderTest.toolBarHidden, false)
    }
    
    func testSendCommand() {
        // Given: send command has not been triggered
        XCTAssertEqual(mockService.sendCommandCounter, 0)
        
        // When: command is sent
        serviceUnderTest.sendCommand(.endSession(uuid: UUID()))
        
        // Then: Send command has been triggered once
        XCTAssertEqual(mockService.sendCommandCounter, 1)
    }
    
    func testCloseSession() {
        // Given: close session has not been triggered
        XCTAssertEqual(mockService.closeCounter, 0)
        
        // When: session is closed
        serviceUnderTest.closeSession()
        
        // Then: Close session has been triggered once
        XCTAssertEqual(mockService.closeCounter, 1)
    }
    
    func testShareSessionCodeValue() {
        // Given: Session code initial value is an empty string
        XCTAssertEqual(serviceUnderTest.shareSessionCode, "")
        
        // When: Configure the session code
        serviceUnderTest.configure(sessionCode: "000000")
        
        // Then: the shareSessionCode matches sessionCode
        XCTAssertEqual(serviceUnderTest.shareSessionCode, serviceUnderTest.sessionCode)
    }
    
    func testShareSessionLinkValue() {
        // When: Session code is set to 000000
        serviceUnderTest.configure(sessionCode: "000000")
        
        //Then: The share session link matches the expected URL
        XCTAssertEqual(serviceUnderTest.shareSessionLink, URLCenter.shared.planningJoinURL(sessionCode: "000000"))
    }
    
    func testParseStateMessage() {
        // Given: a mocked StateMessage
        let mockedStateMessage = Mocks.stateMessage
        
        // When: a state message is parsed
        serviceUnderTest.parseStateMessage(mockedStateMessage)
        
        // Then: the values are mapped as expected
        XCTAssertEqual(serviceUnderTest.participants.count, mockedStateMessage.participants.count)
        XCTAssertEqual(serviceUnderTest.participants.first?.id, mockedStateMessage.participants.first?.id)
        XCTAssertEqual(serviceUnderTest.participants.first?.name, mockedStateMessage.participants.first?.name)
        
        XCTAssertEqual(serviceUnderTest.sessionCode, mockedStateMessage.sessionCode)
        XCTAssertEqual(serviceUnderTest.sessionName, mockedStateMessage.sessionName)

        XCTAssertEqual(serviceUnderTest.availableCards, mockedStateMessage.availableCards)
        
        XCTAssertEqual(serviceUnderTest.ticket?.title, mockedStateMessage.ticket?.title)
        XCTAssertEqual(serviceUnderTest.ticket?.description, mockedStateMessage.ticket?.description)
    }
    
    func testBarGraphEntriesNoVotes() {
        // Then: There are no bar graph entries when there are no votes
        XCTAssertEqual(serviceUnderTest.barGraphEntries.count, 0)
    }
    
    func testBarGraphEntriesNoneState() {
        // Given: A mocked state message
        let mockedState = Mocks.barGraphStateMessage
        
        // When: The mocked state message is parsed and barGraphEntries are mapped
        serviceUnderTest.parseStateMessage(mockedState)
        let barGraphEntries = serviceUnderTest.barGraphEntries
        
        // Then: The values match expected
        XCTAssertEqual(barGraphEntries.count, 2)
        XCTAssertEqual(barGraphEntries.element(at: 0)?.count, 2)
        XCTAssertEqual(barGraphEntries.element(at: 0)?.title, "1")
        XCTAssertEqual(barGraphEntries.element(at: 1)?.count, 1)
        XCTAssertEqual(barGraphEntries.element(at: 1)?.title, "2")
    }

    func testParticipantListNoneState() {
        // Given: a mocked state message
        let mockedStateMessage = Mocks.participantsListStateMessage
        
        // When: the state is none and the mockedStateMessage is parsed
        serviceUnderTest.state = .none
        serviceUnderTest.parseStateMessage(mockedStateMessage)
        let participantsList = serviceUnderTest.participantList
        
        // Then: the list match expected values
        XCTAssertEqual(participantsList.count, 5)
        XCTAssertEqual(participantsList.element(at: 0)?.highlighted, false)
        XCTAssertNil(participantsList.element(at: 0)?.votingImageName)
        XCTAssertNil(participantsList.element(at: 0)?.votingValue)
        
        XCTAssertEqual(participantsList.element(at: 1)?.highlighted, false)
        XCTAssertNil(participantsList.element(at: 1)?.votingImageName)
        XCTAssertNil(participantsList.element(at: 1)?.votingValue)
        
        XCTAssertEqual(participantsList.element(at: 2)?.highlighted, false)
        XCTAssertNil(participantsList.element(at: 2)?.votingImageName)
        XCTAssertNil(participantsList.element(at: 2)?.votingValue)
        
        XCTAssertEqual(participantsList.element(at: 3)?.highlighted, false)
        XCTAssertNil(participantsList.element(at: 3)?.votingImageName)
        XCTAssertNil(participantsList.element(at: 3)?.votingValue)
        
        XCTAssertEqual(participantsList.element(at: 4)?.highlighted, false)
        XCTAssertNil(participantsList.element(at: 4)?.votingImageName)
        XCTAssertNil(participantsList.element(at: 4)?.votingValue)
    }
    
    func testParticipantListVotingState() {
        // Given: a mocked state message
        let mockedStateMessage = Mocks.participantsListStateMessage
        
        // When: the state is voting and the mockedStateMessage is parsed
        serviceUnderTest.state = .voting
        serviceUnderTest.parseStateMessage(mockedStateMessage)
        let participantsList = serviceUnderTest.participantList
    
        // Then: the list match expected values
        XCTAssertEqual(participantsList.count, 5)
        XCTAssertEqual(participantsList.element(at: 0)?.highlighted, false)
        XCTAssertEqual(participantsList.element(at: 0)?.votingImageName, "checkmark.circle")
        XCTAssertNil(participantsList.element(at: 0)?.votingValue)
        
        XCTAssertEqual(participantsList.element(at: 1)?.highlighted, false)
        XCTAssertEqual(participantsList.element(at: 1)?.votingImageName, "checkmark.circle")
        XCTAssertNil(participantsList.element(at: 1)?.votingValue)
        
        XCTAssertEqual(participantsList.element(at: 2)?.highlighted, false)
        XCTAssertEqual(participantsList.element(at: 2)?.votingImageName, "checkmark.circle")
        XCTAssertNil(participantsList.element(at: 2)?.votingValue)
        
        XCTAssertEqual(participantsList.element(at: 3)?.highlighted, false)
        XCTAssertEqual(participantsList.element(at: 3)?.votingImageName, "arrowshape.turn.up.right")
        XCTAssertNil(participantsList.element(at: 3)?.votingValue)
        
        XCTAssertEqual(participantsList.element(at: 4)?.highlighted, false)
        XCTAssertEqual(participantsList.element(at: 4)?.votingImageName, "rectangle.and.pencil.and.ellipsis")
        XCTAssertNil(participantsList.element(at: 4)?.votingValue)
    }
    
    func testParticipantListFinishedVotingState() {
        // Given: a mocked state message
        let mockedStateMessage = Mocks.participantsListStateMessage
        
        // When: the state is finishedVoting and the mockedStateMessage is parsed
        serviceUnderTest.state = .finishedVoting
        serviceUnderTest.parseStateMessage(mockedStateMessage)
        let participantsList = serviceUnderTest.participantList
        
        // Then: the list match expected values
        XCTAssertEqual(participantsList.count, 4)
        XCTAssertEqual(participantsList.element(at: 0)?.highlighted, true)
        XCTAssertNil(participantsList.element(at: 0)?.votingImageName)
        XCTAssertEqual(participantsList.element(at: 0)?.votingValue, "2")
        
        XCTAssertEqual(participantsList.element(at: 1)?.highlighted, false)
        XCTAssertNil(participantsList.element(at: 1)?.votingImageName)
        XCTAssertEqual(participantsList.element(at: 1)?.votingValue, "1")
        
        XCTAssertEqual(participantsList.element(at: 2)?.highlighted, false)
        XCTAssertNil(participantsList.element(at: 2)?.votingImageName)
        XCTAssertEqual(participantsList.element(at: 2)?.votingValue, "1")
        
        XCTAssertEqual(participantsList.element(at: 3)?.highlighted, false)
        XCTAssertEqual(participantsList.element(at: 3)?.votingImageName, "arrowshape.turn.up.right")
        XCTAssertNil(participantsList.element(at: 3)?.votingValue)
    }

    func testParticipantListErrorState() {
        // Given: a mocked state message
        let mockedStateMessage = Mocks.participantsListStateMessage
        
        // When: the state is error and the mockedStateMessage is parsed
        serviceUnderTest.state = .error(PlanningLandingError(code: "0000", description: "Test"))
        serviceUnderTest.parseStateMessage(mockedStateMessage)
        let participantsList = serviceUnderTest.participantList
        
        // Then: the list match expected values
        XCTAssertEqual(participantsList.count, 5)
        XCTAssertEqual(participantsList.element(at: 0)?.highlighted, false)
        XCTAssertNil(participantsList.element(at: 0)?.votingImageName)
        XCTAssertNil(participantsList.element(at: 0)?.votingValue)
        
        XCTAssertEqual(participantsList.element(at: 1)?.highlighted, false)
        XCTAssertNil(participantsList.element(at: 1)?.votingImageName)
        XCTAssertNil(participantsList.element(at: 1)?.votingValue)
        
        XCTAssertEqual(participantsList.element(at: 2)?.highlighted, false)
        XCTAssertNil(participantsList.element(at: 2)?.votingImageName)
        XCTAssertNil(participantsList.element(at: 2)?.votingValue)
        
        XCTAssertEqual(participantsList.element(at: 3)?.highlighted, false)
        XCTAssertNil(participantsList.element(at: 3)?.votingImageName)
        XCTAssertNil(participantsList.element(at: 3)?.votingValue)
        
        XCTAssertEqual(participantsList.element(at: 4)?.highlighted, false)
        XCTAssertNil(participantsList.element(at: 4)?.votingImageName)
        XCTAssertNil(participantsList.element(at: 4)?.votingValue)
    }

    func testParticipantListLoadingState() {
        // Given: a mocked state message
        let mockedStateMessage = Mocks.participantsListStateMessage
        
        // When: the state is loading and the mockedStateMessage is parsed
        serviceUnderTest.state = .loading
        serviceUnderTest.parseStateMessage(mockedStateMessage)
        let participantsList = serviceUnderTest.participantList
        
        // Then: the list match expected values
        XCTAssertEqual(participantsList.count, 5)
        XCTAssertEqual(participantsList.element(at: 0)?.highlighted, false)
        XCTAssertNil(participantsList.element(at: 0)?.votingImageName)
        XCTAssertNil(participantsList.element(at: 0)?.votingValue)
        
        XCTAssertEqual(participantsList.element(at: 1)?.highlighted, false)
        XCTAssertNil(participantsList.element(at: 1)?.votingImageName)
        XCTAssertNil(participantsList.element(at: 1)?.votingValue)
        
        XCTAssertEqual(participantsList.element(at: 2)?.highlighted, false)
        XCTAssertNil(participantsList.element(at: 2)?.votingImageName)
        XCTAssertNil(participantsList.element(at: 2)?.votingValue)
        
        XCTAssertEqual(participantsList.element(at: 3)?.highlighted, false)
        XCTAssertNil(participantsList.element(at: 3)?.votingImageName)
        XCTAssertNil(participantsList.element(at: 3)?.votingValue)
        
        XCTAssertEqual(participantsList.element(at: 4)?.highlighted, false)
        XCTAssertNil(participantsList.element(at: 4)?.votingImageName)
        XCTAssertNil(participantsList.element(at: 4)?.votingValue)
    }
   
}

fileprivate class Mocks {
    static let stateMessage: PlanningSessionStateMessage = {
        let planningTicket = PlanningTicket(title: "x", description: "Test", ticketVotes: [PlanningTicketVote(participantId: UUID(), selectedCard: .coffee)])
        
        return PlanningSessionStateMessage(sessionCode: "000000", sessionName: "Test", availableCards: [.coffee], participants: [PlanningParticipant(participantId: UUID(), name: "Test")], ticket: planningTicket)
    }()
    
    static let barGraphStateMessage: PlanningSessionStateMessage = {
        let planningTicket = PlanningTicket(title: "x", description: "Test", ticketVotes: [
            PlanningTicketVote(participantId: UUID(), selectedCard: .one),
            PlanningTicketVote(participantId: UUID(), selectedCard: .one),
            PlanningTicketVote(participantId: UUID(), selectedCard: .two),
            PlanningTicketVote(participantId: UUID(), selectedCard: nil),
        ])
        
        return PlanningSessionStateMessage(sessionCode: "000000", sessionName: "Test", availableCards: [.coffee], participants: [
            PlanningParticipant(participantId: UUID(), name: "Test"),
            PlanningParticipant(participantId: UUID(), name: "Test"),
            PlanningParticipant(participantId: UUID(), name: "Test"),
            PlanningParticipant(participantId: UUID(), name: "Test")
        ], ticket: planningTicket)
    }()
    
    static let participantsListStateMessage: PlanningSessionStateMessage = {
        let planningTicket = PlanningTicket(title: "x", description: "Test", ticketVotes: [
            PlanningTicketVote(participantId: UUID(), selectedCard: .one),
            PlanningTicketVote(participantId: UUID(), selectedCard: .one),
            PlanningTicketVote(participantId: UUID(), selectedCard: .two),
            PlanningTicketVote(participantId: UUID(), selectedCard: nil),
        ])
        
        return PlanningSessionStateMessage(sessionCode: "000000", sessionName: "Test", availableCards: [.coffee], participants: [
            PlanningParticipant(participantId: UUID(), name: "Test"),
            PlanningParticipant(participantId: UUID(), name: "Test"),
            PlanningParticipant(participantId: UUID(), name: "Test"),
            PlanningParticipant(participantId: UUID(), name: "Test"),
            PlanningParticipant(participantId: UUID(), name: "Test")
        ], ticket: planningTicket)
    }()
}

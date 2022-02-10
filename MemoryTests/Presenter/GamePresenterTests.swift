import XCTest
@testable import Memory

final class GamePresenterTests: XCTestCase {

    /// System under test: GamePresenter.swift
    var sut: GamePresenter!

    var interactor: MockInteractor!
    var view: MockViewController!
    var card: Card!

    override func setUp() {
        super.setUp()

        sut = GamePresenter()

        // Mock Interactor
        interactor = MockInteractor()
        sut.interactor = interactor
        sut.interactor?.presenter = sut

        // Mock View
        view = MockViewController()
        sut.view = view
        sut.view?.presenter = sut

        // Card
        card = Card(content: content)
    }

    // MARK: - Test game life cycle.
    func test_StartGameSuccess() {
        sut.startGame()
        XCTAssertTrue(view.gameStarted)
        XCTAssertTrue(interactor.gameStarted)
        XCTAssertNotNil(view.showMessage)
    }

    func test_StartGameFailed() {
        interactor.shouldFailToStartGame = true
        sut.startGame()
        XCTAssertFalse(view.gameStarted)
        XCTAssertFalse(interactor.gameStarted)
        XCTAssertNotNil(view.showError)
    }

    func test_FinishGame() {

        interactor.endGame()
        XCTAssertNotNil(view.showMessage)

        // Check that the game starts again after 3 seconds
        let startAgain = expectation(description: "Game should start after 3 seconds")

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) { [unowned self] in
            XCTAssertTrue(self.view.gameStarted)
            XCTAssertTrue(self.interactor.gameStarted)
            startAgain.fulfill()
        }
        wait(for: [startAgain], timeout: 4)
    }

    // MARK: - Test cards selection.
    func test_CardSelection() {
        sut.didSelect(card: card)
        XCTAssertNotNil(interactor.selectedCard)
        XCTAssertNotNil(view.showCards)
    }

    func test_MatchCards() {
        sut.didSelect(card: card)
        sut.didSelect(card: card)
        XCTAssertNotNil(view.showMessage)
        XCTAssertTrue(view.showCards?.count == 2)
    }

    func test_UnMatchCards() {
        sut.didSelect(card: card)
        sut.didSelect(card: Card(content: diferentContent))
        XCTAssertNotNil(view.hideCards)
    }

    func test_GetCardsForIndex() {
        XCTAssertNil(sut.card(at: -1))
    }

    func test_IndexOfCardSpecificCard() {
        XCTAssertNil(sut.index(for: Card(content: content)))
    }

    // MARK: - Errors
    func test_ShowError() {
        interactor.showError()
        XCTAssertNotNil(view.showError)
    }

}

// MARK: - Mocks
extension GamePresenterTests {

    class MockInteractor: GameInteractorInputProtocol {

        var presenter: GameInteractorOutputProtocol?
        var localDatamanager: GameLocalDataManagerInputProtocol?

        var selectedCard: Card?
        var gameStarted = false
        var shouldFailToStartGame = false

        func startGame(cardsAmount: Int) throws {
            if shouldFailToStartGame {
                throw TestError.test
            }
            gameStarted = true

            var cards = [Card]()
            for _ in 0...cardsAmount {
                cards.append(Card(content: content))
            }
            presenter?.gameDidStart(with: cards)
        }

        func didSelect(card: Card) {

            // Show only one cards
            guard let selectedCard = selectedCard else {
                self.selectedCard = card
                presenter?.show(cards: [card])
                return
            }

            // Show match
            if card.isMatch(of: selectedCard) {
                presenter?.show(cards: [card, selectedCard])
                presenter?.match()
            } else {
                // Show unmatch
                presenter?.hide(cards: [card, selectedCard])
                self.selectedCard = nil
            }

        }

        func index(for card: Card) -> Int? {
            if card.content.imageURL == URL(string: "http://www.google.com/")! {
                return 1
            }
            return nil
        }

        func card(at index: Int) -> Card? {
            switch index {
            case 1:
                return Card(content: content)
            default:
                return nil
            }
        }

        func endGame() {
            presenter?.gameDidFinish()
        }

        func showError() {
            presenter?.show(error: TestError.test)
        }

    }

    // MARK: - Mock View
    class MockViewController: GameViewProtocol {

        var presenter: GamePresenterProtocol?

        var gameStarted = false
        var showMessage: String?
        var showError: Error?
        var showCards: [Card]?
        var hideCards: [Card]?

        func reloadCollection() { gameStarted = true }
        func show(message: String) { showMessage = message }
        func show(content: String) { }
        func show(error: Error, completion: (() -> Void)?) { showError = error }
        func show(cards: [Card]) { showCards = cards }
        func hide(cards: [Card]) { hideCards = cards }
    }

}

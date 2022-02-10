import XCTest
@testable import Memory

final class GameInteractorTests: XCTestCase {

    /// System under test: GameInteractor.swift
    var sut: GameInteractor!

    var presenter: MockPresenter!
    var localDataManager: MockLocalDataManager!
    var card: Card!

    override func setUp() {
        super.setUp()
        sut = GameInteractor()
        presenter = MockPresenter()
        sut.presenter = presenter
        localDataManager = MockLocalDataManager()
        sut.localDatamanager = localDataManager

        // Card
        card = Card(content: content)
    }

    // MARK: - Game life cycle
    func test_StartGame() {
        startGame(cardsAmount: 2)
        XCTAssertTrue(presenter.gameStarted)
    }

    func test_StartGameFailed() {
        localDataManager.shouldFail = true
        do {
            try sut.startGame(cardsAmount: 2)
        } catch {
            XCTAssertNotNil(error)
            XCTAssertTrue(error is TestError)
        }
        XCTAssertFalse(presenter.gameStarted)
    }

    func test_StartGameWithCeroCards() {
        sut.localDatamanager = nil
        startGame(cardsAmount: 0)
        XCTAssertFalse(presenter.gameStarted)
    }

    func test_FinishGame() {
        startGame(cardsAmount: 2)
        sut.didSelect(card: card)
        sut.didSelect(card: card)
        XCTAssertTrue(presenter.gameFinished)
    }

    // MARK: - Match
    func test_MatchCards() {
        startGame(cardsAmount: 4)
        sut.didSelect(card: card)
        sut.didSelect(card: card)
        XCTAssertTrue(presenter.matchHappened)
    }

    func test_UnMatchCards() {

        let hideCardsAnimation = expectation(description: "Hide cards with 1 second of animation")

        startGame(cardsAmount: 2)
        sut.didSelect(card: card)
        sut.didSelect(card: Card(content: diferentContent))

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
            XCTAssertNotNil(self.presenter.hideCards)
            XCTAssertTrue(self.presenter.hideCards?.count == 2)
            hideCardsAnimation.fulfill()
        }
        wait(for: [hideCardsAnimation], timeout: 2.1)
    }

    func startGame(cardsAmount: Int) {
        do {
            try sut.startGame(cardsAmount: cardsAmount)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}

// MARK: - Mocks
extension GameInteractorTests {

    class MockPresenter: GameInteractorOutputProtocol {

        var gameStarted = false
        var gameFinished = false
        var matchHappened = false
        var hideCards: [Card]?

        func gameDidStart(with deck: [Card]) {
            gameStarted = true
        }

        func gameDidFinish() {
            gameFinished = true
        }

        func match() {
            matchHappened = true
        }

        func hide(cards: [Card]) {
            hideCards = cards
        }

        func show(cards: [Card]) { }
        func show(error: Error) { }

    }

    class MockLocalDataManager: GameLocalDataManagerInputProtocol {

        func fetchContent(amount: Int) throws -> [Content] {
            guard !shouldFail else {
                throw TestError.errorStartingGame
            }

            var output = [Content]()

            for _ in 0...amount {
                let player = Logo(
                    name: "swift",
                                  description: "programming language",
                                  image: "swift"
                )
                output.append(player)
            }

            return output
        }

        var shouldFail = false
    }

    enum TestError: Error {
        case errorStartingGame
    }

}


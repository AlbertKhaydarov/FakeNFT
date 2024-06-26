import Foundation

// MARK: - Protocol

protocol NftDetailPresenter {
    func viewDidLoad()
}

// MARK: - State

enum NftDetailState {
    case initial, loading, failed(Error), data(Nft)
}

final class NftDetailPresenterImpl: NftDetailPresenter {

    // MARK: - Properties

    weak var view: (any NftDetailView)?
    private let input: NftDetailInput
    private let service: any INftService
    private var state = NftDetailState.initial {
        didSet {
            stateDidChanged()
        }
    }

    // MARK: - Init

    init(
        input: NftDetailInput,
        service: some INftService
    ) {
        self.input = input
        self.service = service
    }

    // MARK: - Functions

    func viewDidLoad() {
        state = .loading
    }

    private func stateDidChanged() {
        switch state {
        case .initial:
            assertionFailure("can't move to initial state")
        case .loading:
            view?.showLoading()
            loadNft()
        case .data(let nft):
            view?.hideLoading()
            let cellModels = nft.images.map { NftDetailCellModel(url: URL(string: $0)) }
            view?.displayCells(cellModels)
        case .failed(let error):
            let errorModel = makeErrorModel(error)
            view?.hideLoading()
            view?.showError(errorModel)
        }
    }

    private func loadNft() {
        service.loadNft(id: input.id) { [weak self] nft in
            guard let nft else { return }
            self?.state = .data(nft)
        }
    }

    private func makeErrorModel(_ error: Error) -> ErrorModel {
        let message: String
        switch error {
        case is NetworkClientError:
            message = NSLocalizedString("Error.network", comment: "")
        default:
            message = NSLocalizedString("Error.unknown", comment: "")
        }

        let actionText = NSLocalizedString("Error.repeat", comment: "")
        return ErrorModel(message: message, actionText: actionText) { [weak self] in
            self?.state = .loading
        }
    }
}

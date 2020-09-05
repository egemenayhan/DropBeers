//
//  BeerListViewModel.swift
//  DropBeers
//
//  Created by Egemen Ayhan on 5.09.2020.
//

import  Foundation

struct BeerListState {

    enum Change {
        case loading
        case loaded
    }

}

class BeerListViewModel {

    private enum Constants {
        static let inputPath = "https://gist.githubusercontent.com/LuigiPapinoDrop/d8ed153d5431bbad23e1e1c6b5ba1e3c/raw/4ec1c8064e51838240e941679d3ac063460685c2/code_challenge_richer.txt"
    }

    typealias StateChangehandler = ((BeerListState.Change) -> Void)
    private var stateChangeHandler: StateChangehandler?
    private(set) var state: BeerListState

    init(state: BeerListState) {
        self.state = state
    }

    func addChangeHandler(handler: StateChangehandler?) {
        stateChangeHandler = handler
    }

    func fetchCustomerInput() {
        NetworkManager.shared.downloadFile(from: Constants.inputPath) { [weak self] (fileURL, error) in
            guard let self = self, let fileURL = fileURL else { return }
            self.readFile(at: fileURL)
        }
    }

    func readFile(at fileURL: URL) {
        do {
            let content = try String(contentsOfFile: fileURL.path, encoding: .utf8)
            print(content)
        } catch {
            print("\(error.localizedDescription)")
        }
    }

}

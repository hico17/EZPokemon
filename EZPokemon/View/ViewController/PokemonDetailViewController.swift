//
//  PokemonDetailViewController.swift
//  EZPokemon
//
//  Created by Luca Celiento on 01/11/2020.
//

import UIKit
import RxSwift

class PokemonDetailViewController: UIViewController {
    
    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .green
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        bindData()
    }
    
    // MARK: Private
    
    private var viewModel: PokemonDetailViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    private func bindData() {
        viewModel.name.bind(to: rx.title).disposed(by: disposeBag)
    }
}

// MARK: - CodeDesignable

extension PokemonDetailViewController: CodeDesignable {
    
    func addSubviews() {
        view.addSubview(tableView)
    }
    
    func addConstraints() {
        tableView.constraint(to: view)
    }
}

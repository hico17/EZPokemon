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
        viewModel.fetchData()
    }
    
    // MARK: Private
    
    private var viewModel: PokemonDetailViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.register(InformationsTableViewCell.self)
        tableView.register(HeaderTableViewCell.self)
        tableView.register(SpritesTableViewCell.self)
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    private func bindData() {
        viewModel.name.bind(to: rx.title).disposed(by: disposeBag)
        viewModel.dataSource.bind(to: tableView.rx.items) { tableView, index, dataSource -> UITableViewCell in
            switch dataSource {
            case .header(let header):
                let cell = tableView.dequeueReusableCell(HeaderTableViewCell.self, for: IndexPath(row: index, section: 0))
                cell.header = header
                return cell
            case .informations(let viewModel):
                let cell = tableView.dequeueReusableCell(InformationsTableViewCell.self, for: IndexPath(row: index, section: 0))
                cell.viewModel = viewModel
                return cell
            case .sprites(let viewModel):
                let cell = tableView.dequeueReusableCell(SpritesTableViewCell.self, for: IndexPath(row: index, section: 0))
                cell.viewModel = viewModel
                return cell
            case .abilities(let viewModel):
                return UITableViewCell()
            }
        }.disposed(by: disposeBag)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
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

// MARK: - UITableViewDelegate


extension PokemonDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let datasource = try? viewModel.dataSource.value()[indexPath.row] else {
            return UITableView.automaticDimension
        }        
        switch datasource {
        case .informations:
            return 120
        case .sprites:
            return 100
        default:
            return UITableView.automaticDimension
        }
    }
}

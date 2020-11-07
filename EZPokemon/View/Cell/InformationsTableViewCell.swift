//
//  InformationsTableViewCell.swift
//  EZPokemon
//
//  Created by Luca Celiento on 01/11/2020.
//

import Foundation
import Utilities
import RxSwift

class InformationsTableViewCell: UITableViewCell, Reusable {
    
    var viewModel: InformationsViewModel? {
        didSet {
            viewModel?.order.bind(to: orderValueLabel.rx.text).disposed(by: disposeBag)
            viewModel?.weight.bind(to: weightValueLabel.rx.text).disposed(by: disposeBag)
            viewModel?.height.bind(to: heightValueLabel.rx.text).disposed(by: disposeBag)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Private
    
    private enum Constants {
        static let labelFont = UIFont.systemFont(ofSize: 15, weight: .light)
        static let labelValueFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    private var disposeBag = DisposeBag()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var orderLabel: UILabel = {
        let label = UILabel()
        label.text = "ORDER"
        label.font = Constants.labelFont
        return label
    }()
    
    private lazy var orderValueLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.labelValueFont
        return label
    }()
    
    private lazy var orderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.text = "WEIGHT"
        label.font = Constants.labelFont
        return label
    }()
    
    private lazy var weightValueLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.labelValueFont
        return label
    }()
    
    private lazy var weightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.text = "HEIGHT"
        label.font = Constants.labelFont
        return label
    }()
    
    private lazy var heightValueLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.labelValueFont
        return label
    }()
    
    private lazy var heightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private func commonInit() {
        addSubviews()
        addConstraints()
    }
}

// MARK: - CodeDesignable

extension InformationsTableViewCell: CodeDesignable {
    
    func addSubviews() {
        contentView.addSubview(labelsStackView)
        orderStackView.addArrangedSubview(orderLabel)
        orderStackView.addArrangedSubview(orderValueLabel)
        labelsStackView.addArrangedSubview(orderStackView)
        weightStackView.addArrangedSubview(weightLabel)
        weightStackView.addArrangedSubview(weightValueLabel)
        labelsStackView.addArrangedSubview(weightStackView)
        heightStackView.addArrangedSubview(heightLabel)
        heightStackView.addArrangedSubview(heightValueLabel)
        labelsStackView.addArrangedSubview(heightStackView)
    }
    
    func addConstraints() {
        labelsStackView.constraint(to: contentView)
    }
}

//
//  HeaderView.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/04.
//

import RxSwift
import RxCocoa
import SnapKit
import UIKit

class MainHeaderView: UIView {
  private let disposeBag = DisposeBag()
  
  
  private lazy var logoLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  private lazy var searchButton: UIButton = {
    let button = UIButton()
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    
    attribute()
    layout()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


extension MainHeaderView {
  func bind (_ viewModel: MainHeaderViewModel) {
    searchButton.rx.tap.map { self.searchButton.tag }
      .bind(to: viewModel.searchButtonTapped)
      .disposed(by: disposeBag)
  }
}
private extension MainHeaderView {
  func attribute() {

    logoLabel.text = "PushPop"
    logoLabel.font = UIFont(name: "Snell Roundhand", size: 30.0)
    
    searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    searchButton.tintColor = .label
    
    searchButton.tag = 1
  }
  func layout() {
    [logoLabel, searchButton]
      .forEach { addSubview($0) }
    
    logoLabel.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(10)
      $0.leading.equalToSuperview().inset(30)
      $0.trailing.equalTo(searchButton.snp.leading).offset(-10)
    }
    searchButton.snp.makeConstraints {
      $0.top.trailing.bottom.equalToSuperview().inset(10)
      $0.width.equalTo(searchButton.snp.height)
    }
  }
}



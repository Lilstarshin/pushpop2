//
//  SearchView.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/04.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SearchHeaderView: UISearchBar {
  private let disposeBag = DisposeBag()
  private lazy var cancelButton: UIButton = {
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
extension SearchHeaderView {
  func bind(_ viewModel: SearchHeaderViewModel) {
    
    self.cancelButton.rx.tap
      .bind(to: viewModel.cancelButtonTapped)
      .disposed(by: disposeBag)
    
    self.rx.searchButtonClicked
      .debug()
      .bind(to: viewModel.searchButtonTapped)
      .disposed(by: disposeBag)
    
    self.rx.text
      .bind(to: viewModel.searchBarText)
      .disposed(by: disposeBag)
    
    viewModel.searchButtonTapped
      .asSignal()
      .emit(to: self.rx.endEditing)
      .disposed(by: disposeBag)
  }
}

extension Reactive where Base: SearchHeaderView {
  var endEditing: Binder<Void> {
    return Binder(base) { base, _ in
      base.endEditing(true)
    }
  }
}

private extension SearchHeaderView {
  func attribute() {
    cancelButton.setTitle("취소", for: .normal)
    cancelButton.setTitleColor(.label, for: .normal)
  }
  func layout() {
    addSubview(cancelButton)
    searchTextField.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(10)
      $0.top.bottom.equalToSuperview().inset(10)
      $0.trailing.equalTo(cancelButton.snp.leading)
    }
    cancelButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().inset(10)
      $0.width.equalTo(searchTextField.snp.height)
    }
  }
}

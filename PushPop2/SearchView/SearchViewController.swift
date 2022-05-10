//
//  SearchViewController.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/04.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SearchViewController: UIViewController {
  private let disposeBag = DisposeBag()
  private let viewModel = SearchViewModel()
  
  let serchBar = SearchHeaderView()
  let searchResultList = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bind(viewModel)
    attribute()
    layout()
  }
}

extension SearchViewController {
  func bind(_ viewModel: SearchViewModel) {
    self.serchBar.bind(viewModel.searchHeaderViewModel)
    
    viewModel.dismissView
      .emit(to: self.rx.dismissView)
      .disposed(by: disposeBag)
    
    viewModel.savedResultList
      .drive(self.searchResultList.rx.items) { tv, row, data in
        print("searchResultList cell : \(data)")
        let cell = tv.dequeueReusableCell(withIdentifier: "SearchResultListCell", for: IndexPath(row: row, section: 0)) as! SearchResultListCell
        
        cell.setData(data, idx: row)
        cell.bind(viewModel.searchResultListCellViewModel)
        return cell
      }
      .disposed(by: disposeBag)
    
  }
}

extension Reactive where Base: SearchViewController {
  var dismissView: Binder<Void> {
    return Binder(base) { base, Void in
      base.dismiss(animated: false)
    }
  }
}



private extension SearchViewController {
  func attribute() {
    view.backgroundColor = .white
    searchResultList.register(SearchResultListCell.self, forCellReuseIdentifier: "SearchResultListCell")
    searchResultList.separatorStyle = .none
  }
  func layout() {
    [serchBar, searchResultList]
      .forEach { view.addSubview($0) }
    serchBar.snp.makeConstraints {
      $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
      $0.height.equalTo(80.0)
    }
    searchResultList.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview()
      $0.top.equalTo(serchBar.snp.bottom)
    }
  }
}


//
//  SearchHeaderViewModel.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/08.
//

import RxCocoa
import RxSwift

struct SearchHeaderViewModel {

  // ViewModel -> View
  let shouldLoadResult: Observable<String>
  
  // View -> ViewModel
  let cancelButtonTapped = PublishRelay<Void>()
  let searchButtonTapped = PublishRelay<Void>()
  let searchBarText = PublishRelay<String?>()
  
  init() {
    self.shouldLoadResult = searchButtonTapped
      .withLatestFrom(searchBarText) { $1 ?? "" }
      .filter{ !$0.isEmpty }
      .distinctUntilChanged()
    
      
  }
}

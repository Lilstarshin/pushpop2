//
//  SubscriptionViewModel.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/04.
//

import RxSwift
import RxCocoa
 
struct SubscriptionViewModel {
  
  // global
  
  // subViewModels
  let mainHeaderViewModel = MainHeaderViewModel()
  
  
  // ViewModel -> View
  let presentView: Signal<Int>
  
  
  // View -> ViewModel
  
  
  
  init() {
    presentView = Observable
      .merge(
        mainHeaderViewModel.searchButtonTapped.asObservable()
      )
      .asSignal(onErrorJustReturn: 0)

  }
  
}

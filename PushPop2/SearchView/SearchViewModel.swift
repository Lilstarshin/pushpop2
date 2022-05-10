//
//  SearchViewModel.swift
//  PushPop2
//
//  Created by 신새별 on 2022/05/08.
//

import RxSwift
import RxCocoa
import Foundation

struct SearchViewModel {
  private let disposeBag = DisposeBag()
  
  // subViewModels
  let searchHeaderViewModel = SearchHeaderViewModel()
  let searchResultListCellViewModel = SearchResultListCellViewModel()
  
  // ViewModel -> View
  let dismissView: Signal<Void>
  let searchResultList: Driver<[SearchResultListCellData]>
  let savedResultList: Driver<[SearchResultListCellData]>
  let documents: Driver<[SearchResultListCellData]>
//  let mergeResultList: Driver<[SearchResultListCellData]>
  // View -> ViewModel
  
  private let youtubeChannelItemData = PublishSubject<[YoutubeChannelItem]>()
  
  init (model: SearchModel = SearchModel()) {
    // MARK: CoreData Fetch
    
    
    //MARK: Network
    let youtubeAPIChannelDataResult = searchHeaderViewModel.shouldLoadResult
      .debug()
      .flatMapLatest(model.getChannelData)
      .share()
    
    let youtubeAPIChannelDataValue = youtubeAPIChannelDataResult
      .compactMap { data -> YoutubeChannelData? in
        guard case let .success(value) = data else {
          return nil
        }
        return value
      }
    youtubeAPIChannelDataValue
      .map { $0.items }
      .bind(to: youtubeChannelItemData)
      .disposed(by: disposeBag)
    
    documents = youtubeAPIChannelDataValue
      .map {
        
        let a = model.mergeCoreDataAndApiData(
          core: model.channelDataFetch(),
          api: $0.items)
        print("TEST !!\(a)")
        return a
      }
      .asDriver(onErrorDriveWith: .empty())
      
    
    let coreDataSave = searchResultListCellViewModel.subscribeButtonTapped
      .withLatestFrom(youtubeAPIChannelDataValue) {
        print("TEST 1 \($1)")
        return $1.items.map(model.channelDataToCellData)[$0]
      }
      .map(model.channelDataInCoreData)
      .asDriver(onErrorDriveWith: .empty())
    
    searchResultList = coreDataSave
      .asObservable()
      .withLatestFrom(youtubeChannelItemData) {
        print("TEST 2\($0)")
        return model.mergeCoreDataAndApiData(core: $0, api: $1)
      }
      .asDriver(onErrorDriveWith: .empty())
  
    
    savedResultList = Observable.merge(
      documents
        .asObservable(),
      
      searchResultList
        .asObservable()
    ).asDriver(onErrorDriveWith: .empty())
    
      
    
    dismissView = searchHeaderViewModel.cancelButtonTapped
      .asSignal()
    
  }
}
